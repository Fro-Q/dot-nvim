if vim.g.vscode then
  return {}
else
  return {
    "saghen/blink.cmp",
    event = { "BufReadPost", "BufNewFile" },
    version = "1.*",
    dependencies = {
      {
        "xzbdmw/colorful-menu.nvim",
        config = function()
          require("colorful-menu").setup {
            ls = {
              lua_ls = { arguments_hl = "@comment" },
              fallback = true,
            },
            fallback_highlight = "@variable",
            max_width = 60,
          }
        end,
      },
      { "saghen/blink.compat" },
      { "Kaiser-Yang/blink-cmp-avante" },
      { "jc-doyle/cmp-pandoc-references" },
      { 'echasnovski/mini.snippets' },
    },
    config = function()
      require "configs.blink"
    end,
  }
end
