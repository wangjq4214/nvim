require('core.lazy')

local M = {}

M.did_init = false

function M.load(name)
  local utils = require('lazy.core.util')
  local function _load(mod)
    utils.try(
      function()
        require(mod)
      end,
      {
        msg = 'Fail loading ' .. mod,
        on_error = function(msg)
          local modpath = require('lazy.core.cache').find(mod)
          if modpath then
            utils.error(msg)
          end
        end
      }
    )
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
end

return M

