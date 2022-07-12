local register = require('core.packer').register_plugin
local conf = require('modules.ui.configs')

register({ 'glepnir/zephyr-nvim', config = conf.zephyr })

register({
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  requires = { 'kyazdani42/nvim-web-devicons' }
})

