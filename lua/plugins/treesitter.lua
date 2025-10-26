return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  opts = {
    ensure_installed = {
      "vim", "lua", "vimdoc", "html", "css", "typescript",
      "javascript", "vue", "json", "python", "markdown", "md", "diff"
    },
  },
}
