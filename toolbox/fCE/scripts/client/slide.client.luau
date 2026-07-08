local ui: UIView = script.Parent
local lbhidden = false
local posopen = ui.PositionOffset
local posclose = Vector2.New(-16, ui.PositionOffset.Y)

Input.KeyDown:Connect(function (key)
	if Input.IsInputFocused or Input.IsMenuOpened then return end
	if key == Enums.KeyCode.Tab then
		local tw = Tween:NewTween()
		tw:SetDirection(Enums.TweenDirection.Out)
		tw:SetTrans(Enums.TweenTransition.Cubic)
		if not lbhidden then
			lbhidden = true
			tw:TweenVector2(ui.PositionOffset, posclose, .3, function (val)
				ui.PositionOffset = val
			end)
		else
			lbhidden = false
			tw:TweenVector2(ui.PositionOffset, posopen, .25, function (val)
				ui.PositionOffset = val
			end)
		end
		tw:Play()
	end
end)