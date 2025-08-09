return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "omnisharp", "arduino_language_server", "clangd" },
      })

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
    	  python = {
            analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
          pythonPath = vim.g["venv_selector_virtual_env"] or vim.fn.exepath("python3"),
          },
        },
      })
      
      path_omnisharp = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/omnisharp/OmniSharp"

      lspconfig.omnisharp.setup({
        cmd = { path_omnisharp, "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        on_attach = on_attach,
        capabilities = capabilities,
      })
      
    end,
  },
}

