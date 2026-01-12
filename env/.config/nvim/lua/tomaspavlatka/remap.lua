vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>cfp", ":letj")

-- Copy the relative file path tothe clipboard register
vim.keymap.set("n", "<leader>cfp", function()
    local path = vim.fn.expand("%:~:.")
    vim.fn.setreg("+", path) 
    vim.notify('Copied relative path: ' .. path)
end, { desc = "Copy relative file path to clipboard" })


