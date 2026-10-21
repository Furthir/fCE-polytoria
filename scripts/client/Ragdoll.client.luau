local player: Player = Players.LocalPlayer
local rag = false

Input.KeyDown:Connect(function(key)
	if Input.IsInputFocused then return end
	if key == Enums.KeyCode.R then
		rag = not rag
		local ragdollpos
		if player.Character.Ragdolling then
			ragdollpos = player.Character.RagdollPosition
		end
		if rag then
			player.Character:StartRagdoll(player.Velocity*20)
			player.CanMove = false
		else
			player.Position = ragdollpos
			player.Character:StopRagdoll()
			player.CanMove = true
		end
	end
end)

player.Died:Connect(function()
	player.CanMove = true
end)