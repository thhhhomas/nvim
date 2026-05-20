-- Definição da tecla <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Substitui o caractere '~' no final do buffer por um espaço em branco
vim.opt.fillchars:append({ eob = ' ' })

-- Aumentando espaço do 'tab'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.relativenumber = true

vim.opt.termguicolors = true

-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = '■',
--     spacing = 10,
--   },
--   severity_sort = true,
--   signs = false,
--   underline = true,
-- })
