return{
  'zbirenbaum/copilot.lua',
  lazy = true,
  opts = {
    auto_attach = false,
    should_attach = function (_) return false end,
    suggestion = { 
      enabled = false,
      auto_trigger = true,
    },
    panel = { 
      layout = {
        position = "right",
        ratio = 0.5
      },
      enabled = true,
    },
  },
}
