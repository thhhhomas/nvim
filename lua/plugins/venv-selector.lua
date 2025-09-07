return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  opts = {
    search = {
      venvs = {
        command = "fd .venv$ .",
      },
      home_venvs = {
        command = "fd python$ ~/venvs",
      },
    },
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
