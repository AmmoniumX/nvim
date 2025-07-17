return {
    cmd = { 'rust-analyzer' },

    root_markers = { 'Cargo.toml', 'rust-project.json', '.git/' },

    filetypes = { 'rust', 'rs' },

    settings = {
        inlayHints = {
            enable = true,
        }
    }
}