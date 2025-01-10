-- copy to system clipboard
vim.keymap.set({ "x", "v" }, "<C-c>", '"+y<Esc>')
vim.keymap.set("n", "<C-c>", '"+yy<Esc>')

-- Clear any highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<up>", "<C-w><C-w>", { desc = "Move focus to next window" })

-- Remove wezterm tab keymap
vim.keymap.set("n", "<C-t>", "")
vim.keymap.set("n", "<C-w>", "")

-- Page navigation
vim.keymap.set("n", "<C-d>", "10jzz", { desc = "Move down a page and center cursor" })
vim.keymap.set("n", "<C-u>", "10kzz", { desc = "Move up a page and center cursor" })

-- Search-replace (all the lefts to put the cursor in the correct position)
vim.keymap.set("n", "<leader>R", ":%s///gc<Left><Left><Left><Left>", { desc = "Search and [R]eplace" })

vim.keymap.set("n", "<leader>d", function()
  vim.lsp.buf.hover()
end, { desc = "[d]ocs" })
vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "[c]ode [a]ction " })
