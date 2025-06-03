require("config.lazy")
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.conceallevel = 1
-- Restore default cursor on exit
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "set guicursor=a:ver25",
})
-- Format python files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
      vim.cmd("!ruff format %")
  end,
})
