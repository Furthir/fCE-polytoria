local player: Player = Players.LocalPlayer
local dnd = player.Chat.DND
local button: UIButton = script.Parent

button.Clicked:Connect(function()
	dnd.Value = not dnd.Value
	if dnd.Value then
		button.Bell.Color = Color.Red
		button.Strike.Visible = true
	else
		button.Bell.Color = Color.Green
		button.Strike.Visible = false
	end
end)