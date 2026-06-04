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

-- Dedicated, gap-less workspace for Godot.
hl.workspace_rule({
  workspace  = "name:godot",
  persistent = true,
  gaps_in    = 0,
  gaps_out   = 0,
})

-- Send every Godot window (project manager, editor, dialogs) to its workspace
-- instead of opening on whatever workspace is currently focused.
hl.window_rule({
  name      = "Godot Workspace",
  workspace = "name:godot",
  match     = { class = "^Godot$" },
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


