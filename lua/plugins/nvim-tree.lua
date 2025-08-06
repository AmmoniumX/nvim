return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    }
    -- Set keybinding for 'fe' using nvim-tree's built-in API
    vim.keymap.set('n', '<leader>fe', function()
      require('nvim-tree.api').tree.open()
    end, { noremap = true, silent = true })
  end,
}
