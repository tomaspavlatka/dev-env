-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  keys = {
    {
      '<leader>pf',
      function() require("telescope.builtin").find_files() end,
      mode = { "n" }
    },
    {
      '<leader>fg',
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      mode = { "n" }
    },
    {
      '<leader>fh',
      function() require("telescope.builtin").help_tags() end,
      mode = { "n" }
    },
    {
      '<leader>fo',
      function() require("telescope.builtin").lsp_document_symbols() end,
      mode = { "n" }
    },
    {
      '<leader>fi',
      function() require("telescope.builtin").lsp_incoming_calls() end,
      mode = { "n" }
    },
    {
      '<leader>fm',
      function() require("telescope.builtin").treesitter({symbols={'function', 'method'}}) end,
      mode = { "n" }
    },
    {
      '<leader>ft',
      function()
        local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
        if not success or not node then return end;
        require('telescope.builtin').live_grep({search_dirs = {node.absolute_path}})
      end,
      mode = { "n" }
    },
    {
      '<leader>ps',
      function()
        local search = vim.fn.input("Grep: ");
        require('telescope').extensions.live_grep_args.live_grep_args({
          default_text = '"' .. search .. '"',
          use_regex = true
        })
      end,
      mode = { "n" },
    },
    {
      '<leader>pS',
      function()
        local word = vim.fn.expand("<cword>") -- Get the word under the cursor
        require('telescope').extensions.live_grep_args.live_grep_args({
          default_text = '"' .. word .. '"', -- Use the word as the default search text
          use_regex = true
        })
      end,
      mode = { "n" },
    },
  },
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        truncate = true,
        filename_first = {
          reverse_directories = true
        }
      },
    }
  }
}
