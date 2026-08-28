-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/
-- See https://wiki.hypr.land/Configuring/Start/

----------------
---- MONITORS ----
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
{{hyprland_monitors}}

-------------
---- OTHER ----
-------------

require("hyprland-envs")

require("hyprland-autostart")

require("hyprland-plugins")

require("hyprland-bindings")
require("hyprland-input")
require("hyprland-look-and-feel")
require("hyprland-windows")

-------------------
---- PERMISSIONS ----
-------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
