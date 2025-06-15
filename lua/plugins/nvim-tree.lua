return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup {}
    map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
    map('n', '<leader>0', ':NvimTreeFocus<CR>', opts)

  end,
}
