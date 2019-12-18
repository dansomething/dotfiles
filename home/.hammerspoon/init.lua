-- First, be sure to install hs-knu.
-- git clone https://github.com/knu/hs-knu.git ~/.hammerspoon/knu
-- TODO Take a look at https://github.com/jasonrudolph/ControlEscape.spoon
-- it will replace the knu config
-- Then install miro-windows-manager
-- https://github.com/miromannino/miro-windows-manager

-- hs-knu modules
knu = require("knu")
-- Function to guard a given object from GC
guard = knu.runtime.guard

-- Enable auto-restart when any of the *.lua files under ~/.hammerspoon/ is modified
knu.runtime.autorestart(true)

-- Switch between Karabiner-Elements profiles by keyboard
function switchKarabinerElementsProfile(name)
  hs.execute(knu.utils.shelljoin(
      "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli",
      "--select-profile",
      name
  ))
  hs.execute("pkill karabiner_console_user_server")
end

knu.usb.onChange(function (device)
    local name = device.productName
    if name and name:find("Keyboard") then
      if device.eventType == "added" then
        hs.alert.show("Filco Keyboard Enabled")
        switchKarabinerElementsProfile("filco")
      else
        hs.alert.show("Default Keyboard Enabled")
        switchKarabinerElementsProfile("default")
      end
    end
end)

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
