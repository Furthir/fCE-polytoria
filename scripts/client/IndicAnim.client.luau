local indic: Text3D = script.Parent

local colorstep1 = Color.New(0.95, 0.95, 0.95)
local colorstep2 = Color.New(0.7, 0.7, 0.7)

while true do
	if indic.IsDescendantOfClass("Player") then
		local tw1 = Tween:NewTween()
		tw1:SetTrans(Enums.TweenTransition.Quad)
		tw1:SetDirection(Enums.TweenDirection.InOut)
		tw1:TweenColor(colorstep1, colorstep2, 1, function(val)
			indic.Color = val
		end)
		tw1.Finished:Wait()
		
		local tw2 = Tween:NewTween()
		tw2:SetTrans(Enums.TweenTransition.Quad)
		tw2:SetDirection(Enums.TweenDirection.InOut)
		tw2:TweenColor(indic.Color, colorstep1, 1, function(val)
			indic.Color = val
		end)
		tw2.Finished:Wait()
	else
		wait(0.2)
	end
end