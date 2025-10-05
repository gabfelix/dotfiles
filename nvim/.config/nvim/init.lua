require 'config.base' -- Load this before anything else
require 'config.restow' -- Automatically redeploy nvim config
require 'config.lazy'
if vim.g.neovide then
  require 'config.neovide'
end
