vim.pack.add({
  "https://github.com/gutsavgupta/nvim-gemini-companion",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/snacks.nvim",
})

require("gemini").setup({
    cmds = { "gemini" }
})

vim.keymap.set('n', '<leader>gg', function()
    vim.cmd("GeminiToggle")
end, { desc = 'Toggle Gemini Cli' })

vim.keymap.set('t', '<C-X>', '<C-\\><C-N>', { desc = "Enter normal mode from terminal" })
