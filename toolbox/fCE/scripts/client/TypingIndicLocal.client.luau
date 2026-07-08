local indic: NetworkEvent = ScriptService.Chat.Events:WaitChild("TypingIndic")
local cfg = require(ScriptService.Chat:WaitChild("Config"))

local held = false

-- blacklist keys from being detected for typing indicator
local blacklist = {
	Enums.KeyCode.MouseLeft,
	Enums.KeyCode.MouseRight,
	Enums.KeyCode.Meta,
	Enums.KeyCode.Alt,
	Enums.KeyCode.Ctrl,
	Enums.KeyCode.Shift,
	Enums.KeyCode.MouseWheelDown,
	Enums.KeyCode.MouseWheelUp,
	Enums.KeyCode.MouseWheelLeft,
	Enums.KeyCode.MouseWheelRight,
	Enums.KeyCode.Backspace,
	Enums.KeyCode.Enter
}

local function isBlacklisted(key)
	for _, blkey in pairs(blacklist) do
		if key == blkey then return true end
	end
	return false
end

if cfg.Toggles.TypingIndicators then
	Input.KeyDown:Connect(function(key)
		if key == Enums.KeyCode.Backspace then
			local msg = NetMessage.New()
			msg.AddBool("Trigger", false)
			indic:InvokeServer(msg)
		end
		if Input.IsInputFocused and not isBlacklisted(key) and not Input.IsMenuOpened then
			held = true
			while held and Input.IsWindowFocused do
				local msg = NetMessage.New()
				msg.AddBool("Trigger", true)
				indic:InvokeServer(msg)
				wait(0.35)
			end
		end
	end)

	Input.KeyUp:Connect(function(key)
		if not isBlacklisted(key) then
			held = false
		end
	end)
end

-- destroy on client too if it's stuck there
indic.InvokedClient:Connect(function(msg)
	local p = msg.GetInstance("Player")
	if p and p.Chat.TypingIndic then p.Chat.TypingIndic:Destroy() end
end)