local load_keymap = require('core.keymap').load_keymap

-- nvim-tree
load_keymap({
  n = {
    ['<A-m>'] = { ':NvimTreeToggle<CR>', ' open nvim tree' },
  },
})

-- bufferline
load_keymap({
  n = {
    ['<C-h>'] = { ':BufferLineCyclePrev<CR>', '玲 checkout to prev tab' },
    ['<C-l>'] = { ':BufferLineCycleNext<CR>', '玲 checkout to next tab' },
    ['<C-w>'] = { ':bdelete!<CR>', ' close this tab' }
  },
})

