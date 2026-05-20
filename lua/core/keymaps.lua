-- Which key --------------------------------------------------------------------------------

local wk = require("which-key")
wk.add({
  { "<leader>c", group = " Copilot"},
  { "<leader>f", group = " Telescope"},
  { "<leader>0", hidden = true },
  { "<leader>d", group = " Debbuger"},
})

vim.keymap.set("n", "<leader>?", function ()
  wk.show({ keys = "" })
end, { desc = "Show geral keymaps" })

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

vim.keymap.set("n", "<leader>cc", des_ativar_copilot, { desc = "Copilot" })

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

vim.keymap.set("n", "<leader>cp", abrir_fechar_panel_copilot, { desc = "Toggle Copilot panel" })

---------------------------------------------------------------------------------------------

-- Telescope --------------------------------------------------------------------------------

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Open buffer list" }) 

-- <leader>ff -> Procurar arquivos (Find Files)
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)

-- <leader>fg -> Procurar por texto no projeto (Live Grep)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)

-- <leader>fb -> Listar e procurar nos buffers abertos
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)

-- <leader>fh -> Procurar na ajuda do Neovim
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)

-- Copiar p/ clipboard ----------------------------------------------------------------------

vim.keymap.set('v', '+y', '"+y', { desc = "Copy to clipboad", noremap = true, silent = true })

-- Buffer navigation ------------------------------------------------------------------------

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>z", "<cmd>bprev<CR>", { desc = "Previous buffer" })

-- Debbuger ---------------------------------------------------------------------------------

local dap, dapui = require("dap"), require("dapui")

vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)

vim.keymap.set("n", "<C-?>", function()
require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<leader>d<F5>", dap.continue, { desc = "Start debugging" })
vim.keymap.set("n", "<leader>d<F10>", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>d<F11>", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>d<S-F11>", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>d<S-F5>", function ()
  dap.terminate()
  dapui.close()
end, { desc = "Stop debugging"})
vim.keymap.set("n", "<leader>d<C-S-F5>", dap.restart, { desc = "Restart debugging" })

-- NvimTree --------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle file explorer", noremap = true, silent = true })
vim.keymap.set('n', '<leader>0', ':NvimTreeFocus<CR>', { desc = "Set focus on file explorer", noremap = true, silent = true })

-- Python Venv -----------------------------------------------------------------------------

vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select python virtual environment" })
vim.keymap.set("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select previously python virtual environment"})
