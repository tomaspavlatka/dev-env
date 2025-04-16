return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    }
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  keys = {
    {
      '<leader>pf',
      function() require("telescope.builtin").find_files() end,
      mode = { "n" }
    },
    {
      '<leader>bf',
      function() require("telescope.builtin").buffers() end,
      mode = { "n" }
    },
    {
      '<leader>ff',
      function() require('telescope.builtin').git_files() end,
      mode = { "n" }
    },
    {
      '<leader>ps',
      function()
        local search = vim.fn.input("Grep: ");
        print("Search string: " .. search)
        require('telescope.builtin').grep_string({ search = search })
      end,
      mode = { "n" },
    },
  },
  opts = {
    defaults = {
      prompt_prefix = "? ",          -- Customize the prompt
      selection_caret = " ",
      path_display = { "truncate" }, -- Display file paths in truncated form
      sorting_strategy = "ascending",
    },
    pickers = {
      git_files = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
      }
    },
    extensions = {
    }
  },
  config = function()
  end,
}
