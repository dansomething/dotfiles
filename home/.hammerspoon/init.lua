-- Install these to ~/.hammerspoon/Spoons
-- Enable Hammerspoon in Privacy & Security > Accessibility
-- git clone https://github.com/jasonrudolph/ControlEscape.spoon
-- git clone https://github.com/miromannino/miro-windows-manager
-- ln -s ~/.hammerspoon/Spoons/miro-windows-manager/MiroWindowsManager.spoon ~/.hammerspoon/Spoons

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
