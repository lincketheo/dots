-- Highlighting - https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlight
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- Incremental Selection - https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#incremental-selection
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
-- Indentation -
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
