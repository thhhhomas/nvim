return{
  'voldikss/vim-floaterm',
  config = function()
    local opts = { noremap = true, silent = true }

    vim.g.floaterm_position = "center"
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    
    -- Abre o terminal com cd no projeto
    vim.keymap.set('n', '<leader>t', function() vim.cmd('FloatermToggle --cwd="cd ' .. vim.fn.expand('%:p:h') .. '"') end, opts)
    
    -- Fecha terminal
    vim.keymap.set('t', '<leader>tc', '<C-\\><C-n><cmd>FloatermToggle<CR>')

    -- Cria um novo termina
    vim.keymap.set('t', '<leader>tn', '<C-\\><C-n><cmd>FloatermNew<CR>')

    -- Avança para o próximo terminal
    vim.keymap.set('t', '<leader>tp', '<C-\\><C-n><cmd>FloatermNext<CR>')

    -- Volta para o terminal anterior
    vim.keymap.set('t', '<leader>ta', '<C-\\><C-n><cmd>FloatermPrev<CR>')

    -- Finaliza o terminal atual
    vim.keymap.set('t', '<leader>tk', '<C-\\><C-n><cmd>FloatermKill<CR>')
  end,
}
