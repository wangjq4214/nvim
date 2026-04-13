-- ---------------------------------------
-- | Wang Jinquan's Neovim configuration |
-- ---------------------------------------
--
-- This configuration is designed for Neovim 0.12 and later!
-- We will use new Neovim API for package management and configuration.
--
-- And this configuration is inspired by MiniMax.

local now, later, map = utils.now, utils.later, utils.map

now(function() vim.cmd "colorscheme miniwinter" end)

later(function() require("mini.animate").setup() end)

later(function() require("mini.cursorword").setup() end)

later(function()
  local hipatterns = require "mini.hipatterns"

  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup {
    highlighters = {
      fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end)

now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require("mini.icons").setup {
    use_file_extension = function(ext, _) return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)]) end,
  }

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)

later(function()
  local minimap = require "mini.map"

  minimap.setup {
    -- Use Braille dots to encode text
    symbols = { encode = minimap.gen_encode_symbols.dot "4x2" },
    -- Show built-in search matches, 'mini.diff' hunks, and diagnostic entries
    integrations = {
      minimap.gen_integration.builtin_search(),
      minimap.gen_integration.diff(),
      minimap.gen_integration.diagnostic(),
    },
  }

  map {
    n = {
      { "<Leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", "Focus (toggle)" },
      { "<Leader>mr", "<Cmd>lua MiniMap.refresh()<CR>", "Refresh" },
      { "<Leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", "Side (toggle)" },
      { "<Leader>mt", "<Cmd>lua MiniMap.toggle()<CR>", "Toggle" },
      { "nzv", "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>", "Refresh on search" },
      { "Nzv", "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>", "Refresh on search" },
      { "*zv", "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>", "Refresh on search" },
      { "#zv", "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>", "Refresh on search" },
    },
  }
end)

now(function() require("mini.notify").setup() end)

now(function()
  local starter = require "mini.starter"

  starter.setup {
    header = table.concat({
      '      db       .g8"""bgd `7MMF\'',
      "     ;MM:    .dP'     `M   MM  ",
      "    ,V^MM.   dM'       `   MM  ",
      "   ,M  `MM   MM            MM  ",
      "   AbmmmqMA  MM.    `7MMF' MM  ",
      "  A'     VML `Mb.     MM   MM  ",
      '.AMA.   .AMMA. `"bmmmdPY .JMML.',
      "                                                                                                          ",
      "                                                                                                          ",
      '`7MMF\'     A     `7MF\'`7MMF\'`7MMF\'      `7MMF\'            .g8"""bgd   .g8""8q. `7MMM.     ,MMF\'`7MM"""YMM ',
      "  `MA     ,MA     ,V    MM    MM          MM            .dP'     `M .dP'    `YM. MMMb    dPMM    MM    `7 ",
      "   VM:   ,VVM:   ,V     MM    MM          MM            dM'       ` dM'      `MM M YM   ,M MM    MM   d   ",
      "    MM.  M' MM.  M'     MM    MM          MM            MM          MM        MM M  Mb  M' MM    MMmmMM   ",
      "    `MM A'  `MM A'      MM    MM      ,   MM      ,     MM.         MM.      ,MP M  YM.P'  MM    MM   Y  ,",
      "     :MM;    :MM;       MM    MM     ,M   MM     ,M     `Mb.     ,' `Mb.    ,dP' M  `YM'   MM    MM     ,M",
      "      VF      VF      .JMML..JMMmmmmMMM .JMMmmmmMMM       `\"bmmmd'    `\"bmmd\"' .JML. `'  .JMML..JMMmmmmMMM",
    }, "\n"),
    items = {
      starter.sections.sessions(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center"),
    },
    footer = "Have a nice day! :)",
  }
end)

now(function() require("mini.statusline").setup() end)

now(function() require("mini.tabline").setup() end)

later(function()
  require("mini.trailspace").setup()

  map {
    n = {
      { "<Leader>ot", "<Cmd>lua MiniTrailspace.trim()<CR>", "Trim trailspace" },
    },
  }
end)
