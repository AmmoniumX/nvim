vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.nvim' },
})
require("mini.pairs").setup()
require("mini.pick").setup()

vim.keymap.set('n', '<leader>ff', function()
    vim.cmd("Pick files")
end, { desc = 'Pick files' })

vim.keymap.set('n', '<leader>fg', function()
    vim.cmd("Pick grep_live")
end, { desc = 'Live Grep' })

vim.keymap.set('n', '<leader>fb', function()
    vim.cmd("Pick buffers")
end, { desc = 'Pick buffers' })
