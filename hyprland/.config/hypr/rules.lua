hl.window_rule({
    name  = "ignore-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "xwayland-drag-fix",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "force-tile",
    match = { class = "^(Aseprite|Godot)$" },
    tile  = true,
})
