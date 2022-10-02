local uv, fn = vim.loop, vim.fn
local util = require('util')

local function read_file()
  local path = util:join_paths(fn.stdpath('config'), "keymap.json")
  local fd = assert(uv.fs_open(path, "r", tonumber("0444", 8)))

  local stat = assert(uv.fs_fstat(fd))
  local buf = assert(uv.fs_read(fd, stat.size, 0))
  uv.fs_close(fd)

  return buf
end

local opts = {}

-- init a option instance
function opts:builder()
  local instance = {
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

-- a part of build pattern to set attr to opt
function opts:silent()
  self.options.silent = true
end

-- a part of build pattern to set attr to opt
function opts:noremap()
  self.options.noremap = true
end

-- a part of build pattern to set attr to opt
function opts:expr()
  self.options.expr = true
end

-- a part of build pattern to set attr to opt
function opts:nowait()
  self.options.nowait = true
end

function opts:build()
  return self.options
end

-- a wrap to exec cmd in command mode
local function cmd(str)
  return '<cmd>' .. str .. '<CR>'
end

-- a wrap to exec operate visual mode
local function cu(str)
  return ':<C-u>' .. str .. '<CR>'
end

local function load_keymap_config()
  local data = read_file()
  local keymap_data = fn.json_decode(data)
  if keymap_data == nil then
    return
  end

  for k, v in pairs(keymap_data) do
    local mode = v.mode
    if mode == nil then
      mode = 'n'
    end

    repeat
      local rhs
      if v.cmd ~= nil then
        rhs = cmd(v.cmd)
      end

      if rhs == nil then
        break
      end

      local builer = opts:builder()
      if v.option ~= nil then
        if v.option.silent then
          builer:silent()
        end

        if v.option.nowait then
          builer:nowait()
        end

        if v.option.expr then
          builer:expr()
        end

        if v.option.noremap then
          builer:noremap()
        end
      end

      vim.keymap.set(mode, k, rhs, builer:build())
    until true
  end
end

load_keymap_config()
