local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-p>", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>f", builtin.current_buffer_fuzzy_find, { desc = "Pesquisar neste arquivo" })
map("n", "<leader>]", ":tabnext<CR>")
map("n", "<leader>[", ":tabprev<CR>")
map("n", "<leader>q", ":tabclose<CR>")
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

