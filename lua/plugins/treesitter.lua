return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "python", "markdown", "markdown_inline", "html", "css" },
        highlight = {
          enable = true,
        },
      }
    end,
  }
}
