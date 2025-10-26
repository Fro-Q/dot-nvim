
---@diagnostic disable undefined global
local util = require "lspconfig.util"
local home = os.getenv "HOME"

vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
  -- virtual_text = {
  --   spacing = 4,
  --   prefix = "",
  -- },
  float = {
    severity_sort = true,
    source = "if_many",
    border = "single",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
}

-- Main table for all LSP opts
local servers = {
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            maxLineLength = 100,
          },
        },
      },
    },
  },
  basedpyright = {
    diagnosticMode = "None",
  },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        hint = {
          enable = true,
        },
        format = {
          enable = true,
          defaultConfig = {
            quote_style = "double",
          }
        },
      },
    },
  },
  -- unocss = {
  --   cmd = { "unocss-language-server", "--stdio" },
  --   filetypes = {
  --     "erb",
  --     "haml",
  --     "hbs",
  --     "html",
  --     "css",
  --     "postcss",
  --     "javascript",
  --     "javascriptreact",
  --     "markdown",
  --     "ejs",
  --     "php",
  --     "svelte",
  --     "typescript",
  --     "typescriptreact",
  --     "vue-html",
  --     "vue",
  --     "sass",
  --     "scss",
  --     "less",
  --     "stylus",
  --     "astro",
  --     "rescript",
  --     "rust",
  --   },
  --   root_markers = { "unocss.config.js", "unocss.config.ts", "uno.config.js", "uno.config.ts", "uno.config.mts" },
  --   workspace_required = false,
  -- },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              -- location = home
              --     .. "/User/jayqing/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
              location = vim.fn.expand "$MASON/packages" ..
                  "/vue-language-server" .. "/node_modules/@vue/language-server",
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  },
  vue_ls = {
    on_init = function(client)
      client.handlers["tsserver/request"] = function(_, result, context)
        local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
        if #clients == 0 then
          vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
          return
        end
        local ts_client = clients[1]

        local param = unpack(result)
        local id, command, payload = unpack(param)
        ts_client:exec_cmd({
          title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
          command = "typescript.tsserverRequest",
          arguments = {
            command,
            payload,
          },
        }, { bufnr = context.bufnr }, function(_, r)
          local response_data = { { id, r.body } }
          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify("tsserver/response", response_data)
        end)
      end
    end,
    -- init_options = {
    --   vue = {
    --     hybridMode = false,
    --   },
    --   typescript = {
    --     tsdk =
    --     "/Users/jayqing/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib",
    --   },
    -- },

    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    },
  },
  -- ts_ls = {
  --   init_options = {
  --     plugins = {
  --       {
  --         name = "@vue/typescript-plugin",
  --         location = home
  --             .. "/User/jayqing/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
  --         languages = { "vue" },
  --       },
  --     },
  --   },
  --
  --   settings = {
  --     typescript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --     javascript = {
  --       inlayHints = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --   },
  -- },
  markdown_oxide = {},
  eslint = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "html",
      "markdown",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "xml",
      "gql",
      "graphql",
      "astro",
      "svelte",
      "css",
      "less",
      "scss",
      "pcss",
      "postcss",
    },
    settings = {
      -- Silent the stylistic rules in you IDE, but still auto fix them
      rulesCustomizations = {
        { rule = "style/*",   severity = "off", fixable = true },
        { rule = "format/*",  severity = "off", fixable = true },
        { rule = "*-indent",  severity = "off", fixable = true },
        { rule = "*-spacing", severity = "off", fixable = true },
        { rule = "*-spaces",  severity = "off", fixable = true },
        { rule = "*-order",   severity = "off", fixable = true },
        { rule = "*-dangle",  severity = "off", fixable = true },
        { rule = "*-newline", severity = "off", fixable = true },
        { rule = "*quotes",   severity = "off", fixable = true },
        { rule = "*semi",     severity = "off", fixable = true },
      },
    },
  },
  texlab = {
    settings = {
      texlab = {
        diagnostics = {
          ignoredPatterns = {
            "Overfull",
            "Underfull",
            "Package hyperref Warning",
            "Float too large for page",
            "contains only floats",
          },
        },
      },
    },
  },
}

-- Set up all server
local capabilities = vim.lsp.protocol.make_client_capabilities()
if not vim.g.vscode then
  capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
end
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local function setup_server(server_name, config)
  config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
  -- config.on_attach = function(client, bufnr)
  -- require("nvim-navic").attach(client, bufnr)
  -- end
  -- require("lspconfig")[server_name].setup(config)
  vim.lsp.config(server_name, config)
  vim.lsp.enable(server_name)
end
for server_name, server_opt in pairs(servers) do
  setup_server(server_name, server_opt)
end

-- folding after capabilities is loaded
-- require 'custom.config.folding'

-- Define LSP-related keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<Tab>", function()
      local opts = { border = "single", min_width = 1, max_width = 120, max_height = 25, focusable = false, source = true }
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b._diag_hover_state = vim.b._diag_hover_state or "diag"
      local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
      local has_diag = diags and #diags > 0
      local has_hover = true
      if has_diag and has_hover then
        if vim.b._diag_hover_state == "diag" then
          vim.diagnostic.open_float(nil, opts)
          vim.b._diag_hover_state = "hover"
        else
          vim.lsp.buf.hover(opts)
          vim.b._diag_hover_state = "diag"
        end
      elseif has_diag then
        vim.diagnostic.open_float(nil, opts)
        vim.b._diag_hover_state = "hover"
      else
        vim.lsp.buf.hover(opts)
        vim.b._diag_hover_state = "diag"
      end
    end, "toggle diag/hover float")

    map("K", function()
      -- local opts = 
      vim.lsp.buf.hover({ border = "single", max_width = 120, max_height = 25, focusable = true, source = true })
    end, "focus hover float")

    -- map("gd", function()
    --   local params = vim.lsp.util.make_position_params(0, "utf-8")
    --   vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
    --     if not result or vim.tbl_isempty(result) then
    --       vim.notify("No definition found", vim.log.levels.INFO)
    --     else
    --       require("snacks").picker.lsp_definitions()
    --     end
    --   end)
    -- end, "goto definition")
    --
    -- map("gD", vim.lsp.buf.declaration, "goto declaration")
    --
    -- map("gr", function()
    --   Snacks.picker.lsp_references()
    -- end, "goto references")
    --
    -- map("gi", vim.lsp.buf.implementation, "goto implementation")
    --
    -- map("gt", vim.lsp.buf.type_definition, "goto type definition")
    --
    map("<leader>rn", vim.lsp.buf.rename, "rename symbol")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
      vim.notify "Enable folding with LSP"
    end
    if client and client.supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    -- disable volar as formatter
    if client.name == "vue_ls" then
      client.server_capabilities.documentFormattingProvider = false
    end

    -- Inlay hint
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      -- vim.lsp.inlay_hint.enable()
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, "toggle inlay hints")
    end

    -- Highlight words under cursor
    if
        client
        and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
        and vim.bo.filetype ~= "bigfile"
    then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight",
        { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
          -- vim.cmd 'setl foldexpr <'
        end,
      })
    end
  end,
})

