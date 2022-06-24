local M = {}

local api = vim.api
local fn = vim.fn

M.close_buffer = function(force)
  if vim.bo.buftype == "terminal" then
    force = force or #api.nvim_list_wins() < 2 and ":bd!"
    local swap = force and #api.nvim_list_bufs() > 1 and ":bp | bd!" .. fn.bufnr()
    return vim.cmd(swap or force or "hide")
  end

  local file_exists = fn.filereadable(fn.expand("%p"))
  local modified = api.nvim_buf_get_option(fn.bufnr(), "modified")

  if file_exists == 0 and modified then
    print("no file name? add it now!")
    return
  end

  force = force or not vim.bo.buflisted or vim.bo.buftype == "nofile"

  local close_cmd = force and ":bd!" or ":bp | bd" .. fn.bufnr()
  vim.cmd(close_cmd)
end

return M

