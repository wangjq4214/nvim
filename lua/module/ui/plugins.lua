local add = require('core.packer').add
local cfg = require('module.ui.configs')

add({
  'glepnir/zephyr-nvim',
  config = cfg.zephyr
})
