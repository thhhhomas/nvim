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

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("enew")
      vim.bo.buftype = "nofile"
      vim.bobufhidden = "wipe"
      vim.bo.swapfile = false
      -- vim.bo.modifiable = false
      vim.bo.readonly = true
      vim.bo.filetype = "startup"

      local filepath = vim.fn.stdpath("config") .. "/startup.txt"
      local lines = {}

      local file = io.open(filepath, "r")
      if file then
        for line in file:lines() do
          table.insert(lines, line)
        end
        file:close()
      else
        lines = { "O arquivo startup.txt não foi aberto" }
      end

      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

      vim.cmd("NvimTreeToggle")
    end
  end,
})

vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = open_terminal_in_tab,
})

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if vim.bo.filetype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})


