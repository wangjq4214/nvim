local M = {}

M.setup = function()
  local lazy_load = require("plugins.lazy_load")

  lazy_load.lazy_load({
    events = { "BufRead", "BufWinEnter", "BufNewFile" },
    augroup_name = "TreesitterLazy",
    plugins = "nvim-treesitter",
    condition = function()
      local file = vim.fn.expand("%")
      return file ~= "NvimTree_1" and file ~= "[packer]" and file ~= ""
    end
  })
end

local options = {
  ensure_installed = { 
    "c",
    "go",
    "rust",
    "bash",
    "cmake",
    "cpp",
    "css",
    "gomod",
    "gowork",
    "java",
    "javascript",
    "json5",
    "lua",
    "make",
    "python",
    "regex",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "vue",
    "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  }
}

M.config = function()
  local ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  treesitter.setup(options)

  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  vim.opt.foldlevel  = 99
end

M.cmds = {
  "TSInstall",
  "TSBufEnable",
  "TSBufDisable",
  "TSEnable",
  "TSDisable",
  "TSModuleInfo",
}

return M

