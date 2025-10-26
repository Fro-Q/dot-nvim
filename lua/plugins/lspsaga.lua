return {
  "nvimdev/lspsaga.nvim",
  event = "BufReadPost",
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = { enable = false, show_file = false, color_mode = false },
      ui = { border = "single", code_action = "" },
      beacon = { enable = false },
      lightbulb = { virtual_text = false },
    })
  end,
}
