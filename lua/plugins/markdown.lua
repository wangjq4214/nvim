---@type LazySpec
return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd", "typst", "norg", "org", "vimwiki", "Avante" },
  opts = {
    preview = {
      filetypes = { "markdown", "quarto", "rmd", "typst", "norg", "org", "vimwiki", "Avante" },
      ignore_buftypes = {},
    },
  },
}
