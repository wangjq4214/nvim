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
        if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>af",
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
      desc = "Sidekick Grok Toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").select_prompt() end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
}
