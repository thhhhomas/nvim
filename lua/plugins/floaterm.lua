return{
  'voldikss/vim-floaterm',
  config = function()
    local opts = { noremap = true, silent = true }

    vim.g.floaterm_position = "center"
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    
    -- Abre o terminal com cd no projeto
    vim.keymap.set('n', '<F12>', function() vim.cmd('FloatermToggle --cwd="cd ' .. vim.fn.expand('%:p:h') .. '"') end, opts)
    
    -- Fecha terminal
    vim.keymap.set('t', '<F12>', '<C-\\><C-n><cmd>FloatermToggle<CR>')

    -- Cria um novo termina
    vim.keymap.set('t', '<F7>', '<C-\\><C-n><cmd>FloatermNew<CR>')

    -- Avança para o próximo terminal
    vim.keymap.set('t', '<F9>', '<C-\\><C-n><cmd>FloatermNext<CR>')

    -- Volta para o terminal anterior
    vim.keymap.set('t', '<F8>', '<C-\\><C-n><cmd>FloatermPrev<CR>')
  end,
}
