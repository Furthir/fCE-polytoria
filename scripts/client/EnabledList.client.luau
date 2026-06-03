local cfg = require(ScriptService.Chat:WaitChild("Config"))
local text: UILabel = script.Parent

local features = cfg.Toggles

local descriptions = {
	Blocking = ": !block|unblock [playername]",
	Muting = ": !mute|unmute [playername]",
	Whispering = ": !whisper [playername] [msg]",
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