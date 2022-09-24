local fn, api = vim.fn, vim.api
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()

if not packer_plugins['cmp-nvim-lsp'].loaded then
  vim.cmd('packadd cmp-nvim-lsp')
end

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = ' ',
}

for k, v in pairs(signs) do
  local hl = 'DiagnosticSign' .. k
  fn.sign_define(hl, { text = v, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    source = true
  }
})

local on_attach = function(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  api.nvim_create_autocmd('BufWritePre', {
    pattern = client.config.filetypes,
    callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        async = true,
      })
    end,
  })
end

local servers = {
  gopls = {
    on_attach = on_attach,
    cmd = { 'gopls', '--remote=auto' },
    capabilities = capabilities,
    init_options = {
      usePlaceholder = true,
      completeUnimported = true
    }
  },
  sumneko_lua = {
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = { 'vim', 'packer_plugins' }
        },
        runtime = { version = 'LuaJIT' },
        workspace = {
          library = vim.list_extend({
            [fn.expand('$VIMRUNTIME/lua')] = true
          }, {})
        }
      }
    }
  },
  clangd = {
    on_attach = on_attach,
    cmd = {
      'clangd',
      '--background-index',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=iwyu'
    }
  },
  rust_analyzer = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      imports = {
        granularity = {
          group = 'module'
        },
        prefix = 'self'
      },
      cargo = {
        buildScript = {
          enable = true
        }
      },
      procMacro = {
        enable = true
      }
    }
  },
  dockerls = {
    on_attach = on_attach
  },
  pyright = {
    on_attach = on_attach
  },
  bashls = {
    on_attach = on_attach
  },
  tsserver = {
    on_attach = on_attach
  }
}

for k, v in pairs(servers) do
  lspconfig[k].setup(v)
end
