local load_keymap = require('core.keymap').load_keymap

load_keymap({
  n = {
    ['<A-m>'] = { '<cmd> NvimTreeToggle <CR>', ' open nvim tree' },
  },
})
