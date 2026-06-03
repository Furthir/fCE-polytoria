local cfg = require(ScriptService.Chat:WaitChild("Config"))
local text: UILabel = script.Parent

local features = cfg.Toggles
local prefix = cfg.Values.cmdPrefix

local descriptions = {
	Blocking = string.format(": %sblock|unblock [playername]", prefix),
	Muting = string.format(": %smute|unmute [playername]", prefix),
	Whispering = string.format(": %swhisper [playername] [msg]", prefix),
	Proximity = string.format(": %s studs", cfg.Values.ProxRange),
}

for i, f in pairs(features) do
	if f then
		local desc = ""
		if descriptions[i] then
			desc = descriptions[i]
		end
		text.Text = text.Text .. "\n- " .. i .. desc
	end
end