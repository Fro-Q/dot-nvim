return {
  'nvim-mini/mini.snippets',
  version = false,
  lazy = false,
  event = { "BufReadPost", "BufNewFile" },
  config = function()

    local MiniSnippets = require("mini.snippets")
    local map = require("utils").map

    MiniSnippets.setup({
      snippets = {
        -- gen_loader.from_runtime({})
        function(context)
          local rel_path = 'snippets/' .. context.lang .. '.json'
          if vim.fn.filereadable(rel_path) == 0 then return end
          return MiniSnippets.read_file(rel_path)
        end,
      },
      mappings = {
        expand = "",
        jump_next = "<Tab>",
        jump_prev = "<S-Tab>",
        stop = "jk"
      }
    })

    MiniSnippets.start_lsp_server()

    -- Snippet escape mapping (handled in the super escape)
    map({ "i", "t" }, "jk", function()
      if MiniSnippets.session.get() then
        MiniSnippets.session.stop()
      else
        vim.api.nvim_input('<ESC>')
      end
    end, "Super Escape")
  end
}
