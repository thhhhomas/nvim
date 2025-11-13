return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {

  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function ()
    require('noice').setup()

    require('notify').setup({
      background_colour = "#000000",
    })

    vim.notify = require('notify')
  end
}
