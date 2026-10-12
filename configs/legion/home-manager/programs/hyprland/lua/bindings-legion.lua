local v = require("lib.vars")

hl.bind(v.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(v.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
