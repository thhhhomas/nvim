local oil = require("oil")

oil.setup({
  keymaps = {
    ["<CR>"] = function()
      local entry = oil.get_cursor_entry()
      if not entry then return end

      if entry.type == "directory" then
        oil.select()
        return
      end

      local oil_win = vim.api.nvim_get_current_win()
      local entry_path = vim.fn.fnamemodify(oil.get_current_dir() .. entry.name, ":p")

      local found_win = nil
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_name(buf) == entry_path then
          found_win = win
          break
        end
      end

      if found_win then
        vim.api.nvim_win_close(oil_win, true)
        vim.api.nvim_set_current_win(found_win)
      else
        vim.cmd("tabedit " .. entry_path)
        vim.api.nvim_win_close(oil_win, true)
      end
    end,
  },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Abrir diretório atual" })

vim.keymap.set("n", "<leader>e", function()
  local oil_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, "filetype") == "oil" then
      oil_win = win
      break
    end
  end

  if oil_win then
    vim.api.nvim_win_close(oil_win, true)
  else
    vim.cmd("topleft vsplit")
    vim.cmd("vertical resize 25")
    oil.open()
  end
end, { desc = "Abrir Oil em uma barra lateral" })
