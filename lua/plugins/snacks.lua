vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local Snacks = require("snacks")
Snacks.setup()

vim.keymap.set('n', '<leader>ff', function()
    Snacks.picker.pick("files")
end, { desc = 'Pick files' })

vim.keymap.set('n', '<leader>fg', function()
    Snacks.picker.pick("grep")
end, { desc = 'Live Grep' })

vim.keymap.set('n', '<leader>fb', function()
    Snacks.picker.pick("buffers")
end, { desc = 'Pick buffers' })
