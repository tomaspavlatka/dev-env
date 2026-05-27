return {
  "williamboman/mason.nvim",
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    require("mason").setup()

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("pyright", {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
          },
        },
      },
      -- The 0.11 way to handle environment detection dynamically
      on_init = function(client)
        local project_venv = client.root_dir .. "/.venv/bin/python"
        if vim.fn.executable(project_venv) == 1 then
          client.config.settings.python.pythonPath = project_venv
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
      end,
    })

    -- 3. Configure TypeScript (ts_ls) using the new API
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "typescript", "typescriptreact" },
      capabilities = capabilities,
    })

    -- 4. Enable the servers globally
    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
  end,
}
