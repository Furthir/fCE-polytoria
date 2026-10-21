local Utils = {}

local bubbleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("Bubble")
local cfg = require(ScriptService.Chat:WaitChild("Config"))
local log = require(ScriptService.Chat:WaitChild("ChatHistory"))

local RANGE = cfg.Values.ProxRange

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L330
Utils.Colors = {
	"#4e9aa8", "#00a86b", "#4b3f69", "#d8ad39", "#d6c69a",
	"#26A69A", "#7CB342", "#5C6BC0", "#FB7EFD", "#54A0FF",
	"#5F27CD", "#01A3A4", "#F368E0", "#FF9F43", "#1DD1A1",
	"#48DBFB", "#AB47BC", "#42A5F5", "#66BB6A", "#FFA726",
	"#8D6E63", "#78909C", "#D4E157", "#B39DDB",
}

function Utils.bubble(player: Player, text: string, client: Player) -- creates chat bubble
	if cfg.Toggles.Bubbles then
		local msg = NetMessage.New()
		msg.AddInstance("Player", player)
		msg.AddString("msg", text)
		bubbleev:InvokeClient(msg, client)
	end
end

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L358
function Utils.ChatColorFromUserID(userID): string
	return Utils.Colors[(userID % #Utils.Colors)+1]
end

function Utils.CheckIsMuted(target: Player, sender: Player): boolean
	if not target then return false end
	if not sender then return false end
	if target.Chat.Muted:FindChild(sender.Name:lower()) then return true end
	return false
end

function Utils.CheckIsBlocked(target: Player, sender: Player): boolean
	if not target then return false end
	if not sender then return false end
	if sender.Chat.Blocked:FindChild(target.Name:lower()) then return true end
	return false
end

function Utils.formatmsg(player: Player, msg: string): string -- formats msg to add chat color
	local playerchatcolor = Utils.ChatColorFromUserID(player.UserID)
	if player.Name == "Remi0" then -- pink color for remy lol, feel free to remove
		playerchatcolor = "#fc53ff"
	end
	local badgepath = "res://assets/textures/client/ui/playerlist/badges/"
	local badge = if player.IsCreator then badgepath .. "creator.png" else if player.IsAdmin then badgepath .. "admin.png" else ""
	local badgefmt = string.format("[img=16x16]%s[/img] ", badge)
	local color = "[color=" .. playerchatcolor .. "]"
	local string = badgefmt .. color .. player.Name .. "[/color]" .. ": " .. msg
	return string
end

function Utils.SendToAll(sender: Player, msg: string, fmtline: string)
	for _, target in ipairs(Players:GetPlayers()) do -- target = player to send to
		if not target:IsA("Player") then continue end
		-- only send to players who have not muted sender, and who are not blocked
		if not Utils.CheckIsMuted(target, sender) and not Utils.CheckIsBlocked(target, sender) then
			Chat:UnicastMessage(fmtline, target)
			Utils.bubble(sender, msg, target)
		end
	end
end

function Utils.handleProx(p: Player, msg: string, string: string)
	-- p = sender
	local pos = p.Position
	if p.Chat.ProxEnabled.Value then -- if player has prox chat enabled
		string = "[👥] " .. string
		Chat:UnicastMessage(string, p)
		for _, target in ipairs(Players:GetPlayers()) do -- target = player to send to
			if not target:IsA("Player") then continue end
			-- check if in range and not muted and hasn't been blocked
			if (target.Position - pos).Magnitude <= RANGE and not Utils.CheckIsMuted(target, p) and not Utils.CheckIsBlocked(target, p) then
				if target ~= p then -- if target is not our own player
					Chat:UnicastMessage(string, target) -- only send to those nearby and not muted
				end
				Utils.bubble(p, msg, target)
			end
		end
	else
		string = "[🌍] " .. string
		if cfg.Toggles.ChatHistory then log.Add(string) end
		Utils.SendToAll(p, msg, string)
	end
end

return Utils