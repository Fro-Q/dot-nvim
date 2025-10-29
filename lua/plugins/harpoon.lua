return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()

    local harpoon = require("harpoon")
    local map = require("utils").map
    local vscode_action = require("utils").vscode_action

    -- Setup harpoon
    harpoon:setup()

    -- Harpoon mappings
    map("n", "<leader>xx", vscode_action(
      function()
        local marks = harpoon:list().items
        local current_file_path = vim.fn.expand("%:p:.")
        for _, item in ipairs(marks) do
          if item.value == current_file_path then
            harpoon:list():remove()
            return
          end
        end
        harpoon:list():add()
        require("incline").refresh()
      end,
      "vscode-harpoon.addEditor"
    ), "Harpoon buffer")

    map("n", "<leader><leader>", vscode_action(
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      "vscode-harpoon.editorQuickPick"
    ), "Harpoon list")

    -- Navigate between harpoon buffers
    map("n", "<S-l>", vscode_action(
      ":bnext",
      "workbench.action.nextEditorInGroup"
    ), "Buffer goto next")

    map("n", "<S-h>", vscode_action(
      ":bprev",
      "workbench.action.previousEditorInGroup"
    ), "Buffer goto prev")
  end,
}
