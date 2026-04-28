-- Use default LSP configurations from nvim-lspconfig
vim.pack.add({{ src = 'https://github.com/neovim/nvim-lspconfig' }})
require('lspconfig')

vim.lsp.enable({'rust_analyzer', 'clangd', 'pyright', 'lua_ls', 'ts_ls', 'intelephense', 'copilot'})

-- Get the language server to recognize the `vim` global
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.lsp.inlay_hint.enable(true)
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone','noinsert','fuzzy','popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })

      -- Windows can't set keymaps to <C-Space>, so it uses <C-b> instead
      if vim.fn.has('unix') then
        -- Set key mapping for Linux and macOS
        vim.keymap.set('i', '<C-Space>', function()
          vim.lsp.completion.get()
        end)
      else
        -- Set key mapping for Windows
        vim.keymap.set('i', '<C-n>', function()
          vim.lsp.completion.get()
        end)
      end
    end

    if client:supports_method('textDocument/inlineCompletion') then
      vim.lsp.inline_completion.enable(true, { client_id = client.id })
    end
  end,
})

-- Configure diagnostics display
vim.opt.winborder = 'rounded'
vim.diagnostic.config({
  virtual_text = false,      -- Show diagnostic message as virtual text
  virtual_lines = true,     -- Show diagnostic message as virtual lines
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

-- Mappings --
local bufopts = { noremap=true, silent=true }

vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostics in a floating window' })

-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

-- Go to declaration
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

-- Find implementations
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

-- Find references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

-- Find type definition
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

-- Show hover documentation
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

-- Rename symbol
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

-- Show code actions
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

-- Show signature help
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

-- Navigate diagnostics
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Go to next diagnostic and show float' })

-- Tab to apply next inline completion suggestion, or insert a tab if there are no suggestions
vim.keymap.set({ "i", "n" }, "<tab>", function()
  if vim.lsp.inline_completion.get() then
    return ""
  end
  return "<tab>"
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })

-- Generate C++ Enum lookup tables
local function generate_cpp_enum_by_name(opts)
  local target_name = opts.args
  local bufnr = vim.api.nvim_get_current_buf()

  local parser = vim.treesitter.get_parser(bufnr, "cpp")
  local tree = parser:parse()[1]
  local root = tree:root()

  local find_query = vim.treesitter.query.parse("cpp", [[
    (enum_specifier
      (type_identifier) @enum_name
    ) @enum_node
  ]])

  local val_query = vim.treesitter.query.parse("cpp", "(enumerator (identifier) @val)")

  local found_enum = false
  local values = {}
  local insertion_line = 0

  local cap_idx = {}
  for i, name in ipairs(find_query.captures) do
    cap_idx[name] = i
  end

  for _, match, _ in find_query:iter_matches(root, bufnr, 0, -1) do
    local name_nodes = match[cap_idx["enum_name"]] or {}
    local name_node = name_nodes[1]
    if name_node and vim.treesitter.get_node_text(name_node, bufnr) == target_name then
      local enum_node = (match[cap_idx["enum_node"]] or {})[1]
      local _, _, end_row, _ = enum_node:range()
      insertion_line = end_row + 1

      for _, vn in val_query:iter_captures(enum_node, bufnr) do
        table.insert(values, vim.treesitter.get_node_text(vn, bufnr))
      end
      found_enum = true
      break
    end
  end

  if not found_enum then
    print(string.format("Error: Enum '%s' not found.", target_name))
    return
  end

  local out = {
    "",
    string.format("/* Generated: %s string conversion utils */", target_name),
    string.format("constexpr std::optional<const char*> enum_to_str(%s e) {", target_name),
    "  switch (e) {",
  }

  -- Iterate through all enum values and generate case statements
  for _, v in ipairs(values) do
    table.insert(out, string.format('    case %s::%s: return "%s";', target_name, v, v))
  end

  table.insert(out, '    default: return std::nullopt;')
  table.insert(out, "  }")
  table.insert(out, "}")
  table.insert(out, "")

  table.insert(out, string.format("inline constexpr std::optional<%s> str_to_enum(std::string_view sv) {", target_name))

  -- Iterate through all enum values and generate if statements for string to enum conversion
  for _, v in ipairs(values) do
    table.insert(out, string.format('  if (sv == "%s") return %s::%s;', v, target_name, v))
  end

  table.insert(out, "  return std::nullopt;")
  table.insert(out, "}")
  table.insert(out, "/* End generated utilities */")

  -- Use insertion_line (which is the line after the closing brace)
  vim.api.nvim_buf_set_lines(bufnr, insertion_line, insertion_line, false, out)
  print(string.format("Generated utilities for %s at line %d", target_name, insertion_line))
end

vim.api.nvim_create_user_command("GenerateEnumMappings", generate_cpp_enum_by_name, { nargs = 1 })
