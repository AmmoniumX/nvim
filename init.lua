vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Source LSP config
require("config.lsp")

-- Source plugins
require("plugins.editor")
require("plugins.nvim-tree")
require("plugins.nvim-treesitter")
require("plugins.telescope")

vim.opt.clipboard = ''
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.conceallevel = 1

-- Enable treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'python', 'rust', 'lua' },
  callback = function() vim.treesitter.start() end,
})

-- Format python files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
      vim.cmd("!ruff format %")
  end,
})

-- Configure split options
vim.opt.splitright = true
vim.opt.splitbelow = true
