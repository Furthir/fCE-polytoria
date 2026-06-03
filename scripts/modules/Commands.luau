local cfg = require(ScriptService.Chat:WaitChild("Config"))

local cmds = {}

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L306
local colors = {
	"#4e9aa8", "#00a86b", "#4b3f69", "#d8ad39", "#d6c69a",
	"#26A69A", "#7CB342", "#5C6BC0", "#FB7EFD", "#54A0FF",
	"#5F27CD", "#01A3A4", "#F368E0", "#FF9F43", "#1DD1A1",
	"#48DBFB", "#AB47BC", "#42A5F5", "#66BB6A", "#FFA726",
	"#8D6E63", "#78909C", "#D4E157", "#B39DDB",
}

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L334
local function ChatColorFromUserID(userID)
	return colors[userID % #colors]
end


local function findPlayer(name) -- helper function since findchild is case sens
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name:lower() == name then
			return player
		end
	end
	return nil
end

local function ChatColorFromUserID(userID)
	return colors[userID % #colors]
end

local function formatmsg(player, msg) -- formats msg to add chat color
	local playerchatcolor = ChatColorFromUserID(player.UserID)
	if player.Name == "Remi0" then -- pink color for remy lol, feel free to remove
		playerchatcolor = "#fc53ff"
	end

	local color = "[color=" .. playerchatcolor .. "]"
	local string = color .. player.Name .. "[/color]" .. ": " .. msg
	return string
end

if cfg.Toggles.Muting then
	cmds["mute"] = function(sender: Player, targetname: string, rest: string) -- target = to mute
		if not sender then return end
		local tomute = findPlayer(targetname)
		if not tomute then 
			Chat:UnicastMessage("Player not found.", sender)
			return
		end
		if tomute == sender then 
			Chat:UnicastMessage("you can't mute yourself bro", sender)
			return
		end
		local folder = sender.Chat.Muted
		local mutedPlayer: InstanceValue = Instance.New("InstanceValue", folder)
		mutedPlayer.Name = targetname
		Chat:UnicastMessage("Muted " .. tomute.Name, player)
	end

	cmds["unmute"] = function(player: Player, target: string, rest: string)
		if not player then return end
		if player.Chat.Muted:FindChild(target) then
			player.Chat.Muted:FindChild(target):Destroy()
			Chat:UnicastMessage("Unmuted " .. target, player)
		end
	end
end

if cfg.Toggles.Blocking then
	cmds["block"] = function(sender: Player, targetname: string, rest: string) -- target = to block
		if not sender then return end
		local toblock: Player = findPlayer(targetname)
		if not toblock then 
			Chat:UnicastMessage("Player not found.", sender)
			return
		end
		if toblock == sender then 
			Chat:UnicastMessage("you can't block yourself bro", sender)
			return
		end
		local folder = sender.Chat.Blocked
		local blockedPlayer: InstanceValue = Instance.New("InstanceValue", folder)
		blockedPlayer.Name = targetname
		Chat:UnicastMessage("Blocked .. " .. toblock.Name, sender)
	end

	cmds["unblock"] = function(player: Player, target: string, rest: string)
		if not player then return end
		if player.Chat.Blocked:FindChild(target) then
			player.Chat.Blocked:FindChild(target):Destroy()
			Chat:UnicastMessage("Unblocked " .. target, player)
		end
	end
end

if cfg.Toggles.Whispering then
	cmds["whisper"] = function(player: Player, target: string, rest: string)
		local towhisper: Player = findPlayer(target)
		if not towhisper then
			Chat:UnicastMessage("Player not found.", player)
			return
		end
		local string = "[🤫 --> " .. towhisper.Name .. "] " .. formatmsg(player, rest)
		Chat:UnicastMessage(string, player)
		if not towhisper.Chat.Blocked:FindChild(player.Name:lower()) then
			Chat:UnicastMessage(string, findPlayer(target))
		end
	end
end

return cmds