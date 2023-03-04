local util = require('lazy.core.util')

local Format = {}

Format.autoformat = true

function Format.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    Format.autoformat = true
  else
    Format.autoformat = not Format.autoformat
  end

  if Format.autoformat then
    util.info('Enabled format on save', { title = 'Foramt' })
  else
    util.warn('Disabled format on save', { title = 'Format' })
  end
end

function Format.format()
  local buf = vim.api.nvim_get_current_buf()
  if vim.b.autoformat == false then
    return
  end
  local ft = vim.bo[buf].filetype
  local have_nls = #require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING') > 0

  vim.lsp.buf.format(vim.tbl_deep_extend('force', {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == 'null-ls'
      end

      return client.name ~= 'null-ls'
    end,
  }, require('utils').opts('nvim-lspconfig').format or {}))
end

function Format.on_attach(client, buf)
  if 
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormat.' .. buf, {}),
      buffer = buf,
      callback = function()
        if Format.autoformat then
          Format.format()
        end
      end,
    })
  end
end

local Key = {}

Key._key = nil

function Key.diagnostic_goto(next, serverity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  serverity = serverity and vim.diagnostic.serverity[serverity] or nil

  return function()
    go({ serverity = serverity })
  end
end

function Key.get()
  local format = Format.format

  if not Key._key then
    Key._key = {
      { '<leader>cd', vim.diagnostic.open_float, desc = 'Line Diagnostic' },
      { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
      { 'gd', '<cmd>Telescope lsp_definitions<cr>', desc = 'Go To Definition', has = 'definition' },
      { 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'References' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Go To Declaration' },
      { 'gI', '<cmd>Telescope lsp_implementations<cr>', desc ='Go To Implementations' },
      { 'gt', '<cmd>Telescope lsp_type_definitions<cr>', desc = 'Go To Type Definition' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help', has = 'signatureHelp' },
      { '<c-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help', has = 'signatureHelp' },
      { ']d', Key.diagnostic_goto(true), desc = 'Next Diagnostic' },
      { '[d', Key.diagnostic_goto(false), desc = 'Prev Diagnostic' },
      { ']e', Key.diagnostic_goto(true, 'ERROR'), desc = 'Next Error' },
      { '[e', Key.diagnostic_goto(false, 'ERROR'), desc = 'Prev Error' },
      { ']w', Key.diagnostic_goto(true, 'WARN'), desc = 'Next Warn' },
      { '[w', Key.diagnostic_goto(false, 'WARN'), desc = 'Prev Warn' },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' }, has = 'codeAction' },
      { '<leader>cf', format, desc = 'Format Document', has ='documentFormatting' },
      { '<leader>cf', format, desc = 'Format Range', mode = 'v', has = 'documentRangeFormatting' },
      {
        '<leader>cr',
        function()
          require('inc_rename')
          return ':IncRename' .. vim.fn.expand('<cword>')
        end,
        expr = true,
        desc = 'Rename',
        has = 'rename',
      },
    }
  end

  return Key._key
end

function Key.on_attach(client, buffer)
  local Keys = require('lazy.core.handler.keys')
  local keymaps = {}

  for _, value in ipairs(Key.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. 'Provider'] then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or 'n', keys[1], keys[2], opts)
    end
  end
end

return {
  -- lspconfig
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
      'mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'smjonas/inc-rename.nvim',
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = '●' },
        serverity_sort = true,
      },
      autoformat = true,
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {},
      setup = {},
    },
    config = function(plugin, opts)
      Format.autoformat = opts.autoformat

      require('utils').on_attach(function(client, buffer)
        Formath.on_attach(client, buffer)
        Key.on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require('core').icons.diagnostics) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capalibities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capalibities = vim.deepcopy(capalibities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then 
            return
          end
        end

        require('lspconfig')[server].setup(server_opts)
      end

      -- temp fix
      local mappings = require('mason-lspconfig.mappings.server')
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = 'lua-language-server'
        mappings.package_to_lspconfig['lua-language-server'] = 'lua_ls'
      end

      local mlsp = require('mason-lspconfig')
      local available = mlsp.get_available_servers()

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require('mason-lspconfig').setup({ ensure_installed = ensure_installed })
      require('mason-lspconfig').setup_handlers({ setup })
    end,
  },
  -- formatters
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      
      return {
        sources = {}
      }
    end,
  },
  -- cmdline tools and lsp servers
  {

    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'flake8',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}

