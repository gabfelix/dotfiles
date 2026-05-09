vim.g.neovide_opacity = 0.84
vim.g.neovide_scroll_animation_length = 0
vim.g.neovide_cursor_animation_length = 0
local is_windows = vim.fn.has 'win32'
vim.o.guifont = (is_windows and 'JetBrains Mono' or 'DejaVu Sans Mono') .. ':h13'
