-- Plugins

-- Plugin options and dispatchers only exist once the plugin itself is loaded,
-- which happens asynchronously via `hyprpm reload` in hyprland-autostart.lua.
-- Loading a plugin makes Hyprland reload its config, so this file runs a second
-- time with hl.plugin.hy3 populated -- hence the guard.
-- See https://wiki.hypr.land/Plugins/Using-Plugins/#how-do-i-use-them-in-my-config
if hl.plugin.hy3 == nil then
    return
end

hl.config({
    plugin = {
        hy3 = {
            -- disable gaps when only one window is onscreen
            -- 0 - always show gaps
            -- 1 - hide gaps with a single window onscreen
            -- 2 - 1 but also show the window border
            no_gaps_when_only = 1,

            -- policy controlling what happens when a node is removed from a group,
            -- leaving only a group
            -- 0 = remove the nested group
            -- 1 = keep the nested group
            -- 2 = keep the nested group only if its parent is a tab group
            node_collapse_policy = 2,

            -- offset from group split direction when only one window is in a group
            group_inset = 10,

            -- if a tab group will automatically be created for the first window spawned in a workspace
            tab_first_window = false,

            -- tab group settings
            tabs = {
                -- height of the tab bar
                height = 22,

                -- padding between the tab bar and its focused node
                padding = 6,

                -- the tab bar should animate in/out from the top instead of below the window
                from_top = false,

                -- radius of tab bar corners
                radius = 6,

                -- tab bar border width
                border_width = 2,

                -- render the window title on the bar
                render_text = true,

                -- center the window title
                text_center = true,

                -- font to render the window title with
                text_font = "Sans",

                -- height of the window title
                text_height = 8,

                -- left padding of the window title
                text_padding = 3,

                -- Tab bar colors. Uncomment into a `colors = { ... }` subtable.

                -- active tab bar segment colors
                -- active = <color>,        -- default: rgba(33ccff40)
                -- active_border = <color>, -- default: rgba(33ccffee)
                -- active_text = <color>,   -- default: rgba(ffffffff)

                -- active tab bar segment colors for bars on an unfocused monitor
                -- active_alt_monitor = <color>,        -- default: rgba(60606040)
                -- active_alt_monitor_border = <color>, -- default: rgba(808080ee)
                -- active_alt_monitor_text = <color>,   -- default: rgba(ffffffff)

                -- focused tab bar segment colors (focused node in unfocused container)
                -- focused = <color>,        -- default: rgba(60606040)
                -- focused_border = <color>, -- default: rgba(808080ee)
                -- focused_text = <color>,   -- default: rgba(ffffffff)

                -- inactive tab bar segment colors
                -- inactive = <color>,        -- default: rgba(30303020)
                -- inactive_border = <color>, -- default: rgba(606060aa)
                -- inactive_text = <color>,   -- default: rgba(ffffffff)

                -- urgent tab bar segment colors
                -- urgent = <color>,        -- default: rgba(ff223340)
                -- urgent_border = <color>, -- default: rgba(ff2233ee)
                -- urgent_text = <color>,   -- default: rgba(ffffffff)

                -- locked tab bar segment colors
                -- locked = <color>,        -- default: rgba(90903340)
                -- locked_border = <color>, -- default: rgba(909033ee)
                -- locked_text = <color>,   -- default: rgba(ffffffff)

                -- if tab backgrounds should be blurred
                -- Blur is only visible when the above colors are not opaque.
                blur = true,

                -- opacity multiplier for tabs
                -- Applies to blur as well as the given colors.
                opacity = 1.0,
            },

            -- autotiling settings
            autotile = {
                -- enable autotile
                enable = true,

                -- make autotile-created groups ephemeral
                ephemeral_groups = true,

                -- if a window would be squished smaller than this width, a vertical split will be created
                -- -1 = never automatically split vertically
                -- 0 = always automatically split vertically
                -- <number> = pixel width to split at
                trigger_width = 0, -- default: 0

                -- if a window would be squished smaller than this height, a horizontal split will be created
                -- -1 = never automatically split horizontally
                -- 0 = always automatically split horizontally
                -- <number> = pixel height to split at
                trigger_height = 0,

                -- a space or comma separated list of workspace ids where autotile should be enabled
                -- it's possible to create an exception rule by prefixing the definition with "not:"
                -- workspaces = "1,2"     -- autotiling will only be enabled on workspaces 1 and 2
                -- workspaces = "not:1,2" -- autotiling will be enabled on all workspaces except 1 and 2
                workspaces = "all",
            },
        },
    },
})
