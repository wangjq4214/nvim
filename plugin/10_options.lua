-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

local g, o = vim.g, vim.o

-- Leader key ------------------------------------
g.mapleader = " " -- Use `<Space>` as <Leader> key

-- Disable built-in plugins ----------------------------------------------
g.loaded_netrw = 1 -- Disable netrw (for file explorer plugin)
g.loaded_netrwPlugin = 1 -- Disable netrwPlugin (for file explorer plugin)

-- Mouse and undo -------------------------------------------------
o.mouse = "a" -- Enable mouse
o.mousescroll = "ver:25,hor:6" -- Customize mouse scroll
o.switchbuf = "usetab" -- Use already opened buffers when switching

o.undofile = true -- Enable persistent undo

-- Performance -------------------------------------------------------------
o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax --------------------------
vim.cmd "filetype plugin indent on"
if vim.fn.exists "syntax_on" ~= 1 then vim.cmd "syntax enable" end

-- UI -------------------------------------------------------------------
o.breakindent = true -- Indent wrapped lines to match line start
o.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
o.wrap = false -- Don't visually wrap lines (toggle with \w)

o.colorcolumn = "+1" -- Draw column on the right of maximum width
o.cursorline = true -- Enable current line highlighting
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers

o.list = true -- Show helpful text indicators
-- Special UI symbols. More is set via 'mini.basics' later.
o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> " -- Show `…` when line is too long and `␣` for non-breaking space. Use `>` and a space to show tabs.
o.fillchars = "eob: ,fold:╌" -- Don't show `~` after end of buffer and use nice fold line

o.pumborder = "single" -- Use border in popup menu
o.pumheight = 10 -- Make popup menu smaller
o.pummaxwidth = 100 -- Make popup menu not too wide
o.ruler = false -- Don't show cursor coordinates
o.shortmess = "CFOSWaco" -- Disable some built-in completion messages
o.showmode = false -- Don't show mode in command line

o.splitbelow = true -- Horizontal splits will be below
o.splitkeep = "screen" -- Reduce scroll during window split
o.signcolumn = "yes" -- Always show signcolumn (less flicker)
o.splitright = true -- Vertical splits will be to the right

o.winborder = "single" -- Use border in floating windows
o.cursorlineopt = "screenline,number" -- Show cursor line per screen line

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
o.foldmethod = "indent" -- Fold based on indent level
o.foldnestmax = 10 -- Limit number of fold levels
o.foldtext = "" -- Show text under fold with its highlighting

-- Editing --------------------------------------------------------------
o.expandtab = true -- Convert tabs to spaces
o.tabstop = 2 -- Show tab as this number of spaces
o.shiftwidth = 2 -- Use this number of spaces for indentation
o.autoindent = true -- Use auto indent
o.smartindent = true -- Make indenting smart

o.ignorecase = true -- Ignore case during search
o.smartcase = true -- Respect case if search pattern has upper case
o.incsearch = true -- Show search matches while typing

o.infercase = true -- Infer case in built-in completion

o.spelloptions = "camel" -- Treat camelCase word parts as separate words

o.virtualedit = "block" -- Allow going past end of line in blockwise mode

o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
o.formatoptions = "rqnl1j" -- Improve comment editing
-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion -----------------------------------------------
o.complete = ".,w,b,kspell" -- Use less sources
o.completeopt = "menuone,noselect,fuzzy,nosort" -- Use custom behavior
o.completetimeout = 100 -- Limit sources delay

-- Autocommands --------------------------------------------------------------
-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
-- There are other autocommands created by 'mini.basics'.
local f = function() vim.cmd "setlocal formatoptions-=c formatoptions-=o" end
utils.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")

-- Diagnostics ================================================================
-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  -- Show signs on top of any other sign, but only for warnings and errors
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },

  -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
  underline = { severity = { min = "HINT", max = "ERROR" } },

  -- Show more details immediately for errors on the current line
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
utils.later(function() vim.diagnostic.config(diagnostic_opts) end)
-- stylua: ignore end
