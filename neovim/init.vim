call plug#begin(stdpath('data') . '/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neovim/nvim-lspconfig'
Plug 'vim-airline/vim-airline'
Plug 'danymat/neogen'
Plug 'vim-autoformat/vim-autoformat'

" nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline' 
Plug 'hrsh7th/nvim-cmp'

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Common
colorscheme kanagawa-dragon
set foldmethod=manual

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Telescope 
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Autoformat
"" Autoformat on save
autocmd BufWritePre *.c,*.h Autoformat

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Tags
set statusline+=%{gutentags#statusline()}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" Setup Python
let g:python3_host_prog="/usr/bin/python3"
set tabstop=2
set shiftwidth=2
set expandtab
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""" LUA START
lua <<EOF
-------------------------------------------------------- Tree Sitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", 
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}

-------------------------------------------------------- Nvim Tree
-- disable netrw 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true


-- require("nvim-tree").setup({
--   sort = {
--     sorter = 'case_sensitive',
--     },
--   view = {
--     width = 30,
--   },
--   render = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

require("nvim-tree").setup({
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-------------------------------------------------------- web-devicons
require'nvim-web-devicons'.setup {
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 color_icons = true;
 default = true;
 strict = true;
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
 override_by_operating_system = {
  ["apple"] = {
    icon = "",
    color = "#A2AAAD",
    cterm_color = "248",
    name = "Apple",
  },
 };
}

-------------------------------------------------------- vim-vsnip and vim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) 
    end,
  },
  window = {
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, 
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, 
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-------------------------------------------------------- LSP Config

local lsp = require 'lspconfig'

-- C 
lsp.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_dir = lsp.util.root_pattern("compile_commands.json", ".git"),
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true }
    local map = vim.api.nvim_buf_set_keymap
    map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Auto-popup diagnostics
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end
    })
  end,
})

-- RUST
lsp.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}

-- Python
lsp.pyright.setup{}

-- GO
lsp.gopls.setup{}

-- Web 
-- lsp.tsserver.setup {}
lsp.jsonls.setup {}
lsp.cssls.setup {}
lsp.html.setup {}
lsp.leanls.setup{}
lsp.zls.setup{}

-- Go to the next error
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-------------------------------------------------------- Neogen
require('neogen').setup({
  languages = {
    ['cpp.doxygen'] = require('neogen.configurations.cpp')
  }
})

EOF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""" LUA END
