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

      -- Set up Mason
      require("mason").setup()
      
      -- Set up Mason-LSPConfig and servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true)
      end
      require("mason-lspconfig").setup({
        automatic_enable = true,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            inlayHints = {
              enable = true,
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true },
              typeHints = { enable = true },
              parameterHints = { enable = true },
            },
          },
        },
      })

      -- C++ configuration
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--offset-encoding=utf-16",
        },
        init_options = {
          fallbackFlags = { "-std=c++23" }, -- Set C++23 as the standard
          clangd = {
            fallbackFlags = { "-std=c++23" }, -- Redundant but safer for different clangd versions
          },
        },
        settings = {
          clangd = {
            arguments = {
              "--header-insertion=iwyu",
              "--background-index",
              "--clang-tidy",
              "--completion-style=detailed",
            },
          },
        },
      })

   end,
  },
}
