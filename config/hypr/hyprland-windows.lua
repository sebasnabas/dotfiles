--------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules
-- Rules are evaluated top to bottom, so the order they're written in does matter!

-- Windows

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_initial_focus = true,
})

-- Firefox & Zen
hl.window_rule({ match = { class = "^(firefox|zen)$" }, workspace = "2" })

-- Thunderbird
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$" }, workspace = "3" })

-- Bitwarden Chrome Extension
hl.window_rule({ match = { class = "^(chrome-nngceckbapebfimnlniiiahkandclblb-Default)$" }, tag = "+floating-window" })

-- Steam
-- Steam updater
hl.window_rule({ match = { class = "^()$", title = "Steam" }, float = true, center = true })
-- Steam
hl.window_rule({ match = { class = "^(steam)$" }, workspace = "9" })
hl.window_rule({ match = { class = "^(steam)$", title = "Steam" }, center = true })
hl.window_rule({ match = { class = "steam" }, opacity = "1 1" })
hl.window_rule({ match = { class = "^(steam)$", title = "Friends List" }, float = true })
hl.window_rule({ match = { class = "steam" }, idle_inhibit = "fullscreen" })
-- Steam games
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, workspace = "9", float = true, center = true })

-- Floating windows
hl.window_rule({ match = { tag = "floating-window" }, float = true })
hl.window_rule({ match = { tag = "floating-window" }, center = true })
hl.window_rule({ match = { tag = "floating-window" }, size = { 875, 600 } })

hl.window_rule({
    match = { class = "(blueberry.py|com.omarchy.Impala|com.omarchy.Wiremix|com.omarchy.Omarchy|org.gnome.NautilusPreviewer|com.gabm.satty|Omarchy|About|TUI.float|^chrome-[a-z]+-Default$)" },
    tag = "+floating-window",
})
hl.window_rule({
    match = {
        class = "(xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus)",
        title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
    },
    tag = "+floating-window",
})
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$", title = "^(.* Reminders)$" }, tag = "+floating-window" })
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$", title = "^(Message Filters)$" }, tag = "+floating-window" })
-- All other Thunderbird windows, e.g., event editor
hl.window_rule({ match = { class = "^(org.mozilla.Thunderbird)$", title = "^()$" }, tag = "+floating-window" })
-- Empty
hl.window_rule({ match = { class = "^()$", title = "^()$" }, tag = "+floating-window" })
-- Nextcloud
hl.window_rule({ match = { class = "$(com.nextcloud.desktopclient.nextcloud)$", title = "^(Nextcloud)$" }, tag = "+floating-window" })

-- Workspaces

{{hyprland_workspace_rules}}
