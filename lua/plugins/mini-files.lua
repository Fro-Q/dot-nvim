return {
  "nvim-mini/mini.files",
  version = false,
  lazy = false,
  opts = {
    content = {
      filter = function(data)
        return data.name ~= ".DS_Store"
      end
    },
    mappings = {
      close       = 'q',
      go_in       = 'l',
      go_in_plus  = 'L',
      go_out      = 'h',
      go_out_plus = 'H',
      mark_goto   = "'",
      mark_set    = 'm',
      reset       = '.',
      reveal_cwd  = '@',
      show_help   = 'g?',
      synchronize = '<cr>',
      trim_left   = '<',
      trim_right  = '>',
    },
    options = {
      -- Whether to delete permanently or move into module-specific trash
      permanent_delete = false,
      -- Whether to use for editing directories
      use_as_default_explorer = true,
    },
    windows = {
      -- Maximum number of windows to show side by side
      max_number = math.huge,
      -- Whether to show preview of file/directory under cursor
      preview = true,
      -- Width of focused window
      width_focus = 30,
      -- Width of non-focused window
      width_nofocus = 15,
      -- Width of preview window
      width_preview = 30,
    },
  },
  config = function(_, opts)

    local MiniFiles = require("mini.files")

    local map = require("utils").map
    local vscode_action = require("utils").vscode_action

    MiniFiles.setup(opts)

    -- File explorer mapping
    map("n", "<leader>e", vscode_action(
      function()
        local buf_name = vim.api.nvim_buf_get_name(0)
        -- If buf_name is not in cwd, open cwd instead
        if not vim.startswith(buf_name, vim.loop.cwd()) then
          buf_name = vim.loop.cwd()
        end
        MiniFiles.open(buf_name)
        MiniFiles.reveal_cwd()
      end,
      "workbench.explorer.fileView.focus"
    ), "File explorer")
  end,
}
