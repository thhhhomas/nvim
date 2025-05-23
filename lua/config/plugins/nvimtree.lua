require("nvim-tree").setup({
  actions = {
    open_file = {
      quit_on_open = false,
      
      resize_window = true,
      
      window_picker = {
        enable = false,
      },
    },
  },
  view = {
    width = 30,
    side = "left"
  }
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Abrir e fechar explorador de arquivos"})

local last_real_buffer = nil

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local ft = vim.bo.filetype
    if ft ~= "NvimTree" then
      last_real_buffer = vim.api.nvim_get_current_buf()
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      vim.keymap.set("n", "<CR>", function()
        local api = require("nvim-tree.api")
        local node = api.tree.get_node_under_cursor()
        
        if node and node.type == "file" then

          local target_path = vim.fn.fnamemodify(node.absolute_path, ":p")
          for tabnr = 1, vim.fn.tabpagenr('$') do
            local win_list = vim.fn.tabpagebuflist(tabnr)
            for _, buf in ipairs(win_list) do
              if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p") == target_path then
                vim.cmd(tabnr .. "tabnext")
                vim.fn.win_gotoid(vim.fn.bufwinid(buf))
                api.tree.close()
                return
              end
            end
          end

          local buf = vim.api.nvim_get_current_buf()
          local name = vim.api.nvim_buf_get_name(buf)
          local modified = vim.api.nvim_buf_get_option(buf, "modified")

          api.tree.close()   
          vim.cmd("tabedit " .. node.absolute_path)

          elseif node and node.type == "directory" then
            api.node.open.edit()
          end
        end, { buffer = true })

        --[[local tabnr = 1
        local win = vim.api.nvim_tabpage_get_win(vim.fn.tabpagewinnr(tabnr))
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        print("Buffer ativo na aba 1:", buf_name)
        if buf_name == "" then
          vim.cmd(tabnr .. "tabclose")
        end]]--

      end
    end,
  }
)

vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    local api = require("nvim-tree.api")

    if api.tree.is_visible() then
      api.tree.close()
    end
  end,
})

--[[vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    if vim.fn.tabpagenr('$') > 1 then
      local tabnr = 1
      local win = vim.api.nvim_tabpage_get_win(vim.fn.tabpagewinnr(tabnr))
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      --print("Buffer ativo na aba 1:", buf_name)
      if buf_name == "" then
        vim.cmd(tabnr .. "tabclose")
      end
    end
  end,
})]]--

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  callback = function()
    if vim.fn.tabpagenr('$') > 1 then
      local tabpages = vim.api.nvim_list_tabpages()
      local tab = tabpages[1] -- a primeira aba
      local win = vim.api.nvim_tabpage_get_win(tab)
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)

      if buf_name == "" then
        vim.cmd("1tabclose")
      end
    end
  end,
})
