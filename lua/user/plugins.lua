local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  })
end

return require("packer").startup({
  function(use)
    -- self
    use("wbthomason/packer.nvim")

    -- colorscheme
    use("folke/tokyonight.nvim")

    -- tree
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }
    })

    -- lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")

    -- telescope
    use({ 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } })
    -- telescope extension
    use("LinArcX/telescope-env.nvim")

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
      end
    }
  }
})
