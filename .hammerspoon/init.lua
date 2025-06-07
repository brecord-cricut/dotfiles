local log = hs.logger.new("Config", "info")

log.i("Loading internal config...")

for file in io.popen('ls "' .. hs.configdir .. "/plugins" .. '"'):lines() do
	if file:sub(-4) == ".lua" then
		local moduleName = file:sub(1, -5)
		log.i("Sourcing " .. moduleName .. "...")
		require("plugins." .. moduleName)
	end
end
