return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function ()
    require("noice").setup({
      views = {
        mini = {
          win_options = {
            winblend = 0,
          }
        }
      }
    })

    require('notify').setup({
      background_colour = "#000000",
    })

    vim.notify = require("notify")
  end
}
