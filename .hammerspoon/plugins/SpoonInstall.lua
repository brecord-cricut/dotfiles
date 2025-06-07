local spoons = {
	"ClipboardTool",
	"HSKeybindings",
	"ReloadConfiguration",
	"WindowHalfsAndThirds",
}

hs.loadSpoon("SpoonInstall")

for _, spoonName in ipairs(spoons) do
	local cfgPath = "Spoons/" .. spoonName
	if io.open(cfgPath .. ".lua", "r") == nil then
		local filepath = cfgPath .. ".lua"
		local file = io.open(filepath, "w")
		if not file then
			error("Could not open file for writing: " .. filepath)
		end
		io.output(file)
		io.write([[
return {
  disabled = false,
}]])
		io.close(file)
	end
	spoon.SpoonInstall:andUse(spoonName, require(cfgPath))
end
