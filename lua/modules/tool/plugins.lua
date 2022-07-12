local register = require('core.packer').register_plugin
local conf = require('modules.tool.configs')

register({
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

register({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  requires = { 'kyazdani42/nvim-web-devicons' }
})

register({
  'nvim-telescope/telescope.nvim',
  config = conf.nvim_telescope,
  requires = { 'nvim-lua/plenary.nvim' }
})
register({ 'LinArcX/telescope-env.nvim' })
register({
  'ahmedkhalf/project.nvim',
  config = conf.telescope_project,
})
