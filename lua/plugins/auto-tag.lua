return {
  "windwp/nvim-ts-autotag",
  ft = {
    "html", "javascript", "typescript", "javascriptreact", "typescriptreact",
    "vue", "svelte", "xml", "php", "astro"
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}

