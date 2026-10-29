local cfg = require(ScriptService.Chat:WaitChild("Config"))
local container = script.Parent

if cfg.Toggles.ShowHelp then
	container.HelpButton.Visible = true
end

if cfg.Toggles.ShowIntro then
	PlayerGUI.ChatGUI.Intro.Visible = true
end

if cfg.Features.Proximity then
	container.RangeButton.Visible = true
	container.ProxButton.Visible = true
end

if cfg.Features.Pings then
	container.DNDButton.Visible = true
end