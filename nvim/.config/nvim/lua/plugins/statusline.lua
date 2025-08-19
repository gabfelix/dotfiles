return {
  'echasnovski/mini.statusline',
  opts = {
    use_icons = true,
  },
  config = function(opts)
    local statusline = require 'mini.statusline'
    statusline.setup(opts)
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
