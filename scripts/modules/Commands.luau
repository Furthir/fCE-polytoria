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
		local string = "[🤫 --> " .. towhisper.Name .. "] " .. utils.formatmsg(player, rest)
		Chat:UnicastMessage(string, player)
		if not towhisper.Chat.Blocked:FindChild(player.Name:lower()) then
			Chat:UnicastMessage(string, findPlayer(target))
		end
	end
end

if cfg.Toggles.TextColors then
	cmds["me"] = function(player: Player, msg: string, rest: string)
		msg = msg .. " " .. rest -- incredible scripting skilz
		local playerchatcolor = utils.ChatColorFromUserID(player.UserID)
	 	if player.Name == "Remi0" then -- pink color for remy lol, feel free to remove
			playerchatcolor = "#fc53ff"
		end
		
		local color = "[color=" .. playerchatcolor .. "]"
		local string = color .. player.Name .. ": " .. msg -- make color affect entire line
		if cfg.Toggles.Proximity then
			utils.handleProx(player, msg, string)
		else
			for _, target in ipairs(Players:GetPlayers()) do
				-- only send to players who have not muted sender, and who are not blocked
				if not target.Chat.Muted:FindChild(p.Name:lower()) and not p.Chat.Blocked:FindChild(target.Name:lower()) then
					Chat:UnicastMessage(string, target)
					utils.bubble(p, msg, target)
				end
			end
		end
	end
end

return cmds