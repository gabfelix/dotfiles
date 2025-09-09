return {
  '3rd/image.nvim',
  build = false,
  ft = 'markdown',
  cond = vim.fn.executable 'magick',
  config = function()
    require('image').setup {
      backend = 'kitty',
      processor = 'magick_cli',
      integrations = {
        markdown = {
          enabled = true,
          filetypes = { 'markdown' },
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = 'inline',
        },
      },
    }
  end,
}
