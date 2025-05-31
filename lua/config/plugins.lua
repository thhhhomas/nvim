local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { 
    "catppuccin/nvim", name = "catppuccin", priority = 1000, 
    config = function() 
      require("config.plugins.catppuccin") 
    end 
  },
  { 
    "nvim-telescope/telescope.nvim", tag = "0.1.8", dependencies = { "nvim-lua/plenary.nvim" }, 
    config = function() 
      require("config.plugins.telescope") 
    end 
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.plugins.nvimtree")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      require("config.plugins.floaterm")
    end,
  },
  {
    "Zeioth/compiler.nvim",
  cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
  dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  opts = {},
  },
  { 
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.plugins.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "pyright" },
      }

      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- fonte de completions do LSP
      "hrsh7th/cmp-buffer",       -- completar pelo conteúdo do buffer
      "hrsh7th/cmp-path",         -- completar caminhos
      "hrsh7th/cmp-cmdline",      -- completar comandos
      "L3MON4D3/LuaSnip",         -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        })
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" }
        }
      })
    end,
  },
  {
    'numToStr/Comment.nvim',
    opts = {

    }
  }
})
