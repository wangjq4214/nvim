-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Pack import
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python-ruff" },
  -- Motion import
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  -- color scheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.tokyodark-nvim" },
  { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  -- cmp
  { import = "astrocommunity.completion.avante-nvim" },
}
