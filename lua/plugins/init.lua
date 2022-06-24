local M = {}


local plugins = {
  -- self
  ["wbthomason/packer.nvim"] = {},
  -- theme
  ["folke/tokyonight.nvim"] = {},
  ["kyazdani42/nvim-web-devicons"] = {},
  -- telescope
  ["nvim-lua/plenary.nvim"] = {},
  ["LinArcX/telescope-env.nvim"] = {},
  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require("plugins.telescope").config()
    end
  },
  -- tree
  ["kyazdani42/nvim-tree.lua"] = {
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  -- bufferline
  ["moll/vim-bbye"] = {},
  ["akinsho/bufferline.nvim"] = {
    tag = "v2.*",
    opt = true,
    setup = function()
      require("plugins.bufferline").setup()
    end,
    config = function()
      require("plugins.bufferline").config()
    end,
  },
  -- which key
  ["folke/which-key.nvim"] = {
    module = "which-key",
    config = function()
    end,
  },
}

M.setup = function()
  local ok, packer = pcall(require, "packer")

  if not ok then
    return
  end

  packer.init({
    auto_clean = true,
    compile_on_sync = true,
    git = { clone_timeout = 6000 },
    display = {
      working_sym = "ﲊ",
      error_sym = "✗ ",
      done_sym = " ",
      removed_sym = " ",
      moved_sym = "",
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    }
  })
  
  packer.startup(function(use)
    for k, v in pairs(plugins) do
      v[1] = k
      use(v)
    end
  end)
end

return M

