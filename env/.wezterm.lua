local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end
--
-- For example, changing the color scheme:
config.font =
    wezterm.font('JetBrains Mono', { weight = 'Regular' })
config.font_size = 16

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.89
config.macos_window_background_blur = 10
config.warn_about_missing_glyphs = false

-- tmux
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab "CurrentPaneDomain",
  },
  {
    mods = "LEADER",
    key = "x",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },
  {
    mods = "LEADER",
    key = "b",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1)
  },
  {
    mods = "LEADER",
    key = "\\",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "-",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    mods = "LEADER",
    key = "o",
    action = wezterm.action.ActivatePaneDirection "Next"
  },
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.AdjustPaneSize { "Left", 5 }
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.AdjustPaneSize { "Right", 5 }
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.AdjustPaneSize { "Down", 5 }
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.AdjustPaneSize { "Up", 5 }
  },
  {
    mods = "LEADER",
    key = "z",
    action = wezterm.action.TogglePaneZoomState
  },
}

for i = 0, 9 do
  -- leader + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- leader indicator
wezterm.on("update-right-status", function(window, _)
  local prefix = ""
  if window:leader_is_active() then
    prefix = " <> "
  end

  window:set_left_status(wezterm.format {
    { Background = { Color = "#ebcb8b" } },
    { Foreground = { Color = "#434c5e" } },
    { Text = prefix },
  })
end)

config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
  tab_bar = {
    background = "#011423",
    new_tab = {
      bg_color = "#88c0d0",
      fg_color = "#011423",
    }
  }
}

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local idx = tab.tab_index
    local title = tab.tab_title or "Shell"
    local name =  string.format(" [%d] %s ", idx + 1, title)
    if string.len(title) < 1 then
      name =  string.format(" [%d] ", idx + 1)
    end

    local bg_color = "#011423"
    local fg_color = "#8fbcbb"
    if tab.is_active then
      bg_color = "#8fbcbb"
      fg_color = "#011423"
    end

    return {
      { Background = { Color = bg_color } },
      { Foreground = { Color = fg_color } },
      { Text = name }
    }
  end
)

-- and finally, return the configuration to wezterm
return config
