local opts = {}

-- init a option instance
function opts:new(instance)
  instance = instance or {
    options = {
      silent = false,
      nowait = false,
      expr = false,
      noremap = false
    }
  }

  setmetatable(instance, self)
  self.__index = self

  return instance
end

local M = {}

-- a part of build pattern to set attr to opt
function M.silent(opt)
  return function()
    opt.silent = true
  end
end

-- a part of build pattern to set attr to opt
function M.noremap(opt)
  return function()
    opt.noremap = true
  end
end

-- a part of build pattern to set attr to opt
function M.expr(opt)
  return function()
    opt.expr = true
  end
end

-- a part of build pattern to set attr to opt
function M.remap(opt)
  return function()
    opt.remap = true
  end
end

-- a part of build pattern to set attr to opt
function M.nowait(opt)
  return function()
    opt.nowait = true
  end
end

-- exec build function to build a map option
function M.new_opts(...)
  local args = { ... }
  local o = opts:new()

  if #args == 0 then
    return o.options
  end

  for _, arg in pairs(args) do
    arg(o.options)()
  end
  return o.options
end

-- a wrap to exec cmd in command mode
function M.cmd(str)
  return '<cmd>' .. str .. '<CR>'
end

-- a wrap to exec operate visual mode
function M.cu(str)
  return ':<C-u>' .. str .. '<CR>'
end

-- @private
local keymap_set = function(mode, tbl)
  vim.validate({
    tbl = { tbl, 'table' }
  })

  local len = #tbl
  if len < 2 then
    vim.notify('keymap must has rhs')
    return
  end

  local options = len == 3 and tbl[3] or M.new_opts()
  vim.keymap.set(mode, tbl[1], tbl[2], options)
end

-- @private
local function map(mod)
  return function(tbl)
    vim.validate({
      tbl = { tbl, 'table' }
    })

    if type(tbl[1]) == 'table' and type(tbl[2]) == 'table' then
      for _, v in pairs(tbl) do
        keymap_set(mod, v)
      end
    else
      keymap_set(mod, tbl)
    end
  end
end

M.nmap = map('n')
M.imap = map('i')
M.cmap = map('c')
M.vmap = map('v')
M.xmap = map('x')
M.tmap = map('t')

return M
