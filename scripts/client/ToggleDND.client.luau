local player: Player = Players.LocalPlayer
local dnd = player.Chat.DND
local button: UIButton = script.Parent
local cfg = require(ScriptService.Chat.Config)

local function toggle(state)
	dnd.Value = state
	if dnd.Value then
		button.Bell.Color = Color.Red
		button.Strike.Visible = true
	else
		button.Bell.Color = Color.Green
		button.Strike.Visible = false
	end
end

toggle(cfg.Toggles.DefaultDNDState)

button.Clicked:Connect(function()
	toggle(not dnd.Value)
end)