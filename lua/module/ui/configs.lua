local lualineCfg = require('module.ui.lualine_cfg')

local M = {}

function M.tokyonight()
  vim.cmd('colorscheme tokyonight-storm')
end

function M.lualine()
  require('lualine').setup(lualineCfg)
end

return M
