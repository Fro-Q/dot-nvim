if vim.g.vscode then
  return {}
else
  return {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {
      cursor_color = "#e0926d",
      stiffness = 0.3,
      trailing_stiffness = 0.1,
      damping = 0.5,
      trailing_exponent = 10,
      never_draw_over_target = true,
      hide_target_hack = true,
      gamma = 1,
      smear_insert_mode = true,
    },
    config = function(_, opts)

      local smear_cursor = require("smear_cursor")

      local map = require("utils").map
      local vscode_action = require("utils").vscode_action

      smear_cursor.setup(opts)

      ---@class table
      map("n", "<leader>xc", vscode_action(
        function()
          -- smear_cursor.enabled = not smear_cursor.enabled
          smear_cursor.toggle()
        end,
        ""
      ), "Toggle smear cursor")
    end
  }
end
