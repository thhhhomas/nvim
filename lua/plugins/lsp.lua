return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map('n', 'K', vim.lsp.buf.hover, opts)
        map('n', 'gd', vim.lsp.buf.definition, opts)
        map('n', 'gr', vim.lsp.buf.references, opts)
        map('n', '<leader>rn', vim.lsp.buf.rename, opts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup()

      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'pyright' },
      }

      local lspconfig = require('lspconfig')

      local servers = { 'lua_ls', 'pyright' }
      local function get_python_path(workspace)
        local venv_names = { 'venv', 'env', '.venv', '.env' }
        for _, name in ipairs(venv_names) do
          local python_path = workspace .. '/' .. name .. '/bin/python'
          if vim.fn.executable(python_path) == 1 then
            return python_path
          end
        end
        return 'python'
      end

      for _, server in ipairs(servers) do
        if server == 'pyright' then
          lspconfig[server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            
            settings = {
              python = {
                pythonPath = get_python_path(vim.fn.getcwd()),
                analysis = {
                  useLibraryCodeForTypes = true,
                  autoSearchPaths = true,
                  diagnosticMode = 'workspace',
                  typeCheckingMode = 'off',
                }
              }
            }
          }
        else
          lspconfig[server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
          }
        end
      end
    end,
  },
}

