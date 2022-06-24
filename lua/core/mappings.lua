local M = {}

local merge_tb = vim.tbl_deep_extend

local Mappings = {}

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- n, v, i, t = mode names
Mappings.general = {
  i = {
    -- go to begin and end
    ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "  move left" },
    ["<C-l>"] = { "<Right>", " move right" },
    ["<C-j>"] = { "<Down>", " move down" },
    ["<C-k>"] = { "<Up>", " move up" },
  },
  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "  no highlight" },
    ["q"] = { "<cmd> q <CR>", " quit this window" },
    ["<C-w>"] = { "<cmd> Bdelete! <CR>", " close buffer" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", " window left" },
    ["<C-l>"] = { "<C-w>l", " window right" },
    ["<C-j>"] = { "<C-w>j", " window down" },
    ["<C-k>"] = { "<C-w>k", " window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "﬚  save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },

    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },
  },
  t = {
    ["<C-x>"] = { termcodes("<C-\\><C-N>"), "   escape terminal mode" },
  },
}

Mappings.telescope = {
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
    ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "   git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },

    -- pick a hidden term
    -- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "   pick hidden term" },

    -- theme switcher
    -- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
   },
}

Mappings.nvimtree = {
  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
  },
}

Mappings.bufferline = {
  n = {
    -- new buffer
    ["<S-b>"] = { "<cmd> enew <CR>", "烙 new buffer" },
    -- cycle through buffers
    ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<S-Tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },

    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("core.helper").close_buffer()
      end,
      "   close buffer",
    },
  },
}

M.load_mappings = function()
  local map_func
  local ok, wk = pcall(require, "which-key")

  if ok then
    map_func = function(keybind, mapping_info, opts)
      wk.register({ [keybind] = mapping_info }, opts)
    end
  else
    map_func = function(keybind, mapping_info, opts)
      local mode = opts.mode
      opts.mode = nil
      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end

  mappings = vim.deepcopy(Mappings)
  -- skip mapping this as its mappings are loaded in lspconfig
  mappings.lspconfig = nil

  for _, section_mappings in pairs(mappings) do
    for mode, mode_mappings in pairs(section_mappings) do
      for keybind, mapping_info in pairs(mode_mappings) do
        local opts = merge_tb("force", { mode = mode }, mapping_info.opt or {})

        if mapping_info.opts then
          mapping_info.opts = nil
        end

        map_func(keybind, mapping_info, opts)
      end
    end
  end
end

return M

