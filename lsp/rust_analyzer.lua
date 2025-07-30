return {
    cmd = { 'rust-analyzer' },

    root_markers = { 'Cargo.toml', 'rust-project.json', '.git/' },

    filetypes = { 'rust', 'rs' },

    settings = {
        inlayHints = {
            enable = true,
            bindingModeHints = { enable = true },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true },
            typeHints = { enable = true },
            parameterHints = { enable = true },
        }
    }
}
