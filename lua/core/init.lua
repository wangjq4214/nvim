require('core.options')
require('keymap')

local keymap = require('core.keymap')
keymap.load_general_keymap()

local packer = require('core.packer')
packer.ensure_plugins()
packer.load_compile()
