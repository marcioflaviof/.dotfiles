-- Hyprland Lua config, translated from hyprland.conf (hyprlang).
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- You can split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144",
	position = "auto",
	scale = 1,
})

-- for i = 1, 8 do
--     hl.workspace_rule({ workspace = i, monitor = "DP-2" })
-- end
-- hl.workspace_rule({ workspace = 9, monitor = "DP-3" })

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "walker"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar & swaync & hyprpaper & elephant")
	-- Cursor theme/size is set via the env vars below, not with `gsettings set`:
	-- cursor.sync_gsettings_theme (default true) pushes Hyprland's theme+size
	-- into gsettings on theme load, which would overwrite anything set here.
	-- hl.exec_cmd("discord --disable-gpu-compositing --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu")

	-- Wait for the tray watcher before starting apps that need a system tray
	hl.exec_cmd(
		[[bash -c 'until busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1; do sleep 0.2; done; webcord']]
	)
	hl.exec_cmd("~/Documents/screenshare.sh")
	hl.exec_cmd(
		[[bash -c 'until busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1; do sleep 0.2; done; slack']]
	)

	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("walker --gapplication-service")
	hl.exec_cmd("fcitx5 -d")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- Cursor theme + size, applied before the display server starts.
-- Hyprland's cursor.sync_gsettings_theme then propagates both to gsettings,
-- so GTK/CSD clients pick up the same theme and size automatically.
hl.env("XCURSOR_THEME", "BreezeX-RosePine-Linux")
hl.env("XCURSOR_SIZE", "20") -- Hyprland's own default is 24
-- No hyprcursor-format theme is installed, so hyprcursor falls back to XCursor;
-- only the size needs setting here.
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
-- Only values that differ from Hyprland's defaults are set here.
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,

		col = {
			active_border = "rgba(33ccffee)",
			inactive_border = "rgba(595959aa)",
		},
	},

	decoration = {
		rounding = 10,

		blur = {
			size = 3, -- default is 8
		},
	},
})

-- Curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
-- ("linear" and "default" are built in, no need to define them)
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,br",
	},
})

-- Per-device config, if ever needed:
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- hl.device({ name = "logitech-pro-x-1", sensitivity = -0.5 })

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M",  hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit")) -- dwindle

-- hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("PRINT", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=sway flameshot gui"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

-- Move windows with mainMod + SHIFT + HJKL
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Resize the active window with mainMod + arrow keys
-- `relative = true` is required: without it x/y is an absolute target size,
-- so { x = 35, y = 0 } would ask for a 35x0 window -> "invalid size".
hl.bind(mainMod .. " + right", hl.dsp.window.resize({ x = 35, y = 0, relative = true }))
hl.bind(mainMod .. " + left", hl.dsp.window.resize({ x = -35, y = 0, relative = true }))
hl.bind(mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -35, relative = true }))
hl.bind(mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 35, relative = true }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Toggle keyboard layout (us <-> br); grabbed by Hyprland so it never leaks to apps
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys for volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
-- No backlight device on this machine (/sys/class/backlight is empty), so the
-- XF86MonBrightness* -> brightnessctl binds were removed. Re-add if that changes.

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
