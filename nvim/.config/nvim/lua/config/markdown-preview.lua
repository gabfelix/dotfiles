local system_can_preview_markdown = function()
  return vim.fn.executable 'pandoc' == 1 and vim.fn.executable 'zathura' == 1 and vim.fn.executable 'pdflatex' == 1
end

local preview_markdown = function()
  if not system_can_preview_markdown() then
    error "Markdown preview dependencies not found ('pandoc' and 'zathura')"
  end
  if vim.bo.filetype ~= 'markdown' then
    error 'Buffer filetype is not markdown'
  end

  local filename = '/tmp/nvim-md-' .. os.time() .. '.md' -- Markdown file
  local file = io.open(filename, 'w')
  if file then
    local buf = vim.api.nvim_get_current_buf()
    local lines = (vim.api.nvim_buf_get_lines(buf, 0, -1, false))
    file:write(table.concat(lines, '\n'))
    file:close()
    vim.fn.system('pandoc -t pdf "' .. filename .. '" | zathura -')
  else
    print('Failed to save buffer contents to "' .. filename .. '"')
  end
end

if system_can_preview_markdown() then
  -- Create :PreviewMarkdown
  vim.api.nvim_create_user_command('PreviewMarkdown', preview_markdown, {})

  -- Register shortcut for it when opening markdown files
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      -- Set buffer-local keymap for Markdown
      vim.keymap.set('n', '<leader>p', preview_markdown, { buffer = true, desc = 'Preview Markdown' })
    end,
  })
end
