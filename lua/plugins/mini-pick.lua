return {
  "nvim-mini/mini.pick",
  version = false,
  lazy = false,
  opts = {},
  config = function(_, opts)

    local MiniPick = require("mini.pick")

    local map = require("utils").map
    local vscode_action = require("utils").vscode_action
    local pick_with_rg_config = require("utils").pick_with_rg_config

    MiniPick.setup(opts)

    -- Pick mappings
    map("n", "<leader>fb", vscode_action(
      MiniPick.builtin.buffers,
      "workbench.action.showAllEditors"
    ), "Pick buffers")

    map("n", "<leader>ff", vscode_action(
      MiniPick.builtin.files,
      "workbench.action.quickOpen"
    ), "Pick files")

    map("n", "<leader>fa", vscode_action(
      function()
        pick_with_rg_config(MiniPick.builtin.files, "no-ignore")
      end,
      ""
    ), "Pick files (all)")

    map("n", "<leader>gw", vscode_action(
      MiniPick.builtin.grep_live,
      "workbench.action.quickTextSearch"
    ), "Grep word")

    map("n", "<leader>lh", vscode_action(
      MiniPick.builtin.help,
      ""
    ), "Pick helps")
  end,
}
