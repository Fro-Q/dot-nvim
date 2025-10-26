return {
  'nvim-mini/mini.snippets',
  version = false,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- local gen_loader = require('mini.snippets').gen_loader
    -- local global_snippets_dir = vim.fn.stdpath('config') .. '/snippets'
    -- local workspace_snippets_dir = vim.fn.getcwd() .. '/snippets'
    --
    -- local global_snippets_files = vim.fn.glob(global_snippets_dir .. '/*.json', true, true)
    -- local workspace_snippets_files = vim.fn.glob(workspace_snippets_dir .. '/*.json', true, true)
    --
    -- local snippets_files = vim.list_extend(global_snippets_files, workspace_snippets_files)

    require('mini.snippets').setup({
      snippets = {
        -- gen_loader.from_runtime({})
        function(context)
          local rel_path = 'snippets/' .. context.lang .. '.json'
          if vim.fn.filereadable(rel_path) == 0 then return end
          return MiniSnippets.read_file(rel_path)
        end,
        -- gen_loader.from_lang({
        --   lang_patterns = {
        --     lua = { "lua.json" }
        --   }
        -- }),
        -- gen_loader.from_runtime("json.json")
        -- gen_loader.from_file(snippets_files),
      },
    })
  end
}
