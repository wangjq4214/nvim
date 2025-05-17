local MinuetLine = {
  condition = function() return package.loaded.minuet end,
  update = {
    "User",
    pattern = { "MinuetRequestStarted", "MinuetRequestStartedPre", "MinuetRequestFinished" },
    callback = function(self, req)
      if req.match == "MinuetRequestStartedPre" then
        local data = req.data

        self.processing = false
        self.n_requests = data.n_requests
        self.n_finished = 0

        return true
      end

      if req.match == "MinuetRequestStarted" then
        self.processing = true
        return true
      end

      self.n_finished = self.n_finished + 1
      if self.n_finished == self.n_requests then self.processing = false end

      return true
    end,
  },
  {
    hl = function(self)
      if self.processing then
        local utils = require "heirline.utils"
        return { fg = utils.get_highlight("String").fg }
      end

      return nil
    end,
    provider = " 󰰐",
  },
  {
    condition = function(self)
      if self.processing then return true end
      return nil
    end,
    provider = function(self)
      local finished = self.n_finished
      local requests = self.n_requests
      return " (" .. finished .. "/" .. requests .. ")"
    end,
  },
}

---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    event = "User AstroFile",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
    config = function()
      require("codecompanion").setup {
        strategies = {
          chat = {
            adapter = "deepseek",
          },
          inline = {
            adapter = "deepseek",
          },
          cmd = {
            adapter = "deepseek",
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "milanglacier/minuet-ai.nvim",
    event = "User AstroFile",
    cmd = {
      "Minuet",
    },
    config = function()
      require("minuet").setup {
        provider = "openai_fim_compatible",
        provider_options = {
          openai_fim_compatible = {
            api_key = "DEEPSEEK_API_KEY",
            name = "deepseek",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>aa"] = {
            function() vim.cmd "CodeCompanionActions" end,
            desc = "Open codecompanion actions panel",
          },
          ["<Leader>ai"] = {
            function() vim.cmd "CodeCompanion" end,
            desc = "Open codecompanion inline assistant",
          },
          ["<Leader>ac"] = {
            function() vim.cmd "CodeCompanionChat" end,
            desc = "Open codecompanion chat buffer",
          },
        },
      },
    },
  },
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        keymap = {
          -- Manually invoke minuet completion.
          ["<A-y>"] = require("minuet").make_blink_map(),
        },
        sources = {
          -- Enable minuet for autocomplete
          default = { "lsp", "path", "buffer", "snippets", "minuet" },
          -- For manual completion only, remove 'minuet' from default
          providers = {
            minuet = {
              name = "minuet",
              module = "minuet.blink",
              async = true,
              -- Should match minuet.config.request_timeout * 1000,
              -- since minuet.config.request_timeout is in seconds
              timeout_ms = 3000,
              score_offset = 50, -- Gives minuet higher priority among suggestions
            },
          },
        },
        -- Recommended to avoid unnecessary request
        completion = { trigger = { prefetch_on_insert = false } },
      })
    end,
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"

      return require("astrocore").extend_tbl(opts, {
        statusline = { -- statusline
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
          status.component.nav(),
          MinuetLine,
          status.component.mode { surround = { separator = "right" } },
        },
      })
    end,
  },
}
