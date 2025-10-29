local map           = require("utils").map
local vscode_action = require("utils").vscode_action
local pick_with_rg_config = require("utils").pick_with_rg_config
local persistence   = require("persistence")
local gs            = require("gitsigns")
local mini_pick     = require("mini.pick")
local mini_extra    = require("mini.extra")

-- Delete shit maps
-- vim.keymap.del("n", "gra")
-- vim.keymap.del("n", "gri")
-- vim.keymap.del("n", "grr")
-- vim.keymap.del("n", "grn")

map({ "i", "t" }, "JK", "<ESC>", "Escape insert mode")
map({ "i", "t" }, "Jk", "<ESC>", "Escape insert mode")
map({ "i", "t" }, "jK", "<ESC>", "Escape insert mode")

-- Navigate between windows
map("n", "<C-h>", "<C-w>h", "Switch window left")
map("n", "<C-l>", "<C-w>l", "Switch window right")
map("n", "<C-j>", "<C-w>j", "Switch window down")
map("n", "<C-k>", "<C-w>k", "Switch window up")


-- Clear search highlights
map("n", "<leader>nh", "<cmd>noh<CR>", "General clear highlights")

-- map("n", "<leader>hs", vscode_action(
--   function()
--     mini_diff.do_hunks(0, "apply")
--   end,
--   "editor.action.codeAction"
-- ), "Code action")

-- local snacks = require("snacks")

-- -- Notification
-- map("n", "<leader>N", snacks.notifier.show_history, "Show Notification History")
--

--
-- map("n", "<leader>w", function()
--   snacks.bufdelete()
-- end, "Delete Buffer")
--
-- map("n", "<leader>C", function ()
--   snacks.bufdelete.other()
-- end, "Delete Other Buffers")

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
-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")

-- Load Sessions
-- map("n", "<leader>sl", persistence.load, "Load session")
-- map("n", "<leader>sd", persistence.stop, "Stop saving session")


-- Only when not in VS Code
if not vim.g.vscode then
  -- local duck = require("duck")
  -- map('n', '<leader>dd', function ()
  --   duck.hatch("🐈")
  -- end, "Duck!")
  -- map('n', '<leader>dk', duck.cook, "Cook!")
  -- map('n', '<leader>da', duck.cook_all, "Cook 'em all!")
end
