return {
  "nvim-mini/mini.bufremove",
  version = false,
  lazy = false,
  opts = {},
  config = function(_, opts)

    local MiniBufremove = require("mini.bufremove")

    local map = require("utils").map
    local vscode_action = require("utils").vscode_action

    MiniBufremove.setup(opts)

    map("n", "<leader>bd", vscode_action(
      MiniBufremove.delete,
      "workbench.action.closeActiveEditor"
    ), "Buffer delete")
  end
}
