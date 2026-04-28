vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git",
  "https://github.com/folke/sidekick.nvim",
})
require("nvim-treesitter-textobjects").setup()
require("sidekick").setup({
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
    },
    win = {
      --- CLI Tool Keymaps (default mode is `t` = terminal, `n` = normal)
      ---- Copied over from default config to here for self-documentation
      keys = {
        buffers       = { "<c-b>", "buffers"   , mode = "nt", desc = "open buffer picker" },
        files         = { "<c-f>", "files"     , mode = "nt", desc = "open file picker" },
        hide_n        = { "q"    , "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_q   = { "<c-q>", "hide"      , mode = "n" , desc = "hide the terminal window" },
        hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "hide the terminal window" },
        hide_ctrl_z   = { "<c-z>", "blur"      , mode = "nt", desc = "go back to the previous window without hiding the terminal" },
        prompt        = { "<c-p>", "prompt"    , mode = "t" , desc = "insert prompt or context" },
        stopinsert    = { "<c-q>", "stopinsert", mode = "t" , desc = "enter normal mode" },
        -- Navigate windows in terminal mode. Only active when:
        -- * layout is not "float"
        -- * there is another window in the direction
        -- With the default layout of "right", only `<c-h>` will be mapped
        nav_left      = { "<c-h>", "nav_left"  , expr = true, desc = "navigate to the left window" },
        nav_down      = { "<c-j>", "nav_down"  , expr = true, desc = "navigate to the below window" },
        nav_up        = { "<c-k>", "nav_up"    , expr = true, desc = "navigate to the above window" },
        nav_right     = { "<c-l>", "nav_right" , expr = true, desc = "navigate to the right window" },
      },
    },
  },
})

-- Disable Sidekick "Next Edit Suggestions"
vim.g.sidekick_nes = false

-- Keymaps
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function() require("sidekick.cli").focus() end, { desc = "Sidekick Focus" })
vim.keymap.set("n", "<leader>aa", function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle CLI" })
vim.keymap.set("n", "<leader>as", function() require("sidekick.cli").select() end, { desc = "Select CLI" })
vim.keymap.set("n", "<leader>ad", function() require("sidekick.cli").close() end, { desc = "Detach a CLI Session" })
vim.keymap.set({ "x", "n" }, "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, { desc = "Send This" })
vim.keymap.set("n", "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, { desc = "Send File" })
vim.keymap.set("x", "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, { desc = "Send Visual Selection" })
vim.keymap.set({ "n", "x" }, "<leader>ap", function() require("sidekick.cli").prompt() end, { desc = "Sidekick Select Prompt" })
vim.keymap.set("n", "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, { desc = "Sidekick Toggle Claude" })
