---@type LazySpec
return {
  "folke/sidekick.nvim",
  ---@type sidekick.Config
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
    },
  },
  dependencies = {
    {
      "astronvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<tab>"] = {
              function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if not require("sidekick").nes_jump_or_apply() then
                  return "<Tab>" -- fallback to normal tab
                end
              end,
              desc = "Sidekick Next Edit or Apply",
              expr = true,
            },
            ["<C-n>"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Sidekick Switch Focus",
            },
            ["<Leader>a"] = {
              desc = "SSidekick",
            },
            ["<Leader>aa"] = {
              function() require("sidekick.cli").toggle { focus = true } end,
              desc = "Sidekick Toggle CLI",
            },
            ["<Leader>as"] = {
              function() require("sidekick.cli").select() end,
              desc = "Select CLI",
            },
            ["<Leader>ad"] = {
              function() require("sidekick.cli").close() end,
              desc = "Detach a CLI Session",
            },
            ["<Leader>at"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This",
            },
            ["<Leader>af"] = {
              function() require("sidekick.cli").send { msg = "{file}" } end,
              desc = "Send File",
            },
            ["<Leader>ap"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Sidekick Select Prompt",
            },
          },
          i = {
            ["<C-n>"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Sidekick Switch Focus",
            },
          },
          x = {
            ["<C-n>"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Sidekick Switch Focus",
            },
            ["<Leader>at"] = {
              function() require("sidekick.cli").send { msg = "{this}" } end,
              desc = "Send This",
            },
            ["<Leader>av"] = {
              function() require("sidekick.cli").send { msg = "{selection}" } end,
              desc = "Send Visual Selection",
            },
            ["<Leader>ap"] = {
              function() require("sidekick.cli").prompt() end,
              desc = "Sidekick Select Prompt",
            },
          },
          t = {
            ["<C-n>"] = {
              function() require("sidekick.cli").focus() end,
              desc = "Sidekick Switch Focus",
            },
          },
        },
      },
    },
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
