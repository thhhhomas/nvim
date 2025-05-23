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

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      
      vim.keymap.set("n", "<CR>", function()
        
        local api = require("nvim-tree.api")
        local node = api.tree.get_node_under_cursor()
        local is_draft = vim.fn.bufname("") == "" and vim.bo.buftype == ""
        
        if node and node.type == "file" then
          
          api.tree.close()

          local current_buf = vim.api.nvim_get_current_buf()
          local buffers = vim.api.nvim_list_bufs()

        
          for _, buf in ipairs(buffers) do
            if vim.api.nvim_buf_is_loaded(buf) then
              local name = vim.api.nvim_buf_get_name(buf)
              local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
              --local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
              local readonly = vim.api.nvim_buf_get_option(buf, "readonly")

              local is_draft = name == "" and buftype == "nofile" and readonly --and not modifiable
              if is_draft then
                vim.api.nvim_buf_delete(buf, { force = true })
              end
            end
          end

          vim.cmd("tabedit " .. node.absolute_path)
        
        elseif node and node.type == "directory" then
          api.node.open.edit()
        
        end
      end, { buffer = true })
    end
  end,
})

vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    local api = require("nvim-tree.api")
    if api.tree.is_visible() then
      api.tree.close()
    end
  end,
})
