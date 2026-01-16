-- Configurações de ativação do copilot -----------------------------------------------------

local copilot_ativo = false

des_ativar_copilot = function ()
  local copilot = require("copilot.suggestion")

  if  copilot_ativo then
    require("copilot.suggestion").dismiss()
    vim.cmd("Copilot disable") 
    vim.notify("Copilot desativado", vim.log.levels.INFO)
  
  else
    vim.cmd("Copilot enable")
    vim.notify("Copilot ativado", vim.log.levels.INFO)
  end
  
  copilot_ativo = not copilot_ativo
end

vim.keymap.set("n", "<leader>cp", des_ativar_copilot, { desc = "Ativar/Desativar Copilot" })

-- Panel do Copilot

local painel_aberto = false

abrir_fechar_panel_copilot = function ()
  if not copilot_ativo then
    vim.notify("Copilot está desativado", vim.log.levels.INFO)
    return
  end

  if not painel_aberto then
    vim.cmd("Copilot panel")

    painel_aberto = not painel_aberto
    vim.notify("Painel do Copilot", vim.log.levels.INFO)

    return 
  end 

  require("copilot.panel").toggle() 
  painel_aberto = not painel_aberto
  vim.notify(" ", vim.log.levels.INFO)

  return
end

vim.keymap.set("n", "<leader>pc", abrir_fechar_panel_copilot, { desc = "Abrir/Fechar painel do Copilot" })

---------------------------------------------------------------------------------------------

-- Buffers pelo Telescope -------------------------------------------------------------------

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Abrir lista de buffers" })

-- Copiar p/ clipboard ----------------------------------------------------------------------

vim.keymap.set('v', '+y', '"+y', { noremap = true, silent = true })

-- Buffer navigation ------------------------------------------------------------------------

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Ir para proximo buffer" })
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>", { desc = "Fechar o buffer atual" })
vim.keymap.set("n", "<leader>z", "<cmd>bprev<CR>", { desc = "Ir para buffer anterior" })
