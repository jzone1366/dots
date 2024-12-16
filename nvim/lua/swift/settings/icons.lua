return {
    lsp = {
      error = '', -- alts: 󰬌      
      warn = '󰔷', -- alts: 󰬞 󰔷   ▲ 󰔷
      info = '󰖧', -- alts: 󰖧 󱂈 󰋼  󰙎   󰬐 󰰃     ● 󰬐 
      hint = '▫', -- alts:  󰬏 󰰀  󰌶 󰰂 󰰂 󰰁 󰫵 󰋢   
      ok = '✓', -- alts: ✓✓
      clients = '', -- alts:     󱉓 󱡠 󰾂 
    },

    test = {
      passed = '', --alts: 
      failed = '', --alts: 
      running = '',
      skipped = '○',
      unknown = '', -- alts: 
    },

    vscode = {
      Text = '󰉿 ',
      Method = '󰆧 ',
      Function = '󰊕 ',
      Constructor = ' ',
      Field = '󰜢 ',
      Variable = '󰀫 ',
      Class = '󰠱 ',
      Interface = ' ',
      Module = ' ',
      Property = '󰜢 ',
      Unit = '󰑭 ',
      Value = '󰎠 ',
      Enum = ' ',
      Keyword = '󰌋 ',
      Snippet = ' ',
      Color = '󰏘 ',
      File = '󰈙 ',
      Reference = '󰈇 ',
      Folder = '󰉋 ',
      EnumMember = ' ',
      Constant = '󰏿 ',
      Struct = '󰙅 ',
      Event = ' ',
      Operator = '󰆕 ',
      TypeParameter = ' ',
      Copilot = '',
    },

    kind = {
      Array = '',
      Boolean = '',
      Class = '󰠱',
      -- Class = "", -- Class
      Codeium = '',
      Copilot = '',
      Color = '󰏘',
      -- Color = "", -- Color
      Constant = '󰏿',
      -- Constant = "", -- Constant
      Constructor = '',
      -- Constructor = "", -- Constructor
      Enum = '', -- alts: 
      -- Enum = "", -- Enum -- alts: 了
      EnumMember = '', -- alts: 
      -- EnumMember = "", -- EnumMember
      Event = '',
      Field = '󰜢',
      File = '󰈙',
      -- File = "", -- File
      Folder = '󰉋',
      -- Folder = "", -- Folder
      Function = '󰊕',
      Interface = '',
      Key = '',
      Keyword = '󰌋',
      -- Keyword = "", -- Keyword
      Method = '',
      Module = '',
      Namespace = '',
      Null = '󰟢', -- alts: 󰱥󰟢
      Number = '󰎠', -- alts: 
      Object = '',
      -- Operator = "\u{03a8}", -- Operator
      Operator = '󰆕',
      Package = '',
      Property = '󰜢',
      -- Property = "", -- Property
      Reference = '󰈇',
      Snippet = '', -- alts: 
      String = '', -- alts:  󱀍 󰀬 󱌯
      Struct = '󰙅',
      Text = '󰉿',
      TypeParameter = '',
      Unit = '󰑭',
      -- Unit = "", -- Unit
      Value = '󰎠',
      Variable = '󰀫',
      -- Variable = "", -- Variable, alts: 

      -- Text = "",
      -- Method = "",
      -- Function = "",
      -- Constructor = "",
      -- Field = "",
      -- Variable = "",
      -- Class = "",
      -- Interface = "",
      -- Module = "",
      -- Property = "",
      -- Unit = "",
      -- Value = "",
      -- Enum = "",
      -- Keyword = "",
      -- Snippet = "",
      -- Color = "",
      -- File = "",
      -- Reference = "",
      -- Folder = "",
      -- EnumMember = "",
      -- Constant = "",
      -- Struct = "",
      -- Event = "",
      -- Operator = "",
      -- TypeParameter = "",
    },

    separators = {
      thin_block = '│',
      left_thin_block = '▏',
      vert_bottom_half_block = '▄',
      vert_top_half_block = '▀',
      right_block = '🮉',
      right_med_block = '▐',
      light_shade_block = '░',
    },

    misc = {
      formatter = '', -- alts: 󰉼
      buffers = '',
      clock = '',
      ellipsis = '…',
      lblock = '▌',
      rblock = '▐',
      bug = '', -- alts: 
      question = '',
      lock = '󰌾', -- alts:   
      shaded_lock = '',
      circle = '',
      project = '',
      dashboard = '',
      history = '󰄉',
      comment = '󰅺',
      robot = '󰚩', -- alts: 󰭆
      lightbulb = '󰌵',
      file_tree = '󰙅',
      help = '󰋖', -- alts: 󰘥 󰮥 󰮦 󰋗 󰞋 󰋖
      search = '', -- alts: 󰍉
      code = '',
      telescope = '',
      terminal = '', -- alts: 
      gear = '',
      package = '',
      list = '',
      sign_in = '',
      check = '✓', -- alts: ✓
      fire = '',
      note = '󰎛',
      bookmark = '',
      pencil = '󰏫',
      arrow_right = '',
      caret_right = '',
      chevron_right = '',
      double_chevron_right = '»',
      table = '',
      calendar = '',
      fold_open = '',
      fold_close = '',
      hydra = '🐙',
      flames = '󰈸', -- alts: 󱠇󰈸
      vsplit = '◫',
      v_border = '▐ ',
      virtual_text = '◆',
      mode_term = '',
      ln_sep = 'ℓ', -- alts: ℓ 
      sep = '⋮',
      perc_sep = '',
      modified = '', -- alts: ∘✿✸✎ ○∘●●∘■ □ ▪ ▫● ◯ ◔ ◕ ◌ ◎ ◦ ◆ ◇ ▪▫◦∘∙⭘
      mode = '',
      vcs = '',
      readonly = '',
      prompt = '',
      console_debug = '  ',
      markdown = {
        h1 = '◉', -- alts: 󰉫¹◉
        h2 = '◆', -- alts: 󰉬²◆
        h3 = '󱄅', -- alts: 󰉭³✿
        h4 = '⭘', -- alts: 󰉮⁴○⭘
        h5 = '◌', -- alts: 󰉯⁵◇◌
        h6 = '', -- alts: 󰉰⁶
        dash = '',
      },
    },

    git = {
      add = '▕', -- alts:  ▕,▕, ▎, ┃, │, ▌, ▎ 🮉
      change = '▕', -- alts:  ▕ ▎║▎
      mod = '',
      remove = '', -- alts: 
      delete = '🮉', -- alts: ┊▎▎
      topdelete = '🮉',
      changedelete = '🮉',
      untracked = '▕',
      ignore = '',
      rename = '',
      diff = '',
      repo = '',
      symbol = '', -- alts:  
      unstaged = '󰛄',
    },
}
