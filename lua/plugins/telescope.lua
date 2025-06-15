return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },

      config = function()
        require('telescope').setup()

        local builtin = require('telescope.builtin')

        local map = vim.keymap.set
        local opt = { noremap = true, silent = true }

        -- <leader>ff -> Procurar arquivos (Find Files)
        map('n', '<leader>ff', builtin.find_files, opts)

        -- <leader>fg -> Procurar por texto no projeto (Live Grep)
        map('n', '<leader>fg', builtin.live_grep, opts)

        -- <leader>fb -> Listar e procurar nos buffers abertos
        map('n', '<leader>fb', builtin.buffers, opts)

        -- <leader>fh -> Procurar na ajuda do Neovim
        map('n', '<leader>fh', builtin.help_tags, opts)
      end,
}
