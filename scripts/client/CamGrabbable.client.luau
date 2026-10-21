local body: RigidBody = script.Parent
local campart: Part = script.Parent.CamPart
local lens: Part = campart.Parent.CamPos
local grab: Grabbable = body.Grabbable
local gizmos: RigidBody = body.Gizmo

local xcolor = Color.FromRGB(255, 0, 0)
local ycolor = Color.FromRGB(0, 255, 0)
local zcolor = Color.FromRGB(0, 0, 255)
local reverse = 1

local conn: PTSignalConnection = nil
local dragger: Player = nil

local cd1 = false
local cd2 = false

local function capture()
	Capture:TakePhotoAtDynamic(lens, Vector2.New(2000, 1200))
end

campart.Clicked:Connect(function(p) 
	capture()
end)

grab.Grabbed:Connect(function(p)
	if cd1 then return end
	cd1 = true
	dragger = p
	body:SetCollisionLayer(1, false)
	if p == Players.LocalPlayer then
		PlayerGUI.CamGUI.Visible = true
		gizmos.X.Color = xcolor
		gizmos.Y.Color = ycolor
		gizmos.Z.Color = zcolor
		conn = Input.KeyDown:Connect(function(key, focused)
			if Input.IsInputFocused then return end
			if not focused then return end
			if grab.Dragger == p then
				if key == Enums.KeyCode.E then
					capture()
				end
				if key == Enums.KeyCode.Z then
					body:Rotate(Vector3.New(10, 0, 0) * reverse)
				end
				if key == Enums.KeyCode.X then
					body:Rotate(Vector3.New(0, 10, 0) * reverse)
				end
				if key == Enums.KeyCode.C then
					body:Rotate(Vector3.New(0, 0, 10) * reverse)
				end
				if key == Enums.KeyCode.L then
					body.LockRotation = not body.LockRotation
				end
				if key == Enums.KeyCode.Q then
					reverse *= -1
				end
			end
		end)
	end
	wait(0.1)
	cd1 = false
end)

grab.Released:Connect(function()
	if cd2 then return end
	cd2 = true
	body:SetCollisionLayer(1, true)
	if dragger == Players.LocalPlayer then
		conn:Disconnect()
		
		PlayerGUI.CamGUI.Visible = false
		for _, c in pairs(gizmos:GetChildren()) do
			c.Color = Color.New(0, 0, 0, 0)
		end
	end
	wait(0.1)
	cd2 = false
end)