return {
  "nvim-mini/mini.extra",
  version = false,
  lazy = false,
  config = function(_, opts)

    local MiniExtra = require("mini.extra")

    local map = require("utils").map
    local vscode_action = require("utils").vscode_action
    local vscode_call = require("utils").vscode_call

    MiniExtra.setup(opts)
    -- LSP mappings
    map("n", "glD", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "declaration"})
      end,
      "editor.action.peekDeclaration"
    ), "Goto declaration")

    map("n", "gld", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "definition"})
      end,
      "editor.action.peekDefinition"
    ), "Goto definition")

    map("n", "gli", vscode_call(
      function()
        MiniExtra.pickers.lsp({scope = "implementation"})
      end,
      "editor.action.peekImplementation"
    ), "Goto implementation")

    map("n", "glr", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "references"})
      end,
      "editor.action.referenceSearch.trigger"
    ), "Goto reference")

    map("n", "glt", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "type_definition"})
      end,
      "editor.action.peekTypeDefinition"
    ), "Goto type definition")

    map("n", "gls", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "document_symbol"})
      end,
      ""
    ), "Goto document symbol")

    map("n", "glS", vscode_action(
      function()
        MiniExtra.pickers.lsp({scope = "workspace_symbol"})
      end,
      ""
    ), "Goto workspace symbol")

    -- Other pickers
    map("n", "<leader>lk", vscode_action(
      MiniExtra.pickers.keymaps,
      ""
    ), "Pick keymaps")

    map("n", "<leader>dd", vscode_action(
      function()
        MiniExtra.pickers.diagnostic({scope = "current"})
      end,
      "workbench.panel.markers.view.focus"
    ), "Pick diagnostics")

    map("n", "<leader>fgc", vscode_action(
      function()
        MiniExtra.pickers.git_commits()
      end,
      "workbench.scm.history.focus"
    ), "Pick git commits")

    map("n", "<leader>fgh", vscode_action(
      function()
        MiniExtra.pickers.git_hunks()
      end,
      ""
    ), "Pick git hunks")

    map("n", "<leader>lH", vscode_action(
      function()
        MiniExtra.pickers.hl_groups()
      end,
      ""
    ), "Pick highlight groups")

    map("n", "<leader>cr", vscode_action(
      function()
        -- This will be handled by LSP
      end,
      "editor.action.rename"
    ), "Rename symbol")
  end,
}
