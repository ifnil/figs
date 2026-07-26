hl.curve("spike", { type = "bezier", points = { { 0, 0.9 }, { 0, 1.0 } } })
hl.curve("spikesoft", { type = "bezier", points = { { 0, 0.9 }, { 0.29, 1.03 } } })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "spikesoft" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, bezier = "spikesoft" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "spikesoft" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "spikesoft" })
hl.animation({ leaf = "fade", enabled = false })
