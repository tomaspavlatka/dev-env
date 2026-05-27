return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "json",
            "lua",
            "markdown",
            "python",
            "typescript",
            "yaml",
        },
    },
}
