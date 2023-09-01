-- Run ~/.hammerspoon/install
-- Open Hammerspoon app
-- Enable Hammerspoon in Privacy & Security > Accessibility

-- ControlEscape.spoon
hs.loadSpoon('ControlEscape'):start()

-- Miro's windows manager
local hyper = {"alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.2
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"},
  nextscreen = {hyper, "n"}
})
