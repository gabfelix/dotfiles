-- Leader mappings don't go on the "remaps" module because they need to be set
-- before anything else
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('gabfelix.sets')
require('gabfelix.remaps')
require('gabfelix.lazy') -- Package Manager
