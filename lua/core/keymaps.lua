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

---------------------------------------------------------------------------------------------
