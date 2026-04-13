-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

local map = utils.map

map {
  n = {
    { "[p", '<Cmd>exe "iput! " . v:register<CR>', "Paste Above" },
    { "]p", '<Cmd>exe "iput "  . v:register<CR>', "Paste Below" },
  },
}

map {
  n = { { "<Leader>pu", "<Cmd>lua vim.pack.update()<CR>", "Update Packages" } },
}

map {
  n = {
    { "<Leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Actions" },
    { "<Leader>ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic popup" },
    { "<Leader>lf", '<Cmd>lua require("conform").format()<CR>', "Format" },
    { "<Leader>li", "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
    { "<Leader>lh", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    { "<Leader>ll", "<Cmd>lua vim.lsp.codelens.run()<CR>", "Lens" },
    { "<Leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    { "<Leader>lR", "<Cmd>lua vim.lsp.buf.references()<CR>", "References" },
    { "<Leader>ls", "<Cmd>lua vim.lsp.buf.definition()<CR>", "Source definition" },
    { "<Leader>lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition" },
  },
  x = {
    { "<Leader>lf", '<Cmd>lua require("conform").format()<CR>', "Format selection" },
  },
}

map {
  n = {
    { "<Leader>tT", "<Cmd>horizontal term<CR>", "Terminal (horizontal)" },
    { "<Leader>tt", "<Cmd>vertical term<CR>", "Terminal (vertical)" },
  },
}

map {
  n = {
    { "|", "<Cmd>vsplit<CR>", "Vertical split" },
    { "-", "<Cmd>split<CR>", "Horizontal split" },
  },
}
