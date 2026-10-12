local v = require("lib.vars")
local mod = v.mainMod

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(v.terminal))
hl.bind(mod .. " + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(v.menu))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("emacs"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphistdecode | wl-copy"))

hl.bind("ALT + F", hl.dsp.exec_cmd(v.terminal .. " start ranger"))
hl.bind("ALT + P", hl.dsp.exec_cmd(v.terminal .. " start pulsemixer"))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        [[grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the region taken" -t 1000]]
    )
)

hl.bind(
    "SHIFT + Print",
    hl.dsp.exec_cmd(
        [[grim -c - | wl-copy && wl-paste > ~/Screenshots/Screenshot-$(date +%F_%T).png | dunstify "Screenshot of the whole screen taken"]]
    )
)

local smw = require("plugins.split-monitor-workspaces")

smw.setup({
    workspace_count = 10,
})

for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    local key = (n == "10") and "0" or n
    hl.bind(mod .. " + " .. key, smw.workspace(n))
    hl.bind(mod .. " + SHIFT + " .. key, smw.move_to_workspace_silent(n))
end

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
