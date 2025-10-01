vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Source LSP config
require("config.lsp")

-- Source plugins
require("plugins.snacks")
require("plugins.nvim-tree")
require("plugins.nvim-treesitter")
require("plugins.nvim-gemini-companion")

vim.opt.clipboard = ''
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.conceallevel = 1
vim.o.ignorecase = true

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

-- Format C++ files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.cpp", "*.hpp" },
  callback = function()
      vim.cmd("!clang-format --style=llvm -i % ")
  end,
})

-- Configure split options
vim.opt.splitright = true
vim.opt.splitbelow = true
