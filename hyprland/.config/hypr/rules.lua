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
    match = { class = "^(Aseprite)$" },
    tile  = true,
})

hl.window_rule({
  name = "Godot Float Internal Windows",
  float = true,
  tile = false,
  match = { class = "^Godot$" , initial_title = nil }, -- keep generic; filtered by next rule
})

hl.window_rule({
  name = "Godot Tile Main Window",
  float = false,
  tile = true,
  match = { class = "^Godot$", initial_title = "^Godot$" },
})


