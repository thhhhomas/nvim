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
        ensure_installed = { "lua_ls", "pyright", "omnisharp" },
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
            pythonPath = (function()
              local venv_names = { "venv", "env", ".venv", ".env" }
              for _, name in ipairs(venv_names) do
                local python_path = vim.fn.getcwd() .. "/" .. name .. "/bin/python"
                if vim.fn.executable(python_path) == 1 then
                  return python_path
                end
              end
              return "python"
            end)(),
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

