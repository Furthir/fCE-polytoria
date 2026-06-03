local part: Part = script.Parent

part.Touched:Connect(function(player)
	if not player:IsA("Player") then return end
	local badgeID = 202992
	local checkok, checkres = pcall(function()
		return Achievements:HasAchievementAsync(player.UserID, badgeID)
	end)
	if not checkok then
		print("Something went wrong while checking for badge")
		return
	end
	if checkok and checkres then return end
	if checkok and not checkres then
		local awardok, awardres = pcall(function()
			return Achievements:AwardAsync(player.UserID, badgeID)
		end)
		if not awardok then
			print("Something went wrong while awarding badge")
		end
	end
end)