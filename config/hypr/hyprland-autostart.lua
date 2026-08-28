---------------
---- AUTOSTART ----
---------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local gnomeSchema = "org.gnome.desktop.interface"

-- hl.exec_cmd() spawns asynchronously, so no trailing `&` / `disown` is needed.
hl.on("hyprland.start", function()
    -- Load plugins
    hl.exec_cmd("hyprpm reload -n")

    -- Notification daemon
    hl.exec_cmd("dunst")

    -- Configure GTK
    hl.exec_cmd("gsettings set " .. gnomeSchema .. " gtk-theme 'gruvbox-dark-gtk'")
    hl.exec_cmd("gsettings set " .. gnomeSchema .. " color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set " .. gnomeSchema .. " icon-theme 'Papirus'")

    -- Status bar
    hl.exec_cmd("waybar")

    -- Utils
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("udiskie -s -n")
    hl.exec_cmd("protonmail-bridge -c")
    hl.exec_cmd("nextcloud --background")
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("system-config-printer-applet")

    -- Wallpaper
    hl.exec_cmd("hyprpaper")
    -- Idle Management daemon
    hl.exec_cmd("hypridle")

    -- Clipboard manager
    hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    --  When copying something on Wayland, the copied data remains in the clipboard until the application that was copied from is closed; after that, the data disappears and can no longer be pasted.
    -- To fix this problem, you can use wl-clip-persist which will preserve the data in the clipboard after the application is closed.
    hl.exec_cmd("wl-clip-persist --clipboard regular")

    -- Make screen sharing work
    -- Make sure that xdg-desktop-portal-hyprland can get the required variables on startup.
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
