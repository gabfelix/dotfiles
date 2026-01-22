-- return {
--   'gabfelix/mudworld',
--   priority = 1000,
--   config = function()
--     require('mudworld').setup()
--     vim.o.background = 'dark'
--     vim.cmd.colorscheme 'mudworld'
--   end,
-- }
return {
  'navarasu/onedark.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      -- style = 'darker',
    }
    require('onedark').load()
  end,
}
-- return {
--   'ellisonleao/gruvbox.nvim',
--   priority = 1000,
--   config = function()
--     require('gruvbox').setup {
--       transparent_mode = true,
--     }
--     vim.opt.background = 'dark'
--     vim.cmd.colorscheme 'gruvbox'
--   end,
-- }
