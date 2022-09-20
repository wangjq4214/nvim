local uv = vim.loop

local M = {}

function M:is_windows()
  if string.find(uv.os_uname().sysname, 'Windows') ~= nil then
    return true
  end

  return false
end

function M:join_paths(...)
  local args = { ... }
  if self:is_windows() then
    return table.concat(args, '\\')
  end

  return table.concat(args, '/')
end

return M
