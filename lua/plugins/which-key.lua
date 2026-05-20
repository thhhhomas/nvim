return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",

    plugins = {
      presets = {
        motions = true,
      }
    },

    win = {
      border = "rounded",
      width = 50,
      height = { min = 4, max = 65 },
      padding = { 1, 2 },
      col = vim.o.columns,
    },

    layout = {
      width = { min = 20, max = 40 },
      spacing = 2,
    },

    keys = {
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
  },
}
