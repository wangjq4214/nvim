local load_keymap = require('core.keymap').load_keymap

load_keymap({
  n = {
    ['<C-s>'] = { ':w<CR>', ' save this buffer' }
  }
})
