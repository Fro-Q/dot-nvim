if vim.g.vscode then
  return {}
else
  return {
    "nvim-mini/mini.indentscope",
    version = false,
    lazy = false,
    opts = {}
  }
end

