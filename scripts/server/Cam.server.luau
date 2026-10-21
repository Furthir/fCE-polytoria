local campart: Part = script.Parent
local lens: Part = campart.Parent.CamPos

campart.Clicked:Connect(function()
	Capture:TakePhotoAtDynamic(lens, Vector2.New(2000, 1200))
end)