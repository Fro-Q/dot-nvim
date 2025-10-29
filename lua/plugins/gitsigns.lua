return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- signs = {
    --   add          = { text = '┃' },
    --   change       = { text = '┃' },
    --   delete       = { text = '_' },
    --   topdelete    = { text = '‾' },
    --   changedelete = { text = '~' },
    --   untracked    = { text = '┆' },
    -- },
    -- signs_staged = {
    --   add          = { text = '┃' },
    --   change       = { text = '┃' },
    --   delete       = { text = '_' },
    --   topdelete    = { text = '‾' },
    --   changedelete = { text = '~' },
    --   untracked    = { text = '┆' },
    -- },
    -- signs_staged_enable = true,
    signcolumn = false,
    numhl = true,
    -- linehl = false,
    -- word_diff = false,
    -- watch_gitdir = {
    --   follow_files = true
    -- },
    -- auto_attach = true,
    -- attach_to_untracked = false,
    -- current_line_blame = false,
    -- current_line_blame_opts = {
    --   virt_text = true,
    --   virt_text_pos = "eol",
    --   delay = 1000,
    --   ignore_whitespace = false,
    --   virt_text_priority = 100,
    --   use_focus = true,
    -- },
    -- current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    -- sign_priority = 6,
    -- update_debounce = 100,
    -- status_formatter = nil,
    -- max_file_length = 40000,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },

  },
  config = function(_, opts)

    local gs = require("gitsigns")

    local map = require("utils").map
    local vscode_action = require("utils").vscode_action

    gs.setup(opts)

    -- Navigation
    map("n", "]h", vscode_action(
      function()
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.nav_hunk("next", { target = "all" })
      end,
      "workbench.action.editor.nextChange"
    ), "Next Hunk")

    map("n", "[h", vscode_action(
      function()
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.nav_hunk("prev", { target = "all" })
      end,
      "workbench.action.editor.previousChange"
    ), "Next Hunk")

    map("n", "<leader>hs", vscode_action(
      function()
        gs.stage_hunk()
      end,
      ""
    ), "Stage hunk")
  end,
}
