---@type LazySpec
return {
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-m>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle { focus = true } end,
      desc = "Sidekick Toggle CLI",
      mode = { "n", "v" },
    },
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
      desc = "Sidekick Claude Toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>ao",
      function() require("sidekick.cli").toggle { name = "codex", focus = true } end,
      desc = "Sidekick Codex Toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
  dependencies = {
    {
      "saghen/blink.cmp",
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {

        keymap = {
          ["<Tab>"] = {
            "snippet_forward",
            function() -- sidekick next edit suggestion
              return require("sidekick").nes_jump_or_apply()
            end,
            -- function() -- if you are using Neovim's native inline completions
            --   return vim.lsp.inline_completion.get()
            -- end,
            "fallback",
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astroui.status"

        local sidekick_component = status.component.builder {
          {
            provider = function() return " " end,
          },
          condition = function()
            local ok, sk = pcall(require, "sidekick.status")
            return ok and sk.get() ~= nil
          end,
          hl = function()
            local get_hl = require("astroui").get_hlgroup
            local sk = require("sidekick.status").get()

            local grp = "Special"
            if sk then
              if sk.kind == "Error" then
                grp = "DiagnosticError"
              elseif sk.busy then
                grp = "DiagnosticWarn"
              end
            end
            return { fg = get_hl(grp).fg }
          end,
          surround = { separator = "right" },
        }

        opts.statusline = {
          hl = { fg = "fg", bg = "bg" },

          status.component.mode(),
          status.component.git_branch(),
          status.component.file_info(),
          status.component.git_diff(),
          status.component.diagnostics(),

          status.component.fill(),

          status.component.cmd_info(),

          status.component.fill(),

          status.component.lsp(),
          status.component.virtual_env(),
          status.component.treesitter(),

          sidekick_component,

          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        }
      end,
    },
  },
}
