-- C Language Server (clangd)
local lsp = require 'lspconfig'
lsp.clangd.setup{
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
    },
    filetypes = { "c", "cpp" },
}
lsp.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Web stuff - TODO - get this to work.
-- lsp.tailwindcss.setup {}
-- lsp.tsserver.setup {}
-- lsp.jsonls.setup {}
-- lsp.cssls.setup {}
-- lsp.html.setup {}
-- lsp.vuels.setup {}

-- Go to the next error
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-------------------------------------------------------- Neogen
require('neogen').setup({
  languages = {
    ['cpp.doxygen'] = require('neogen.configurations.cpp')
  }
})
