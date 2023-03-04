require('core.lazy')

local M = {}

M.icons = {
  diagnostics = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
  },
  git = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  kinds = {
    Array = ' ',
    Boolean = ' ',
    Class = ' ',
    Color = ' ',
    Constant = ' ',
    Constructor = ' ',
    Copilot = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = ' ',
    Folder = ' ',
    Function = ' ',
    Interface = ' ',
    Key = ' ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Namespace = ' ',
    Null = 'ﳠ ',
    Number = ' ',
    Object = ' ',
    Operator = ' ',
    Package = ' ',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    String = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = ' ',
  },
}

M.did_init = false

function M.load(name)
  local utils = require('lazy.core.util')
  local function _load(mod)
    utils.try(function()
      require(mod)
    end, {
      msg = 'Fail loading ' .. mod,
      on_error = function(msg)
        local modpath = require('lazy.core.cache').find(mod)
        if modpath then
          utils.error(msg)
        end
      end,
    })
  end

  _load('core.' .. name)
  if vim.bo.filetype == 'lazy' then
    vim.cmd([[ do VimResized ]])
  end
end

function M.init()
  if M.did_init then
    return
  end

  M.did_init = true

  M.load('options')
  M.load('keymap')
  M.load('autocmd')
end

return M
