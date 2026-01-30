return {
  on_attach = function(client, _)
    -- Reduce very long list of triggers for better 'mini.completion' experience
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':', '#', '(' }
  end,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') }, -- use LuaJIT (built into Neovim)
      workspace = {
        ignoreSubmodules = true,
        library = { vim.env.VIMRUNTIME }, -- Add neovim's methods
      },
    },
  },
}
