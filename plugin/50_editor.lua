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
    "https://github.com/saghen/blink.lib",
    { src = "https://github.com/saghen/blink.pairs", version = vim.version.range "*" },
  }

  require("blink.pairs").download():pwait(60000)
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
      toml = { "tombi" },
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

later(function()
  vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }

  local treesitter = require "nvim-treesitter"
  local parsers = require "nvim-treesitter.parsers"
  local installing, failed = {}, {}

  local function start_parser(buf, lang)
    if not vim.api.nvim_buf_is_loaded(buf) then return end
    if vim.treesitter.language.get_lang(vim.bo[buf].filetype) == lang then
      pcall(vim.treesitter.start, buf, lang)
    end
  end

  local function ensure_parser(buf)
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
    if not lang or not parsers[lang] or parsers[lang].tier == 4 then return end

    if vim.treesitter.language.add(lang) then
      start_parser(buf, lang)
      return
    end
    if installing[lang] or failed[lang] then return end
    installing[lang] = true

    treesitter.install({ lang }):await(function(err, success)
      installing[lang] = nil
      if err or not success then
        failed[lang] = true -- Avoid retrying a broken install for every buffer in this session.
        vim.notify("Treesitter parser install failed for " .. lang .. "; check :messages", vim.log.levels.WARN)
        return
      end

      for _, loaded_buf in ipairs(vim.api.nvim_list_bufs()) do
        start_parser(loaded_buf, lang)
      end
    end)
  end

  utils.new_autocmd("FileType", "*", function(ev) ensure_parser(ev.buf) end, "Install and start Treesitter parsers")
  -- The initial FileType event can fire before this deferred setup runs.
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then ensure_parser(buf) end
  end

  map {
    n = {
      {
        "<Leader>pt",
        function()
          local filetype = vim.bo.filetype
          if filetype == "" then
            vim.notify("Cannot install a Treesitter parser: buffer has no filetype", vim.log.levels.WARN)
            return
          end

          treesitter.install { vim.treesitter.language.get_lang(filetype) or filetype }
        end,
        "Install Treesitter parser for current filetype",
      },
      {
        "<Leader>pT",
        function()
          vim.notify("Updating installed Treesitter parsers…")
          vim.cmd "TSUpdate"
        end,
        "Update installed Treesitter parsers",
      },
    },
  }
end)

later(function() require("mini.pairs").setup { modes = { command = true } } end)

later(function() require("mini.splitjoin").setup() end)

later(function() require("mini.surround").setup() end)

later(function()
  vim.pack.add {
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  }

  require('render-markdown').setup({})
end)
