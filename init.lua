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

-- Configure diagnostics display
vim.opt.winborder = 'rounded'
vim.diagnostic.config({
  virtual_text = true,      -- Show diagnostic message as virtual text
  virtual_lines = true,     -- Show diagnostic message as virtual lines
  signs = true,             -- Show diagnostic signs in the sign column
  underline = true,         -- Underline the text with an error
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true,     -- Sort diagnostics by severity
  float = {
    border = "rounded",     -- Add border to floating diagnostic window
    source = "always",      -- Always show source of the diagnostic
    header = "",            -- No header in the floating diagnostic window
    prefix = "",            -- No prefix for each diagnostic item
  },
})
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostics in a floating window' })

-- Configure split options
vim.o.splitright = true
vim.o.splitbelow = true
