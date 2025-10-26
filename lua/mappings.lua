---@diagnostic disable: undefined-global
local map           = require("utils").map
local vscode_action = require("utils").vscode_action
local vscode_call   = require("utils").vscode_call
local pick_with_rg_config = require("utils").pick_with_rg_config
local persistence   = require("persistence")
-- local gs            = require("gitsigns")
local harpoon       = require("harpoon")
local mini_snippets = require("mini.snippets")
local mini_pick     = require("mini.pick")
local mini_diff     = require("mini.diff")
local mini_extra    = require("mini.extra")

-- Delete shit maps
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")

-- Setup harpoon
harpoon:setup()

-- Harpoon buffer
map("n", "<leader>x", vscode_action(
  function()
    harpoon:list():add()
  end,
  ""
), "Harpoon Buffer")

map("n", "<leader><leader>", vscode_action(
  function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end,
  ""
), "Harpoon List")

local harpoon_extensions = require("harpoon.extensions")
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())


-- map("n", "gD", vscode_action(
--   function()
--     require("snacks").picker.lsp_declarations()
--   end,
--   "editor.action.peekDeclaration"
-- ), "Goto Declarations")
--
-- map("n", "gd", vscode_action(
--   function()
--     require("snacks").picker.lsp_definitions()
--   end,
--   "editor.action.peekDefinition"
-- ), "Goto Definitions")
--
-- map("n", "gi", vscode_call(
--   function()
--     require("snacks").picker.lsp_implementations()
--   end,
--   "editor.action.peekImplementation"
-- ), "Goto Implementations")
--
-- map("n", "gr", vscode_action(
--   function()
--     require("snacks").picker.lsp_references()
--   end,
--   "editor.action.referenceSearch.trigger"
-- ), "Goto References")
--
-- map("n", "gt", vscode_action(
--   function()
--     require("snacks").picker.lsp_type_definitions()
--   end,
--   "editor.action.peekTypeDefinition"
-- ), "Goto Type Definitions")

-- Escape insert mode
map({ "i", "t" }, "jk", function()
  if require("blink.cmp").is_menu_visible() then
    require("blink.cmp").cancel()
  elseif mini_snippets.session.get() then
    mini_snippets.session.stop()
  else
    vim.api.nvim_input('<ESC>')
  end
end, "Super Escape")
map({ "i", "t" }, "JK", "<ESC>", "Escape Insert Mode")
map({ "i", "t" }, "Jk", "<ESC>", "Escape Insert Mode")

-- Escape Visual Mode
map({ "v" }, "JK", "<ESC>", "Escape Visual Mode")

-- Navigate between windows
map("n", "<C-h>", "<C-w>h", "Switch Window Left")
map("n", "<C-l>", "<C-w>l", "Switch Window Right")
map("n", "<C-j>", "<C-w>j", "Switch Window Down")
map("n", "<C-k>", "<C-w>k", "Switch Window Up")

-- Navigate between buffers
map("n", "<S-l>", function()
  if vim.g.vscode then
    require("vscode").action("workbench.action.nextEditorInGroup")
  else
    vim.cmd("bnext")
  end
end, "Buffer Goto Next")
map("n", "<S-h>", function()
  if vim.g.vscode then
    require("vscode").action("workbench.action.previousEditorInGroup")
  else
    vim.cmd("bprev")
  end
end, "Buffer Goto Prev")

-- Clear search highlights
map("n", "<leader>nh", "<cmd>noh<CR>", "General Clear Highlights")

-- Comment line or lines
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle Comment", remap = true })

map("n", "<leader>e", vscode_action(
  function()
    local minifiles = require("mini.files")
    minifiles.open(vim.api.nvim_buf_get_name(0))
    minifiles.reveal_cwd()
  end,
  "workbench.explorer.fileView.focus"
), "File Explorer")

map("n", "<leader>fb", vscode_action(
  mini_pick.builtin.buffers,
  ""
), "Pick Buffers")

map("n", "<leader>ff", vscode_action(
  mini_pick.builtin.files,
  "workbench.action.quickOpen"

), "Pick Files")

map("n", "<leader>fa", vscode_action(
  function ()
    pick_with_rg_config(mini_pick.builtin.files, "no-ignore")
  end,
  ""
), "Pick Files")

map("n", "<leader>fw", vscode_action(
  mini_pick.builtin.grep_live,
  ""
), "Pick Word")

map("n", "<leader>fk", vscode_action(
  mini_extra.pickers.keymaps,
  ""
), "Pick Keymaps")

map("n", "<leader>fh", vscode_action(
  mini_pick.builtin.help,
  ""
), "Pick Helps")

map("n", "<leader>fd", vscode_action(
  function ()
    mini_extra.pickers.diagnostic({scope = "current"})
  end,
  ""
), "Pick Diagnostics")

map("n", "<leader>fgc", vscode_action(
  function ()
    mini_extra.pickers.git_commits()
  end,
  ""
), "Pick Git Commits")

map("n", "<leader>fgh", vscode_action(
  function ()
    mini_extra.pickers.git_hunks()
  end,
  ""
), "Pick Git Hunks")

map("n", "<leader>fH", vscode_action(
  function()
    vim.cmd("Pick hl_groups")
  end,
  ""
), "Pick Highlight Groups")

map("n", "<leader>cr", vscode_action(
  function()

  end,
  "editor.action.rename"
), "Rename Symbol")


-- local snacks = require("snacks")

-- -- Notification
-- map("n", "<leader>N", snacks.notifier.show_history, "Show Notification History")
--
-- -- Pickers
-- map("n", "<leader>ff", snacks.picker.smart, "Find Files")
--
-- map("n", "<leader>fa", function()
--   snacks.picker.smart { ignored = true }
-- end, "Find All Files")
--
-- map("n", "<leader><leader>", function()
--   snacks.picker.buffers {
--     sort_lastused = true
--   }
-- end, "Find Buffers")
--
-- map("n", "<leader>fh", snacks.picker.help, "Find Help")
--
-- map("n", "<leader>fk", snacks.picker.keymaps, "Find Keymaps")
--
-- map("n", "<leader>fm", snacks.picker.marks, "Find Marks")
--
-- map("n", "<leader>fw", snacks.picker.grep, "Find Text")
--
-- map("n", "<leader>fW", snacks.picker.grep_word, "Find Word Under Cursor")
--
-- map("n", "<leader>fd", snacks.picker.diagnostics, "Find Diagnostics")
--
-- map("n", "<leader>fH", snacks.picker.highlights, "Find Highlight Groups")
--
-- map("n", "<leader>ft", function()
--   ---@diagnostic disable-next-line: undefined-field
--   snacks.picker.todo_comments { layout = "select" }
-- end, "Find Todos")
--
-- map("n", "<leader>fT", snacks.picker.colorschemes, "Find Colorschemes")
--
-- map("n", "<leader>w", function()
--   snacks.bufdelete()
-- end, "Delete Buffer")
--
-- map("n", "<leader>C", function ()
--   snacks.bufdelete.other()
-- end, "Delete Other Buffers")

-- Navigation
-- map("n", "]h", function()
--   gs.nav_hunk("next", { target = "all" })
-- end, "Next Hunk")
-- map("n", "[h", function()
--   gs.nav_hunk("prev", { target = "all" })
-- end, "Prev Hunk")
-- map("n", "<leader>hs", vscode_action(
--   function ()
--     require("mini.diff").do_hunks(0, "apply")
--   end,
--   ""
-- ), "Stage Hunk")

-- Actions
-- map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
-- map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
-- map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Stage hunk")
-- map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Reset hunk")
-- map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
-- map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
-- map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
-- map("n", "<leader>hb", function() gs.blame_line { full = true } end, "Blame line")
-- map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
-- map("n", "<leader>hd", gs.diffthis, "Diff this")
-- map("n", "<leader>hD", function() gs.diffthis "~" end, "Diff this ~")

-- Text object
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")

-- Load Sessions
map("n", "<leader>sl", persistence.load, "Load Session")
map("n", "<leader>sd", persistence.stop, "Stop Saving Session")


-- Only when not in VS Code
if not vim.g.vscode then
  local duck = require("duck")
  map('n', '<leader>dd', duck.hatch, "Duck!")
  map('n', '<leader>dk', duck.cook, "Cook!")
  map('n', '<leader>da', duck.cook_all, "Cook 'em all!")
end
