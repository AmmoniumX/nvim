vim.pack.add({
  "https://github.com/gutsavgupta/nvim-gemini-companion",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/snacks.nvim",
})

require("snacks").setup()
require("gemini").setup()
