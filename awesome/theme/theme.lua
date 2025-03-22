-- Catppuccin Mocha colours
local catppuccinMochaColours    = {
    rosewater = "#f5e0dc",
    flamingo  = "#f2cdcd",
    pink      = "#f5c2e7",
    mauve     = "#cba6f7",
    red       = "#f38ba8",
    maroon    = "#eba0ac",
    peach     = "#fab387",
    yellow    = "#f9e2af",
    green     = "#a6e3a1",
    teal      = "#94e2d5",
    sky       = "#89dceb",
    sapphire  = "#74c7ec",
    blue      = "#89b4fa",
    lavender  = "#b4befe",
    text      = "#cdd6f4",
    subtext1  = "#bac2de",
    subtext0  = "#a6adc8",
    overlay2  = "#9399b2",
    overlay1  = "#7f849c",
    overlay0  = "#6c7086",
    surface2  = "#585b70",
    surface1  = "#45475a",
    surface0  = "#313244",
    base      = "#1e1e2e",
    mantle    = "#181825",
    crust     = "#11111b",
}
return {
    colours                   = catppuccinMochaColours,
    -- Basic Theme Settings
    font                      = "JetBrainsMono Nerd Font 14",
    bg_normal                 = catppuccinMochaColours.base,
    bg_focus                  = catppuccinMochaColours.surface0,
    bg_urgent                 = catppuccinMochaColours.red,
    bg_minimize               = catppuccinMochaColours.surface1,
    fg_normal                 = catppuccinMochaColours.text,
    fg_focus                  = catppuccinMochaColours.lavender,
    fg_urgent                 = catppuccinMochaColours.crust,
    fg_minimize               = catppuccinMochaColours.overlay2,

    -- Gaps and Borders
    useless_gap               = 0,
    border_width              = 0,
    border_normal             = catppuccinMochaColours.surface0,
    border_focus              = catppuccinMochaColours.lavender,
    border_marked             = catppuccinMochaColours.peach,

    -- Titlebars
    titlebar_bg_focus         = catppuccinMochaColours.surface0,
    titlebar_bg_normal        = catppuccinMochaColours.base,

    titlebar_fg_focus         = catppuccinMochaColours.lavender,

    tasklist_bg_focus         = catppuccinMochaColours.surface0,
    tasklist_fg_focus         = catppuccinMochaColours.lavender,

    taglist_bg_focus          = catppuccinMochaColours.surface0,
    taglist_fg_focus          = catppuccinMochaColours.mauve,

    -- Notifications
    notification_bg           = catppuccinMochaColours.base,
    notification_fg           = catppuccinMochaColours.text,
    notification_border_color = catppuccinMochaColours.overlay0,
    notification_border_width = 2,

    menu_height               = 20,
    menu_width                = 140,
}
