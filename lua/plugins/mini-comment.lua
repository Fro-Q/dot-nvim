return {
  "nvim-mini/mini.comment",
  version = false,
  lazy = false,
  opts = {
    options = {
      ignore_blank_line = true,
    }
  },
  config = function(_, opts)

    local MiniComment = require("mini.comment")

    local map = require("utils").map

    MiniComment.setup(opts)

    -- Key map
    map("n", "<leader>/", "gcc", { desc ="Comment", remap = true })
    map("v", "<leader>/", "gc", { desc ="Comment", remap = true })
  end
}
