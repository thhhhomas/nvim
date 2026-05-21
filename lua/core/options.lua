-- Substitui o caractere '~' no final do buffer por um espaço em branco
vim.opt.fillchars:append({ eob = ' ' })

-- Aumentando espaço do 'tab'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.diagnostic.config({
  signs = { 
    text = { 
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "●",
    },
  },
  underline = true,
  severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticSignError", {
  fg = "#ff0000",
  bg = "NONE",
  bold = true,
})

vim.api.nvim_set_hl(0, "DiagnosticSignWarn", {
  fg = "#ffaa00",
  bg = "NONE",
  bold = true,
})

vim.api.nvim_set_hl(0, "DiagnosticSignInfo", {
  fg = "#00aaff",
  bg = "NONE",
  bold = true,
})

vim.api.nvim_set_hl(0, "DiagnosticSignHint", {
  fg = "#00ff88",
  bg = "NONE",
  bold = true,
})

local diag = require("tiny-inline-diagnostic")

diag.disable()
