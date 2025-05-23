local function open_terminal_in_tab()
  vim.cmd("botright split")
  vim.cmd("resize 4")
  vim.cmd("terminal")
  vim.cmd("wincmd k")
end

local function open_explorador_arquivos()
  local is_draft = vim.fn.bufname("") == "" and vim.bo.buftype == ""
  if is_draft then
    vim.cmd("NvimTreeToggle")
  end
end
