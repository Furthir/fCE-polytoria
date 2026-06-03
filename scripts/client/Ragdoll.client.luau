local player = Players.LocalPlayer

local rag = false

Input.KeyDown:Connect(function(key)
	if Input.IsInputFocused then return end
	if key == Enums.KeyCode.R then
		rag = not rag
		if rag then
			player.CanMove = false
			player.Character:StartRagdoll()
		else
			player.Character:StopRagdoll()
			player.CanMove = true
		end
	end
	
	player.Died:Connect(function()
		player.CanMove = true
	end)
end)
