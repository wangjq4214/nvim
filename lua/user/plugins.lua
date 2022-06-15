local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

return require("packer").startup({
  function(use)
    -- self
    use("wbthomason/packer.nvim")

    -- lsp
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")

    -- lua
    use("folke/lua-dev.nvim")

    -- colorscheme
    use("folke/tokyonight.nvim")

    -- tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
    })

    -- lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")

    -- telescope
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- telescope extension
    use("LinArcX/telescope-env.nvim")

    -- dashboard
    use("glepnir/dashboard-nvim")

    -- project
    use("ahmedkhalf/project.nvim")

    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- snippet 引擎
    use("hrsh7th/vim-vsnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")

    -- ui
    use("onsails/lspkind-nvim")

    -- indent-blankline
    use("lukas-reineke/indent-blankline.nvim")

    -- lspsaga
    use("tami5/lspsaga.nvim")

    -- format
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

    -- auto pairs
    use("windwp/nvim-autopairs")

    -- toggleterm
    use("akinsho/toggleterm.nvim")

    -- gitsigns
    use({ "lewis6991/gitsigns.nvim", tag = "release" })

    -- notify
    use("rcarriga/nvim-notify")

    -- comment
    use("numToStr/Comment.nvim")

    -- which-key
    use("folke/which-key.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
