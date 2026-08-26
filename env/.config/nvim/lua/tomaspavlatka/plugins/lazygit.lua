-- Terminal UI for git
return {
  -- https://github.com/kdheepak/lazygit.nvim
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>lg", "<cmd>LazyGit<cr>", mode = { "n" }, desc = "Open lazygit" },
  },
}
