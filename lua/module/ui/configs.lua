local lualineCfg = require('module.ui.lualine_cfg')

local M = {}

function M.zephyr()
  vim.cmd('colorscheme zephyr')
end

function M.lualine()
  require('lualine').setup(lualineCfg)
end

return M
