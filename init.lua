require("config.lazy")
require("config.lsp")

vim.opt.clipboard = ''
vim.opt.number = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.conceallevel = 1

-- Format python files
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
      vim.cmd("!ruff format %")
  end,
})

-- Y/P to copy/paste into alternate registers
-- Normal mode: Yank a line into register z
vim.keymap.set('n', 'Y', '"zyy', { noremap = true, desc = 'Yank line to register z' })

-- Visual mode: Yank selection into register z
vim.keymap.set('v', 'Y', '"zy', { noremap = true, desc = 'Yank selection to register z' })

-- Normal mode: Paste from register z after cursor
vim.keymap.set('n', 'P', '"zp', { noremap = true, desc = 'Paste from register z' })

-- Visual mode: Paste from register z, replacing selection
vim.keymap.set('v', 'P', '"zp', { noremap = true, desc = 'Paste from register z (visual)' })


-- Configure split options
vim.opt.splitright = true
vim.opt.splitbelow = true
