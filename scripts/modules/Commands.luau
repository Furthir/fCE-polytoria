local cfg = require(ScriptService.Chat:WaitChild("Config"))
local utils = require(ScriptService.Chat:WaitChild("Utils"))

local cmds = {}

local colors = utils.Colors

local function findPlayer(name) -- helper function since findchild is case sens
	for _, player in pairs(Players:GetPlayers()) do
		if player.Name:lower() == name then
			return player
		end
	end
	return nil
end

if cfg.Features.Muting then
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
		if not folder:FindChild(targetname) then
			local mutedPlayer: InstanceValue = Instance.New("InstanceValue")
			mutedPlayer.Name = targetname
			mutedPlayer.Parent = folder
			Chat:UnicastMessage("Muted " .. tomute.Name, sender)
		else
			Chat:UnicastMessage("You've already muted " .. tomute.Name, sender)
		end
	end

	cmds["unmute"] = function(player: Player, target: string, rest: string)
		if not player then return end
		if player.Chat.Muted:FindChild(target) then
			player.Chat.Muted:FindChild(target):Destroy()
			Chat:UnicastMessage("Unmuted " .. target, player)
		else
			Chat:UnicastMessage("They're not muted.", player)
		end
	end
end

if cfg.Features.Blocking then
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
		if not folder:FindChild(targetname) then
			local blockedPlayer: InstanceValue = Instance.New("InstanceValue")
			blockedPlayer.Name = targetname
			blockedPlayer.Parent = folder
			Chat:UnicastMessage("Blocked " .. toblock.Name, sender)
		else
			Chat:UnicastMessage("You've already blocked " .. toblock.Name, sender)
		end
	end

	cmds["unblock"] = function(player: Player, target: string, rest: string)
		if not player then return end
		if player.Chat.Blocked:FindChild(target) then
			player.Chat.Blocked:FindChild(target):Destroy()
			Chat:UnicastMessage("Unblocked " .. target, player)
		else
			Chat:UnicastMessage("They're not blocked.", player)
		end
	end
end

if cfg.Features.Whispering then
	cmds["whisper"] = function(player: Player, target: string, rest: string)
		local towhisper: Player = findPlayer(target)
		if not towhisper then
			Chat:UnicastMessage("Player not found.", player)
			return
		end
		local string = "[🤫 --> " .. towhisper.Name .. "] " .. utils.formatmsg(player, rest)
		Chat:UnicastMessage(string, player)
		if not towhisper.Chat.Blocked:FindChild(player.Name:lower()) then
			Chat:UnicastMessage(string, findPlayer(target))
		end
	end
	
	cmds["w"] = cmds["whisper"]
end

if cfg.Features.TextColors then
	cmds["me"] = function(player: Player, msg: string, rest: string)
		msg = msg .. " " .. rest -- incredible scripting skilz
		local playerchatcolor = utils.ChatColorFromUserID(player.UserID)
	 	if player.UserID == 108584 then -- pink color for remy lol, feel free to remove
			playerchatcolor = "#fc53ff"
		end
		
		local color = "[color=" .. playerchatcolor .. "]"
		local string = color .. player.Name .. ": " .. msg -- make color affect entire line
		if cfg.Features.Proximity then
			utils.handleProx(player, msg, string)
		else
			utils.SendToAll(player, msg, string)
		end
	end
end

return cmds