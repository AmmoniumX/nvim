return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = true,      -- Show diagnostic message as virtual text
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

      -- Set up Mason first
      require("mason").setup()
      
      -- Set up Mason-LSPConfig with servers to install
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ruff",
          "rust_analyzer",
          "pyright",
        },
        handlers = {
          -- The default handler that will be used for all LSP servers
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- You can specify custom handlers for specific servers
          -- Example:
          -- ["rust_analyzer"] = function()
          --   require("lspconfig").rust_analyzer.setup({
          --     capabilities = capabilities,
          --     -- Additional settings for rust_analyzer
          --   })
          -- end,
        },
      })

   end,
  },
}
