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
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }

    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)

    vim.keymap.set("n", "<C-?>", function()
      require("dapui").eval(nil, { enter = true })
    end)

    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<S-F11>", dap.step_out)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<S-F5>", function ()
      dap.terminate()
      dapui.close()
    end)
    vim.keymap.set("n", "<C-S-F5>", dap.restart)

    dap.listeners.before.attach.dapui_config = function ()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function ()
      dapui.open()
    end
    
  end,
}
