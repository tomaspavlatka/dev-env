return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "j-hui/fidget.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp"
    }
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "intelephense"
      },
      handlers = {
        function(server_name)
          local opts = {
            capabilities = capabilities,
          }

          if server_name == "intelephense" then
            opts.settings = {
              intelephense = {
                environment = {
                  includePaths = {
                    "vendor/doctrine/orm/lib", -- for ORM attributes
                    "vendor/symfony",          -- general Symfony
                  },
                },
                files = {
                  maxSize = 5000000, -- in case you hit large file limits
                },
              },
            }
          elseif server_name == "lua_ls" then
            opts.settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            }
          end

          require("lspconfig")[server_name].setup(opts)
        end,
      }
    })


    vim.diagnostic.config({
      virtual_text = true, -- you can keep this true or false, up to you
      signs = true,        -- show signs in the gutter
      underline = true,    -- underline the problem
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Disable *automatic* popup on CursorHold
    vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])


    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-i>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-u>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      })
    })

    require("lsp_lines").setup()

    local opts = { buffer = false }
    vim.keymap.set('n', '<leader>gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<cr>', opts)
    vim.keymap.set('n', '<leader>gi', '<cmd>Telescope lsp_implementations<cr>', opts)
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>')
    vim.keymap.set('n', '<leader>se', require('lsp_lines').toggle, opts)
  end
}
