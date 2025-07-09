return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
    -- Set keybinding for 'fm' using nvim-tree's built-in API
    vim.keymap.set('n', '<leader>fm', function()
      require('nvim-tree.api').tree.open()
    end, { noremap = true, silent = true })
  end,
}
