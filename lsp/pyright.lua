return {
    cmd = { 'pyright-langserver', '--stdio' },

    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', '.git/' },

    filetypes = { 'python', 'py' },
}
