--visit https://www.hammerspoon.org/go/


hs.hotkey.bind({"shift", "cmd"}, "s", function()
  hs.application.launchOrFocus("Safari")
end)

hs.hotkey.bind({"shift", "cmd"}, "i", function()
  hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"shift", "cmd"}, "c", function()
  hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"shift", "cmd"}, "e", function()
  hs.application.launchOrFocus("Evernote")
end)
