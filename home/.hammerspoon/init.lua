-- First, be sure to install hs-knu.
-- git clone https://github.com/knu/hs-knu.git ~/.hammerspoon/knu
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
