-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

local later, map = utils.later, utils.map

later(function()
  local ai = require "mini.ai"
  ai.setup {
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      F = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
    },

    search_method = "cover",
  }
end)

later(function() require("mini.align").setup() end)

later(function()
  vim.pack.add {
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range "1" },
    "https://github.com/rafamadriz/friendly-snippets",
  }

  require("blink.cmp").setup {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
  }
end)

later(function()
  vim.pack.add { "https://github.com/saghen/blink.indent" }

  local indent = require "blink.indent"
  map {
    n = {
      { "<Leader>oi", "<Cmd>lua indent.enable(not indent.is_enabled())<CR>", "Toggle indent guides" },
    },
  }
end)

later(function()
  vim.pack.add {
    { src = "https://github.com/saghen/blink.pairs", version = vim.version.range "0" },
    "https://github.com/saghen/blink.download",
  }

  require("blink.pairs").setup {}
end)

later(function() require("mini.comment").setup() end)

later(function()
  vim.pack.add { "https://github.com/stevearc/conform.nvim" }

  require("conform").setup {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt", lsp_format = "fallback" },
      javascript = { "oxfmt" },
      typescript = { "oxfmt" },
      markdown = { "oxfmt" },
      dart = { "dart_format" },
      json = { "oxfmt" },
      yaml = { "yamlfmt" },
      toml = { "tomlbi" },
    },
  }
end)

later(function()
  vim.pack.add {
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
  }

  require("mason").setup()

  require("mason-lspconfig").setup {
    automatic_enable = false,
  }

  map {
    n = {
      { "<Leader>pm", "<Cmd>Mason<CR>", "Mason" },
    },
  }
end)

later(function()
  vim.pack.add {
    { src = "https://github.com/neovim/nvim-lspconfig" },
  }
end)

later(function() require("mini.move").setup() end)

later(function() require("mini.pairs").setup { modes = { command = true } } end)

later(function() require("mini.splitjoin").setup() end)

later(function() require("mini.surround").setup() end)
