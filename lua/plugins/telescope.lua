return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },

      config = function()
        require('telescope').setup()

        local builtin = require('telescope.builtin')

        local map = vim.keymap.set
        local opt = { noremap = true, silent = true }


      end,
}
