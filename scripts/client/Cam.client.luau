local campart: Part = script.Parent
local lens: Part = campart.Parent.CamPos

local function capture()
	Capture:TakePhotoAtDynamic(lens, Vector2.New(2000, 1200))
end

campart.Clicked:Connect(function(p) 
	capture()
end)
