local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

M.leader = { key = ',', mods = 'CTRL', timeout_milliseconds = 1500 }

M.keys = {
  -- LEADER+SHIFT for TAB Movement
  { key = 'l',     mods = "CMD|SHIFT", action = act.ActivateTabRelative(1), },
  { key = 'h',     mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1), },

  -- LEADER for PANE Movement
  { key = 'l',     mods = "LEADER", action = act.ActivatePaneDirection 'Right', },
  { key = 'h',     mods = "LEADER", action = act.ActivatePaneDirection 'Left', },
  { key = 'j',     mods = "LEADER", action = act.ActivatePaneDirection 'Down', },
  { key = 'k',     mods = "LEADER", action = act.ActivatePaneDirection 'Up', },

  -- splitting
  { key = '-',     mods = "LEADER", action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = '=',     mods = "LEADER", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },

  { key = 'z',     mods = 'LEADER', action = act.TogglePaneZoomState, },
  { key = 'Space', mods = 'LEADER', action = act.RotatePanes "Clockwise" },
  { key = '0',     mods = 'LEADER', action = act.PaneSelect { mode = 'SwapWithActive', } },
  { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode, },

  -- Launcher
  { key = 'm',     mods = 'LEADER', action = act.ShowLauncher},
  { key = 's',     mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
  { key = 't',     mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
  { key = 'w',      mods = 'LEADER', action = act.PromptInputLine {
    description = wezterm.format {
      { Attribute = { Intensity = 'Bold' } },
      { Foreground = { AnsiColor = 'Fuchsia' } },
      { Text = 'Enter name for Workspace:' },
    },
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:perform_action(
          act.SwitchToWorkspace {
            name = line,
          },
          pane
        )
      end
    end),
  }, },
}

return M
