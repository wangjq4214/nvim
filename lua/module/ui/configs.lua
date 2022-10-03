local lualineCfg = require('module.ui.lualine_cfg')

local M = {}

function M.tokyonight()
  vim.cmd('colorscheme tokyonight-storm')
end

function M.lualine()
  require('lualine').setup(lualineCfg)
end

function M.dashboard()
  local db = require('dashboard')

  db.custom_footer = function()
    local footer = { '', 'https://github.com/wangjq4214', '' }
    if packer_plugins ~= nil then
      local count = #vim.tbl_keys(packer_plugins)
      footer[3] = '🎉 neovim loaded ' .. count .. ' plugins'
    end
    return footer
  end

  db.custom_center = {
    { icon = '  ', desc = 'Projects', action = 'Telescope project' },
    { icon = '  ', desc = 'Recently files', action = 'Telescope oldfiles' },
  }

  db.custom_header = {
    [[]],
    [[]],
    [[██╗    ██╗ █████╗ ███╗   ██╗ ██████╗      ██╗ ██████╗ ]],
    [[██║    ██║██╔══██╗████╗  ██║██╔════╝      ██║██╔═══██╗]],
    [[██║ █╗ ██║███████║██╔██╗ ██║██║  ███╗     ██║██║   ██║]],
    [[██║███╗██║██╔══██║██║╚██╗██║██║   ██║██   ██║██║▄▄ ██║]],
    [[╚███╔███╔╝██║  ██║██║ ╚████║╚██████╔╝╚█████╔╝╚██████╔╝]],
    [[ ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚════╝  ╚══▀▀═╝ ]],
    [[                                                      ]],
  }
end

return M
