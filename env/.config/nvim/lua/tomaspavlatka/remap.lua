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

-- Copy the relative file path to the clipboard register
vim.keymap.set("n", "<leader>cfp", function()
    local path = vim.fn.expand("%:~:.")
    vim.fn.setreg("+", path) 
    vim.notify('Copied relative path: ' .. path)
end, { desc = "Copy relative file path to clipboard" })

-- Drop *.spec.ts entries from the current quickfix list
local function qf_entry_name(item)
    if item.bufnr and item.bufnr > 0 and vim.api.nvim_buf_is_valid(item.bufnr) then
        return vim.api.nvim_buf_get_name(item.bufnr)
    end
    return item.filename or ""
end

vim.api.nvim_create_user_command("QFRemoveSpecs", function()
    local qf = vim.fn.getqflist({ items = 0, title = 0 })
    local kept = vim.tbl_filter(function(item)
        return not qf_entry_name(item):match("%.spec%.ts$")
    end, qf.items)

    local removed = #qf.items - #kept
    vim.fn.setqflist({}, "r", { items = kept, title = qf.title })
    vim.notify(("Removed %d spec entr%s"):format(removed, removed == 1 and "y" or "ies"))
end, { desc = "Drop .spec.ts entries from the quickfix list" })
