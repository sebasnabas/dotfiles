-----------------
---- KEYBINDINGS ----
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "rofi --show drun"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- hy3 dispatchers only exist once the plugin is loaded (see hyprland-plugins.lua).
-- Binds that need them are guarded so the rest of this file still loads on the
-- first config pass, before `hyprpm reload` has pulled hy3 in.
local hy3 = hl.plugin.hy3

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal .. " -e tm-sessions"))
hl.bind(mainMod .. " + SEMICOLON", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + CTRL + Q", hl.dsp.window.kill())
-- Clipboard
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))
-- Launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -modi run,drun -show drun -line-padding 4 -columns 2 -width 40 -padding 30 -hide-scrollbar -show-icons -drun-icon-theme \"Papirus\""))
-- Emoji picker
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("rofi -modes window,emoji -show emoji"))
-- Windows
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + C", hl.dsp.window.center())

-- Move focus
if hy3 then
    hl.bind(mainMod .. " + H", hy3.move_focus("l"))
    hl.bind(mainMod .. " + L", hy3.move_focus("r"))
    hl.bind(mainMod .. " + K", hy3.move_focus("u"))
    hl.bind(mainMod .. " + J", hy3.move_focus("d"))
end

-- Move focus for groups
hl.bind(mainMod .. " + CTRL + J", hl.dsp.group.next())
hl.bind(mainMod .. " + CTRL + K", hl.dsp.group.prev())

-- Move windows
if hy3 then
    hl.bind(mainMod .. " + SHIFT + H", hy3.move_window("l"))
    hl.bind(mainMod .. " + SHIFT + L", hy3.move_window("r"))
    hl.bind(mainMod .. " + SHIFT + K", hy3.move_window("u"))
    hl.bind(mainMod .. " + SHIFT + J", hy3.move_window("d"))
end

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    if hy3 then
        hl.bind(mainMod .. " + SHIFT + " .. key, hy3.move_to_workspace(tostring(i), { follow = true }))
    end
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
if hy3 then
    hl.bind(mainMod .. " + SHIFT + S", hy3.move_to_workspace("special:magic", { follow = true }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + COMMA", hl.dsp.focus({ workspace = "e+1" }))
-- with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Jump to urgent window
hl.bind(mainMod .. " + GRAVE", hl.dsp.focus({ urgent_or_last = true }))

if hy3 then
    -- Change current windows into group
    hl.bind(mainMod .. " + G", hy3.make_group("tab"))

    -- Change split orientation
    hl.bind(mainMod .. " + T", hy3.make_group("opposite", { toggle = true }))
end

-- Move workspace to monitor
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.workspace.move({ monitor = "+1" }))

-- Resize
hl.bind(mainMod .. " + SHIFT + code:59", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))   -- Left  '<'
hl.bind(mainMod .. " + SHIFT + code:60", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))    -- Right '>'
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))            -- Down  '-'
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))           -- Up    '+'
-- hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))  -- Down  '-'
-- hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = -100, relative = true })) -- Up    '+'

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume control for keyboard without multimedia keys
hl.bind(mainMod .. " + up", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(mainMod .. " + down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + p", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + left", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("playerctl next"))

-- Function keys
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.scripts/statusbar/powermenu"))

-- Screenshot
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("~/.scripts/tools/screenshot"))
