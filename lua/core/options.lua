local opt = vim.opt

opt.autoindent = true
-- influences the working of <BS>, <Del>, CTRL-W and CTRL-U in insert mode.
opt.backspace = 'indent,eol,start'
-- disable backup before overwriting a file
opt.backup = false
-- don't backup these file
opt.backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
-- linebreak at specific char
opt.breakat = [[\ \	;:,!?]]
-- minimum text width that will be kept after applying 'breakindent' is 20
-- after applying 'breakindent', the wrapped line's beginning will be shifted 2 char
opt.breakindentopt = 'shift:2,min:20'
-- use system clipboard
opt.clipboard = 'unnamedplus'
-- number of screen lines to use for the command-line
opt.cmdheight = 1
-- number of screen lines to use for the command-line window
opt.cmdwinheight = 5
-- display a line in 100 column
opt.colorcolumn = '100'
-- the nvim will scan these buffer for complete
opt.complete = '.,w,b,k'
-- the insert option of complete method
opt.completeopt = 'menu,menuone,noselect'
-- diff mode options
opt.diffopt = 'filler,iwhite,internal,algorithm:patience'
-- as much as possible of the last line in a window will be displayed.
opt.display = 'lastline'
-- specific encoding
opt.encoding = 'utf-8'
-- splitting a window will reduce the size of the current window and leave the other windows the same
opt.equalalways = false
-- use ctrl-V<TAB> to insert a real tab
opt.expandtab = true
-- enable all file format support
opt.fileformats = 'unix,mac,dos'
-- enable fold
opt.foldenable = true
-- no folds close (use other plugins)
opt.foldlevelstart = 99
-- specific format option
opt.formatoptions = '1jcroql'
-- specific grep format and grep program
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
-- maximum number of items to show in the help page
opt.helpheight = 12
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
-- the options of jumplist
opt.jumpoptions = 'stack'
-- show status line in latest windows
opt.laststatus = 3
-- vim will wrap long lines at a character in 'breakat' rather than at the
-- last character that fits on the screen
opt.linebreak = true
-- use some char replace '\s' chars
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
-- char will change in search pattern
opt.magic = true
-- enable mouse support in normal and visual mode
opt.mouse = 'nv'
-- display line number
opt.number = true
-- default height for a preview window
opt.previewheight = 12
-- maximum number of items to show in the popup menu
opt.pumheight = 15
-- enables pseudo-transparency for the popup-menu
opt.pumblend = 10
-- time in milliseconds for redrawing the display
opt.redrawtime = 1500
-- disable show row and col where cursor is
opt.ruler = false
-- must have 2 lines to start or end
opt.scrolloff = 2
-- specific effect which the mksession command will store
opt.sessionoptions = 'curdir,help,tabpages,winsize'
-- specific the shada file details, please look help file.
opt.shada = "!,'300,<50,@100,s10,h"
-- enable round indent to multiple of 'shiftwidth'
opt.shiftround = true
-- number of spaces to use for each step of (auto)indent
opt.shiftwidth = 2
-- show all message, remember short message is boring
opt.shortmess = ''
-- disable show (partial) command in the last line of the screen
opt.showcmd = false
-- disable show mode in the buttom of window
opt.showmode = false
-- string to put at the start of lines that have been wrapped
opt.showbreak = '↳  '
-- disable tab line
opt.showtabline = 0
-- must have 5 char to column start or end
opt.sidescrolloff = 5
-- always draw the signcolumn
opt.signcolumn = 'yes'
-- enable smartcase which will overwrite ignorecase opt when search pattern contain up char
opt.smartcase = true
-- enable smarttab
opt.smarttab = true
-- number of spaces that a <Tab> counts for while performing editing operations
opt.softtabstop = -1
-- every upper-case character in a word that comes after a lower case
-- character indicates the start of a new word.
opt.spelloptions = 'camel'
-- enable the split window in current one
opt.splitbelow = true
opt.splitright = true
-- don't move to position of the no-blank char
opt.startofline = false
-- disable use swapfile for buffer
opt.swapfile = false
-- after use command like quickfix, open first window
opt.switchbuf = 'useopen'
-- maximum column in which to search for syntax items
opt.synmaxcol = 2500
-- number of spaces that a <Tab> in the file counts for
opt.tabstop = 2
-- enabel 24-bit color in tui
opt.termguicolors = true
-- maximum width of text that is being inserted
opt.textwidth = 100
-- enable multiple key map, and set timeout time with timeoutlen
opt.timeout = true
opt.timeoutlen = 500
-- enable multiple key map in tui, and set timeout time with ttimeoutlen
opt.ttimeout = true
opt.ttimeoutlen = 10
-- automatically saves undo history to an undo file when writing a buffer to a file
opt.undofile = true
-- after 100ms no typed, the file will store to disk
opt.updatetime = 100
-- specific effect which the mkview command will store
opt.viewoptions = 'folds,cursor,curdir'
-- move cursor to no char position in visual mode
opt.virtualedit = 'block'
-- enables pseudo-transparency for a floating window
opt.winblend = 10
-- allow specified keys that move the cursor left/right to move to the previous/next line
opt.whichwrap = 'b,s,<,>,[,],~'
-- ignore case when complete filename and directory name
opt.wildignorecase = true
-- ignore these files and directorys
opt.wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
-- the min number of current window column
opt.winwidth = 30
-- the min number of other window column
opt.winminwidth = 10
-- lines will not wrap and only part of long lines will be displayed
opt.wrap = false
-- enable warpscan in search mode
opt.wrapscan = true
-- disable backup before overwriting a file
opt.writebackup = false


if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end
