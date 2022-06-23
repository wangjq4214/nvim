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

M.load_mappings = function()
  local map_func
  local whichkey_exists, wk = pcall(require, "which-key")

  if whichkey_exists then
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

