local ui: UIView = PlayerGUI.ChatGUI.Intro
local button: UIButton = script.Parent

button.Clicked:Connect(function()
	local tw: TweenObject = Tween:NewTween()
	if ui.Visible then
		tw:SetDirection(Enums.TweenDirection.In)
		tw:SetTrans(Enums.TweenTransition.Back)
		tw:TweenVector2(ui.PositionRelative, Vector2.New(0.5, 2), .45, function(val)
			ui.PositionRelative = val
		end)
		tw.Finished:Wait()
		ui.Visible = false
	else
		ui.Visible = true
		tw:SetDirection(Enums.TweenDirection.Out)
		tw:SetTrans(Enums.TweenTransition.Quart)
		tw:TweenVector2(ui.PositionRelative, Vector2.New(0.5, 0.5), .45, function(val)
			ui.PositionRelative = val
		end)
	end
end)