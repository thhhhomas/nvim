local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Definição da tecla <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


require("lazy").setup("plugins")
require("core.options")
require("core.keymaps")

vim.cmd("highlight Normal ctermbg=none guibg=none")

vim.cmd("highlight SignColumn guibg=none")

vim.opt.termguicolors = true
