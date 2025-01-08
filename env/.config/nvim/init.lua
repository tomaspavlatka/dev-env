require("tomaspavlatka")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
});

local job_id = 0;
vim.keymap.set('n', '<leader>tm', function()
  vim.cmd.vnew();
  vim.cmd.term();
  vim.cmd.wincmd("J");
  vim.api.nvim_win_set_height(0, 10);

  job_id = vim.bo.channel
end)

vim.keymap.set('n', '<leader>fl', function()
  vim.fn.chansend(job_id, { "make format && make lint\r\n" });
end)
