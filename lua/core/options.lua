local opt = vim.opt

opt.autowrite = true -- enable auto write
opt.clipboard = 'unnamedplus' -- sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 3 -- hide * markup for bold and italic
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- enable highlighting for current line
opt.expandtab = true -- use spaces instead of tabs
opt.formatoptions = 'jcroqlnt'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- show some invisible characters e.g., tabs
opt.mouse = 'a' -- enable mouse mode
opt.number = true -- show line number
opt.pumblend = 10 -- popup blend
opt.pumheight = 10 -- maximum number of entries in the popup
opt.relativenumber = true -- relative line numbers
opt.scrolloff = 4 -- line of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- round indent
opt.shiftwidth = 2 -- size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- don't show mode since we have statusline
opt.sidescrolloff = 8 -- columns of context
opt.signcolumn = 'yes' -- always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- don't ignore case with capitals
opt.smartindent = true -- insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- put new windows below current
opt.splitright = true -- put new windows right of current
opt.tabstop = 2 -- number of spaces tabs count for
opt.termguicolors = true -- true color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger cursorhold
opt.wildmode = 'longest:full,full' -- command line completion mode
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- disable line wrap

-- fix markdown indentation settings
vim.g.markdown_recommand_style = 0

