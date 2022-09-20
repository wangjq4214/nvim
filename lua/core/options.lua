local opt = vim.opt

-- disable backup before overwriting a file
opt.backup = false
-- don't backup these file
opt.backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
-- use system clipboard
opt.clipboard = 'unnamedplus'
-- the nvim will scan these buffer for complete
opt.complete = '.,w,b,k'
-- specific encoding
opt.encoding = 'utf-8'
-- enable all file format support
opt.fileformats = 'unix,mac,dos'
-- specific grep format and grep program
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
-- enable hidden support (the default is true)
opt.hidden = true
-- specific the number of history command
opt.history = 2000
-- ignore case in search pattern
opt.ignorecase = true
-- shows the effects of a command incrementally in the buffer
opt.inccommand = 'nosplit'
-- while type search pattern, showing search result
opt.incsearch = true
-- infer case when use auto complete
opt.infercase = true
-- char will change in search pattern
opt.magic = true
-- enable mouse support in normal and visual mode
opt.mouse = 'nv'
-- time in milliseconds for redrawing the display
opt.redrawtime = 1500
-- specific effect which the mksession command will store
opt.sessionoptions = 'curdir,help,tabpages,winsize'
-- specific the shada file details, please look help file.
opt.shada = "!,'300,<50,@100,s10,h"
-- enable round indent to multiple of 'shiftwidth'
opt.shiftround = true
-- enable smartcase which will overwrite ignorecase opt when search pattern contain up char
opt.smartcase = true
-- enable smarttab
opt.smarttab = true
-- disable use swapfile for buffer
opt.swapfile = false
-- enabel 24-bit color in tui
opt.termguicolors = true
-- enable multiple key map, and set timeout time with timeoutlen
opt.timeout = true
opt.timeoutlen = 500
-- enable multiple key map in tui, and set timeout time with ttimeoutlen
opt.ttimeout = true
opt.ttimeoutlen = 10
-- after 100ms no typed, the file will store to disk
opt.updatetime = 100
-- specific effect which the mkview command will store
opt.viewoptions = 'folds,cursor,curdir'
-- move cursor to no char position in visual mode
opt.virtualedit = 'block'
-- ignore case when complete filename and directory name
opt.wildignorecase = true
-- ignore these files and directorys
opt.wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
-- enable warpscan in search mode
opt.wrapscan = true
-- disable backup before overwriting a file
opt.writebackup = false




-- opt.breakat = [[\ \	;:,!?]]
-- opt.startofline = false
-- opt.whichwrap = 'h,l,<,>,[,],~'
-- opt.splitbelow = true
-- opt.splitright = true
-- opt.switchbuf = 'useopen'
-- opt.backspace = 'indent,eol,start'
-- opt.diffopt = 'filler,iwhite,internal,algorithm:patience'
-- opt.completeopt = 'menu,menuone,noselect'
-- opt.jumpoptions = 'stack'
-- opt.showmode = false
-- opt.shortmess = 'aoOTIcF'
-- opt.scrolloff = 2
-- opt.sidescrolloff = 5
-- opt.foldlevelstart = 99
-- opt.ruler = false
-- opt.list = true
-- opt.showtabline = 0
-- opt.winwidth = 30
-- opt.winminwidth = 10
-- opt.pumheight = 15
-- opt.helpheight = 12
-- opt.previewheight = 12
-- opt.showcmd = false
-- -- just for nightly
-- opt.cmdheight = 1
-- opt.cmdwinheight = 5
-- opt.equalalways = false
-- opt.laststatus = 3
-- opt.display = 'lastline'
-- opt.showbreak = '↳  '
-- opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
-- opt.pumblend = 10
-- opt.winblend = 10

-- opt.undofile = true
-- opt.synmaxcol = 2500
-- opt.formatoptions = '1jcroql'
-- opt.textwidth = 100
-- opt.expandtab = true
-- opt.autoindent = true
-- opt.tabstop = 2
-- opt.shiftwidth = 2
-- opt.softtabstop = -1
-- opt.breakindentopt = 'shift:2,min:20'
-- opt.wrap = false
-- opt.linebreak = true
-- opt.number = true
-- opt.colorcolumn = '100'
-- opt.foldenable = true
-- opt.signcolumn = 'yes'
-- opt.spelloptions = 'camel'
-- -- opt.conceallevel = 2
-- -- opt.concealcursor = 'niv'

-- if vim.loop.os_uname().sysname == 'Darwin' then
--   vim.g.clipboard = {
--     name = 'macOS-clipboard',
--     copy = {
--       ['+'] = 'pbcopy',
--       ['*'] = 'pbcopy',
--     },
--     paste = {
--       ['+'] = 'pbpaste',
--       ['*'] = 'pbpaste',
--     },
--     cache_enabled = 0,
--   }
--   vim.g.python_host_prog = '/usr/bin/python'
--   vim.g.python3_host_prog = '/usr/local/bin/python3'
-- end
