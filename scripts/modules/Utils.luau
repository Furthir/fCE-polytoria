local Utils = {}

local bubbleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("Bubble")
local cfg = require(ScriptService.Chat:WaitChild("Config"))

local RANGE = cfg.Values.ProxRange

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L306
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

-- yoinked from https://github.com/Polytoria/polytoria-game/blob/main/Polytoria/scripts/datamodel/Player.cs#L334
function Utils.ChatColorFromUserID(userID): string
	return Utils.Colors[userID % #Utils.Colors]
end

function Utils.formatmsg(player, msg): string -- formats msg to add chat color
	local playerchatcolor = Utils.ChatColorFromUserID(player.UserID)
	if player.Name == "Remi0" then -- pink color for remy lol, feel free to remove
		playerchatcolor = "#fc53ff"
	end

	local color = "[color=" .. playerchatcolor .. "]"
	local string = color .. player.Name .. "[/color]" .. ": " .. msg
	return string
end


function Utils.handleProx(p: Player, msg: string, string: string)
	local pos = p.Position
	if p.Chat.ProxEnabled.Value then -- if player has prox chat enabled
		string = "[👥] " .. string
		Chat:UnicastMessage(string, p)
		for _, target in ipairs(Players:GetPlayers()) do
			if not target:IsA("Player") then continue end
			-- check if in range and not muted and hasn't been blocked
			if (target.Position - pos).Magnitude <= RANGE and not target.Chat.Muted:FindChild(p.Name:lower()) and not p.Chat.Blocked:FindChild(target.Name:lower()) then
				if target ~= p then -- if target is not our own player
					Chat:UnicastMessage(string, target) -- only send to those nearby and not muted
				end
				Utils.bubble(p, msg, target)
			end
		end
	else
		string = "[🌍] " .. string
		for _, target in ipairs(Players:GetPlayers()) do
			if not target:IsA("Player") then continue end
			-- only send to players who have not muted sender, and who are not blocked
			if not target.Chat.Muted:FindChild(p.Name:lower()) and not p.Chat.Blocked:FindChild(target.Name:lower()) then
				Chat:UnicastMessage(string, target)
				Utils.bubble(p, msg, target)
			end
		end
	end
end

return Utils