vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

require("nvim-tree").setup {
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
}
-- Set keybinding for 'fe'
vim.keymap.set('n', '<leader>fe', function()
  require('nvim-tree.api').tree.open()
end, { noremap = true, silent = true })
