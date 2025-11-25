return {
  "williamboman/mason.nvim",
  opts = {
  },
  dependencies = {
    "neovim/nvim-lspconfig",
    {
      "hrsh7th/cmp-nvim-lsp",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities();

        vim.lsp.config("*", {
          capabilities = capabilities
        });
      end,
    },
  }
}
