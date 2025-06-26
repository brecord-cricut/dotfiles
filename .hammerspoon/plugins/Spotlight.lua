-- Setting spotlight to `⌘+Delete` isn't available in the OS: So we set it here:
hs.hotkey.bind({ "cmd" }, "delete", function()
	hs.eventtap.keyStroke({ "cmd" }, "space")
end)
