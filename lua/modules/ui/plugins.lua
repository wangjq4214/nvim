local register = require('core.packer').register_plugin
local conf = require('modules.ui.configs')

register({ 'glepnir/zephyr-nvim', config = conf.zephyr })

