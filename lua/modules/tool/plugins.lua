local register = require('core.packer').register_plugin
local conf = require('modules.tool.configs')

register({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})
