local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>f", builtin.current_buffer_fuzzy_find, { desc = "Pesquisar neste arquivo" })
vim.keymap.set("n", "<leader>]", ":tabnext<CR>")
vim.keymap.set("n", "<leader>[", ":tabprev<CR>")
vim.keymap.set("n", "<leader>q", ":tabclose<CR>")
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
