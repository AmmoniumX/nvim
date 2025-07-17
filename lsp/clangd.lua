return {
    cmd = { 'clangd' },
    
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', '.git/' },
    
    settings = {
        clangd = {
            arguments = {
                "--header-insertion=iwyu",
                "--background-index",
                "--suggest-missing-includes",
                "--clang-tidy",
                "--completion-style=detailed",
            },
            fallbackFlags = { "-std=c++26" }, -- Set C++26 as the default standard
        },
    },

    filetypes = { 'c', 'cpp', 'h', 'hpp' },
}
