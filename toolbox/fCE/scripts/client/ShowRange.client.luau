local button: UILabel = script.Parent
local rangepart: Part = Hidden:WaitChild("Range")
local cfg = require(ScriptService.Chat:WaitChild("Config"))
local player = Players.LocalPlayer

local toggled = false
local range = cfg.Values.ProxRange
local cloned

button.Clicked:Connect(function()
	rangepart.Size = Vector3.New(range, range, range) * 2
	toggled = not toggled
	
	if toggled then
		cloned = rangepart:Clone(player.Chat)
		cloned.Position = player.Position
		Chat:UnicastMessage(string.format("Proximity range shown (%s studs)", range), player)
	else
		cloned:Destroy()
		Chat:UnicastMessage("Proximity range hidden", player)
	end
end)