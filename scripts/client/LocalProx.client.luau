local button: UIButton = script.Parent
local toggleev = ScriptService.Chat.Events:WaitChild("ToggleProx")
local cfg = require(ScriptService.Chat.Config)

local toggle = false

local function toggleProx(state)
	toggle = state
	local msg = NetMessage.New()
	msg.AddBool("ProxEnabled", toggle)
	toggleev:InvokeServer(msg)
	if toggle then
		button.Text = "Prox Enabled"
		button.TextColor = Color.New(.1, 1, .1)
	else
		button.Text = "Prox Disabled"
		button.TextColor = Color.New(1, 0.15, 0.15)
	end
end

toggleProx(cfg.Toggles.DefaultProxState)

button.Clicked:Connect(function()
	toggleProx(not toggle)
end)