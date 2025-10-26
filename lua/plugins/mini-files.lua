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
      synchronize = '=',
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
  }
}
