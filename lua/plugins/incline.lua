return {
  "b0o/incline.nvim",
  lazy = false,
  opts = {
    window = {
      placement = {
        vertical = "bottom",
        horizontal = "center",
      },
      padding = 0,
      margin = { vertical = 0, horizontal = 0 },
    },
    render = function(props)
      local mini_icons = require("mini.icons")

      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") or "[-]"
      local ft_icon, ft_color = mini_icons.get("file", filename)

      local function get_git_diff()
        local icons = { delete = "- ", change = "~ ", add = "+ " }
        local sum = vim.b[props.buf].minidiff_summary
        local labels = {}
        if sum == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(sum[name]) and sum[name] > 0 then
            table.insert(labels, { icon .. sum[name] .. " ", group = "Diff" .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { "| " })
        end
        return labels
      end

      local function get_diagnostic_label()
        local icons = { error = "E", warn = "W", info = "I", hint = "H" }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(
            props.buf,
            { severity = vim.diagnostic.severity[string.upper(severity)] }
          )
          if n > 0 then
            table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { "| " })
        end
        return label
      end

      local function get_harpoon_items()
        local harpoon = require("harpoon")
        local marks = harpoon:list().items
        local current_file_path = vim.fn.expand("%:p:.")
        local label = {}

        for id, item in ipairs(marks) do
          if item.value == current_file_path then
            table.insert(label, { id .. " ", guifg = "#FFFFFF", gui = "bold" })
          else
            table.insert(label, { id .. " ", guifg = "#434852" })
          end
        end

        if #label > 0 then
          table.insert(label, 1, { "󰛢 ", guifg = "#61AfEf" })
          table.insert(label, { "| " })
        end
        return label
      end

      local function get_file_name()
        local label = {}
        table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
        table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = "#d19a66" })
        table.insert(
          label,
          { filename , gui = vim.bo[props.buf].modified and "bold,italic" or "bold" }
        )
        if not props.focused then
          label["group"] = "BufferInactive"
        end

        return label
      end

      return {
        { " ", guibg = "#0e0e0e" },
        {
          { get_diagnostic_label() },
          { get_git_diff() },
          { get_harpoon_items() },
          { get_file_name() },
          guibg = "#0e0e0e",
        },
        { " ", guibg = "#0e0e0e" },
      }
    end,
  }
}
