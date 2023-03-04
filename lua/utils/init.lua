local M = {}

M.root_patterns = { '.git', 'lua' }

M.on_attach = function(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.opts(name)
  local plugin = require('lazy.core.config').plugins[name]
  if not plugin then
    return {}
  end

  local Plugin = require('lazy.core.plugin')
  return Plugin.values(plugin, 'opts', false)
end

function M.has(plugin)
  return require('lazy.core.config').plugins[plugin] ~= nil
end

function M.float_term(cmd, opts)
  opts = vim.tbl_deep_extend('force', {
    size = { width = 0.9, height = 0.9 },
  }, opts or {})
  require('lazy.util').float_term(cmd, opts)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  local util = require('lazy.core.util')
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return util.info(
      'Set ' .. option .. ' to ' .. vim.opt_local[option]:get(),
      { title = 'Option' }
    )
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      util.info('Enabled ' .. option, { title = 'Option' })
    else
      util.warn('Disabled ' .. option, { title = 'Option' })
    end
  end
end

local enabled = true
function M.toggle_diagnostics()
  local util = require('lazy.core.util')
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    util.info('Enabled diagnostics', { title = 'Diagnostics' })
  else
    vim.diagnostic.disable()
    util.warn('Disabled diagnostics', { title = 'Diagnostics' })
  end
end

-- return the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
-- @return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.loop.fs_realpath(path) or nil

  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end

  print(root)

  return root
end

return M
