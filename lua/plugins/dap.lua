return{
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapiu")

    require("mason-nvim-dap").setup({
      ensure_installed = { "netcoredbg" },
      handlers = {},
    })

    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode"},
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",

        program = function()
          return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. '/bin/Debug', 'file')
        end,
      },
    }

    vim.keymap.set("n", "<F2>", function() dap.continue() end)
    vim.keymap.set("n", "<F3>", function() dap.step_over() end)
    vim.keymap.set("n", "<F4>", function() dap.step_into() end)
    vim.keymap.set("n", "<F5>", function() dap.step_out() end)
    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
    vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
