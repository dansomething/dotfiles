-- Install these to ~/.hammerspoon/Spoons
-- https://github.com/jasonrudolph/ControlEscape.spoon
-- https://github.com/miromannino/miro-windows-manager

-- ControlEscape.spoon
hs.loadSpoon('ControlEscape'):start()

-- Miro's windows manager
local hyper = {"alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})
