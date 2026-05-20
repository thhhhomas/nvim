return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 100,
  config = function ()
    require("tiny-inline-diagnostic").setup({
      preset = "minimal",
      options = {
        add_messages = {
          -- display_count = true,
        },
        multilines = {
          enabled = true,
        },
      },
      signs = {
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end
}
