return {
  "nvim-mini/mini.completion",
  version = false,
  lazy = false,
  opts = {
    lsp_completion = {
      source_func = 'omnifunc', auto_setup = false
    }
  },
  config = function (opts)

    local MiniCompletion = require("mini.completion")

    local map = require("utils").map

    MiniCompletion.setup(opts)

    -- Setup when LSP attach
    local on_attach = function(args)
      vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    vim.api.nvim_create_autocmd('LspAttach', { callback = on_attach })
  end
}
