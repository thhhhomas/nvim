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

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
      end
    end,
  },
}

