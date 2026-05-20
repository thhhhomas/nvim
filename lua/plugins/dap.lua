return{
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    
    dap.adapters.coreclr = {
      type = 'executable',
      command = '/usr/local/bin/netcoredbg',
      args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          local pathDebug = vim.fn.getcwd() .. '/bin/Debug/'
          local dirs = vim.fn.readdir(pathDebug)

          return vim.fn.input('Path to dll', pathDebug .. dirs[1], 'file')
        end,
      },
    }

    dapui.setup({

    })

    dap.listeners.before.attach.dapui_config = function ()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function ()
      dapui.open()
    end
  end,
}
