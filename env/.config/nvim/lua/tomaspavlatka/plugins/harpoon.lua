return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local line_marks = {}

    -- Add file and current line to Harpoon
    vim.keymap.set("n", "<leader>a", function()
      local file = vim.fn.expand("%:p")
      local line = vim.fn.line(".")
      line_marks[file] = line
      harpoon:list():add()
    end, { desc = "Harpoon Add File" })

    -- Select file and jump to saved line
    local function select_with_line(idx)
      harpoon:list():select(idx)
      vim.schedule(function()
        local file = vim.fn.expand("%:p")
        local line = line_marks[file]
        if line then
          vim.api.nvim_win_set_cursor(0, {line, 0})
        end
      end)
    end

    vim.keymap.set("n", "<C-h>", function() select_with_line(1) end, { desc = "Harpoon Select 1" })
    vim.keymap.set("n", "<C-j>", function() select_with_line(2) end, { desc = "Harpoon Select 2" })
    vim.keymap.set("n", "<C-k>", function() select_with_line(3) end, { desc = "Harpoon Select 3" })
    vim.keymap.set("n", "<C-l>", function() select_with_line(4) end, { desc = "Harpoon Select 4" })

    vim.keymap.set("n", "<leader>bf", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon Quick Menu" })
  end,
}
