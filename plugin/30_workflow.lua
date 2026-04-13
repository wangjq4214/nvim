-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

local now, now_if_args, later, map = utils.now, utils.now_if_args, utils.later, utils.map

now(
  function()
    require("mini.basics").setup {
      options = { basic = false },
      mappings = {
        basic = true,
        windows = true,
        move_with_alt = true,
      },
    }
  end
)

later(function() require("mini.bracketed").setup() end)

local new_scratch_buffer = function() vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true)) end
later(function()
  require("mini.bufremove").setup()

  map {
    n = {
      { "<Leader>ba", "<Cmd>b#<CR>", "Alternate" },
      { "<Leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete" },
      { "<Leader>bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!" },
      { "<Leader>bs", new_scratch_buffer, "Scratch" },
      { "<Leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", "Wipeout" },
      { "<Leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", "Wipeout!" },
    },
  }
end)

later(function()
  local miniclue = require "mini.clue"

  miniclue.setup {
    window = {
      delay = 500,
    },
    clues = {
      {
        { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
        { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
        { mode = "n", keys = "<Leader>f", desc = "+Find" },
        { mode = "n", keys = "<Leader>g", desc = "+Git" },
        { mode = "n", keys = "<Leader>l", desc = "+Language" },
        { mode = "n", keys = "<Leader>m", desc = "+Map" },
        { mode = "n", keys = "<Leader>o", desc = "+Other" },
        { mode = "n", keys = "<Leader>s", desc = "+Session" },
        { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
        { mode = "n", keys = "<Leader>v", desc = "+Visits" },
        { mode = "n", keys = "<Leader>p", desc = "+Package" },

        { mode = "x", keys = "<Leader>g", desc = "+Git" },
        { mode = "x", keys = "<Leader>l", desc = "+Language" },
      },
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows { submode_resize = true },
      miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = { "n", "x" }, keys = "<Leader>" }, -- Leader triggers
      { mode = "n", keys = "\\" }, -- mini.basics
      { mode = { "n", "x" }, keys = "[" }, -- mini.bracketed
      { mode = { "n", "x" }, keys = "]" },
      { mode = "i", keys = "<C-x>" }, -- Built-in completion
      { mode = { "n", "x" }, keys = "g" }, -- `g` key
      { mode = { "n", "x" }, keys = "'" }, -- Marks
      { mode = { "n", "x" }, keys = "`" },
      { mode = { "n", "x" }, keys = '"' }, -- Registers
      { mode = { "i", "c" }, keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" }, -- Window commands
      { mode = { "n", "x" }, keys = "s" }, -- `s` key (mini.surround, etc.)
      { mode = { "n", "x" }, keys = "z" }, -- `z` key
    },
  }
end)

later(function() require("mini.extra").setup() end)

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. " --follow -- %"
later(function()
  require("mini.git").setup()
  require("mini.diff").setup {
    view = {
      style = "sign",
    },
  }

  map {
    n = {
      { "<Leader>ga", "<Cmd>Git diff --cached<CR>", "Added diff" },
      { "<Leader>gA", "<Cmd>Git diff --cached -- %<CR>", "Added diff buffer" },
      { "<Leader>gc", "<Cmd>Git commit<CR>", "Commit" },
      { "<Leader>gC", "<Cmd>Git commit --amend<CR>", "Commit amend" },
      { "<Leader>gd", "<Cmd>Git diff<CR>", "Diff" },
      { "<Leader>gD", "<Cmd>Git diff -- %<CR>", "Diff buffer" },
      { "<Leader>gl, ", "<Cmd>" .. git_log_cmd .. "<CR>", "Log" },
      { "<Leader>gL", "<Cmd>" .. git_log_buf_cmd .. "<CR>", "Log buffer" },
      { "<Leader>go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle overlay" },
      { "<Leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at cursor" },
    },
    x = {
      { "<Leader>gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at selection" },
    },
  }
end)

later(function() require("mini.jump").setup() end)
later(function() require("mini.jump2d").setup() end)

now_if_args(function()
  require("mini.misc").setup()

  -- Change current working directory based on the current file path. It
  -- searches up the file tree until the first root marker ('.git' or 'Makefile')
  -- and sets their parent directory as a current directory.
  -- This is helpful when simultaneously dealing with files from several projects.
  MiniMisc.setup_auto_root()

  -- Restore latest cursor position on file open
  MiniMisc.setup_restore_cursor()

  -- Synchronize terminal emulator background with Neovim's background to remove
  -- possibly different color padding around Neovim instance
  -- MiniMisc.setup_termbg_sync()

  map {
    n = {
      { "<Leader>or", "<Cmd>lua MiniMisc.resize_window()<CR>", "Resize to default width" },
      { "<Leader>oz", "<Cmd>lua MiniMisc.zoom()<CR>", "Zoom toggle" },
    },
  }
end)

now(function()
  vim.pack.add {
    {
      src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
      version = vim.version.range "3",
    },
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
  }

  require("neo-tree").setup {
    popup_border_style = "",
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = "✚", -- NOTE: you can set any of these to an empty string to not show them
          deleted = "✖",
          modified = "",
          renamed = "󰁕",
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
      type = {
        enabled = true,
        width = 10, -- width of the column
        required_width = 122, -- min width of window required to show this column
      },
      created = {
        enabled = true,
        width = 20, -- width of the column
        required_width = 110, -- min width of window required to show this column
      },
    },
    window = {
      position = "right",
    },
  }

  map {
    n = {
      { "<Leader>e", "<Cmd>Neotree<CR>", "Toggle Explorer" },
    },
  }
end)

local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'
later(function()
  require("mini.pick").setup {
    window = {
      config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = "NW",
          height = height,
          width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width)),
        }
      end,
    },
  }

  map {
    n = {
      { "<Leader>f/", '<Cmd>Pick history scope="/"<CR>', "History ('/')" },
      { "<Leader>f:", '<Cmd>Pick history scope=":"<CR>', "History (':')" },
      { "<Leader>fa", '<Cmd>Pick git_hunks scope="staged"<CR>', "Added hunks (all)" },
      { "<Leader>fA", pick_added_hunks_buf, "Added hunks (buf)" },
      { "<Leader>fb", "<Cmd>Pick buffers<CR>", "Buffers" },
      { "<Leader>fc", "<Cmd>Pick git_commits<CR>", "Commits (all)" },
      { "<Leader>fC", '<Cmd>Pick git_commits path="%"<CR>', "Commits (buf)" },
      { "<Leader>fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace" },
      { "<Leader>fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer" },
      { "<Leader>ff", "<Cmd>Pick files<CR>", "Files" },
      { "<Leader>fg", "<Cmd>Pick grep_live<CR>", "Grep live" },
      { "<Leader>fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word" },
      { "<Leader>fh", "<Cmd>Pick help<CR>", "Help tags" },
      { "<Leader>fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups" },
      { "<Leader>fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)" },
      { "<Leader>fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (buf)" },
      { "<Leader>fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)" },
      { "<Leader>fM", '<Cmd>Pick git_hunks path="%"<CR>', "Modified hunks (buf)" },
      { "<Leader>fr", "<Cmd>Pick resume<CR>", "Resume" },
      { "<Leader>fR", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)" },
      { "<Leader>fs", pick_workspace_symbols_live, "Symbols workspace (live)" },
    },
  }
end)

local session_new = 'vim.ui.input({ prompt = "Session name: " }, MiniSessions.write)'
now(function()
  require("mini.sessions").setup {
    autowerite = true,
  }

  map {
    n = {
      { "<Leader>sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete" },
      { "<Leader>sn", "<Cmd>lua " .. session_new .. "<CR>", "New" },
      { "<Leader>sr", '<Cmd>lua MiniSessions.select("read")<CR>', "Read" },
      { "<Leader>sR", "<Cmd>lua MiniSessions.restart()<CR>", "Restart" },
      { "<Leader>sw", "<Cmd>lua MiniSessions.write()<CR>", "Write current" },
    },
  }
end)

local make_pick_core = function(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default { recency_weight = 1 }
    local local_opts = { cwd = cwd, filter = "core", sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end
later(function()
  require("mini.visits").setup()

  map {
    n = {
      { "<Leader>vc", make_pick_core("", "Core visits (all)"), "Core visits (all)" },
      { "<Leader>vC", make_pick_core(nil, "Core visits (cwd)"), "Core visits (cwd)" },
      { "<Leader>vv", '<Cmd>lua MiniVisits.add_label("core")<CR>', 'Add "core" label' },
      { "<Leader>vV", '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label' },
      { "<Leader>vl", "<Cmd>lua MiniVisits.add_label()<CR>", "Add label" },
      { "<Leader>vL", "<Cmd>lua MiniVisits.remove_label()<CR>", "Remove label" },
    },
  }
end)
