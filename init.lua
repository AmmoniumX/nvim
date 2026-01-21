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

--- Format-On-Write ---

-- Create a variable to track the state
vim.g.writeformat_enabled = true

-- Function to set up the autocmds
local function setup_format_autocmds()
  -- Clear any existing autocmds in this group
  vim.api.nvim_create_augroup("WriteFormat", { clear = true })

  if vim.g.writeformat_enabled then
    -- Format python files
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "WriteFormat",
      pattern = "*.py",
      callback = function()
        vim.cmd("!ruff format %")
      end,
    })

    -- Format C++ files
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "WriteFormat",
      pattern = { "*.cpp", "*.hpp" },
      callback = function()
        vim.cmd("!clang-format --style=llvm -i %")
      end,
    })
  end
end

-- Initial setup
setup_format_autocmds()

-- Toggle command
vim.api.nvim_create_user_command("ToggleWriteFormat", function()
  vim.g.writeformat_enabled = not vim.g.writeformat_enabled
  setup_format_autocmds()
  print("Write format: " .. (vim.g.writeformat_enabled and "enabled" or "disabled"))
end, {})

-- Set command
vim.api.nvim_create_user_command("SetWriteFormat", function(opts)
  if opts.args == "on" then
    vim.g.writeformat_enabled = true
  elseif opts.args == "off" then
    vim.g.writeformat_enabled = false
  end
  setup_format_autocmds()
  print("Write format: " .. (vim.g.writeformat_enabled and "enabled" or "disabled"))
end, { nargs = 1, complete = function() return {"on", "off"} end })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
  if opts.args ~= "" then
    local names = vim.split(opts.args, "%s+")
    vim.pack.update(names)
  else
    -- Update all packages - pass empty list as first argument
    vim.pack.update({})
  end
end, { nargs = "*" })

-- Configure split options
vim.opt.splitright = true
vim.opt.splitbelow = true
