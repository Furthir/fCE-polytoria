local cfg = require(ScriptService.Chat:WaitChild("Config"))
local container = script.Parent

if cfg.ShowHelp then
	container.HelpButton.Visible = true
end

if cfg.ShowIntro then
	PlayerGUI.ChatGUI.Intro.Visible = true
end

if cfg.Toggles.Proximity then
	container.RangeButton.Visible = true
	container.ProxButton.Visible = true
end

if cfg.Toggles.Pings then
	container.DNDButton.Visible = true
end