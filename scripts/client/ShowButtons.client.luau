local cfg = require(ScriptService.Chat:WaitChild("Config"))
local container = script.Parent

if cfg.Toggles.Proximity then
	container.RangeButton.Visible = true
	container.ProxButton.Visible = true
end