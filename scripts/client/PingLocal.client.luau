local player: Player = Players.LocalPlayer
local dnd: BoolValue = player.Chat.DND
local name: string = player.Name:lower()
local sound: Sound = Hidden.Ping
local chatev: NetworkEvent = ScriptService.Chat.Events.Bubble -- reusing bubble event since it gives standalone msg data (excluding username/fmt)
local indicator: UIView = PlayerGUI.ChatGUI.TopBar.Buttons.ChatIndicator
local shadow: ShadowLayer = indicator.Shadow.Layers[1]
local cfg = require(ScriptService.Chat.Config)
local curtw: TweenObject = nil

chatev.InvokedClient:Connect(function(netmsg)
	if not cfg.Features.Pings then return end
	local msg = netmsg:GetString("msg")
	if msg:lower():find(name) and not dnd.Value then
		sound:PlayOneShot()
		
		indicator.Color = Color.FromRGB(255, 75, 90, .9)
		shadow.Color = Color.FromRGB(255, 120, 200, .7)
		indicator.Scale = Vector2.One
		indicator.Visible = true
		if curtw then curtw:Cancel() end
		local t = Tween:NewTween()
		curtw = t
		t.Parallel = true
		t:SetTrans(Enums.TweenTransition.Cubic)
		t:SetDirection(Enums.TweenDirection.Out)
		t:TweenVector2(indicator.Scale, Vector2.New(1.3), .7, function(val)
			indicator.Scale = val
		end)
		t:TweenColor(indicator.Color, Color.FromRGB(255, 75, 90, 0), .7, function(val)
			indicator.Color = val
		end)
		t:TweenColor(shadow.Color, Color.FromRGB(255, 120, 200, 0), .7, function(val)
			shadow.Color = val
			-- i don't get it bro i guess i can't set the color of a shadow
		end)
		t.Finished:Wait()
		indicator.Visible = false
		curtw = nil
	end
end)