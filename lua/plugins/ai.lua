-- local minute_line = {}
--
-- minute_line.processing = false
-- minute_line.spinner_index = 1
-- minute_line.n_requests = 1
-- minute_line.n_finished_requests = 0
-- minute_line.provider = nil
-- minute_line.model = nil
--
-- local default_options = {
--   -- the symbols that are used to create spinner animation
--   spinner_symbols = {
--     "⠋",
--     "⠙",
--     "⠹",
--     "⠸",
--     "⠼",
--     "⠴",
--     "⠦",
--     "⠧",
--     "⠇",
--     "⠏",
--   },
--   -- the name displayed in the lualine. Set to "provider", "model" or "both"
--   display_name = "both",
--   -- separator between provider and model name for option "both"
--   provider_model_separator = ":",
--   -- whether show display_name when no completion requests are active
--   display_on_idle = false,
-- }
--
-- -- Initializer
-- function minute_line:init()
--   self.options = default_options
--   self.spinner_symbols_len = #self.options.spinner_symbols
--
--   local group = vim.api.nvim_create_augroup("MinuetLualine", { clear = true })
--
--   vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = "MinuetRequestStartedPre",
--     group = group,
--     callback = function(request)
--       local data = request.data
--       self.processing = false
--       self.n_requests = data.n_requests
--       self.n_finished_requests = 0
--       self.provider = data.name
--       self.model = data.model
--
--       if self.options.display_name == "model" then
--         self.display_name = " " .. self.model
--       elseif self.options.display_name == "provider" then
--         self.display_name = " " .. self.provider
--       else
--         self.display_name = " " .. self.provider .. self.options.provider_model_separator .. self.model
--       end
--     end,
--   })
--
--   vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = "MinuetRequestStarted",
--     group = group,
--     callback = function() self.processing = true end,
--   })
--
--   vim.api.nvim_create_autocmd({ "User" }, {
--     pattern = "MinuetRequestFinished",
--     group = group,
--     callback = function()
--       self.n_finished_requests = self.n_finished_requests + 1
--       if self.n_finished_requests == self.n_requests then self.processing = false end
--     end,
--   })
-- end

-- Function that runs every time statusline is updated
-- function minute_line:update()
--   if self.processing then
--     self.spinner_index = (self.spinner_index % self.spinner_symbols_len) + 1
--     local request = string.format("%s (%s/%s)", self.display_name, self.n_finished_requests + 1, self.n_requests)
--     return request .. " " .. self.options.spinner_symbols[self.spinner_index]
--   else
--     return self.options.display_on_idle and self.display_name or nil
--   end
-- end

local MinuetLine = {
  static = {
    icons = {
      -- LLM Provider icons
      claude = "󰋦",
      openai = "󱢆",
      codestral = "󱎥",
      gemini = "",
      Groq = "",
      Openrouter = "󱂇",
      Ollama = "󰳆",
      ["Llama.cpp"] = "󰳆",
      Deepseek = "",
    },
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
        virtualtext = {
          auto_trigger_ft = { "*" },
          auto_trigger_ignore_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<A-A>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
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
          -- minute_line,
          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        },
      })
    end,
  },
}
