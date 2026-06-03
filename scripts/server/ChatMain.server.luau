local cfg = require(ScriptService.Chat:WaitChild("Config"))
local cmds = require(ScriptService.Chat:WaitChild("Commands"))

local RANGE = cfg.Values.ProxRange -- range of proximity chat
local PREFIX = cfg.Values.cmdPrefix -- command prefix

local toggleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("ToggleProx")
local chatev: BindableEvent = ScriptService.Chat.Events:WaitChild("Chatted")
local bubbleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("Bubble")

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

local function formatmsg(player, msg) -- formats msg to add chat color
	local playerchatcolor = ChatColorFromUserID(player.UserID)
	if player.Name == "Remi0" then -- pink color for remy lol, feel free to remove
		playerchatcolor = "#fc53ff"
	end

	local color = "[color=" .. playerchatcolor .. "]"
	local string = color .. player.Name .. "[/color]" .. ": " .. msg
	return string
end

local function bubble(player: Player, text: string, client: Player) -- creates chat bubble
	if cfg.Toggles.Bubbles then
		local msg = NetMessage.New()
		msg.AddInstance("Player", player)
		msg.AddString("msg", text)
		bubbleev:InvokeClient(msg, client)
	end
end

local function handlecmd(p: Player, msg: string)
	local split
	if string.find(msg, " ") then
		split = string.split(msg, " ")
	else return end
	
	local cmd = split[1]:lower()
	local arg = split[2]:lower()
	local argrest = table.concat(split, " ", 3)
	
	if cmds[cmd] then
		cmds[cmd](p, arg, argrest) -- everything here is in ScriptService.Chat.Commands
		return
	end
end

-- main chat handler
Chat.ChatPredicate = function(p: Player, msg: string)
	if msg:find("^" .. PREFIX) ~= nil then -- if msg starts with PREFIX
		if #msg >= 2 then
			handlecmd(p, msg:sub(1+#PREFIX)) -- skips the PREFIX
			return false
		end
	end
	if not cfg.Toggles.Proximity then return true end
	local pos = p.Position
	
	-- set username chat color
	local string = formatmsg(p, msg)
	
	chatev:Invoke(p, msg) -- invoke our own event since these aren't real msgs anymore
	if p.Chat.ProxEnabled.Value then -- if player has prox chat enabled
		string = "[👥] " .. string
		Chat:UnicastMessage(string, p)
		for _, target in ipairs(Players:GetPlayers()) do
			-- check if in range and not muted and hasn't been blocked
			if (target.Position - pos).Magnitude <= RANGE and not target.Chat.Muted:FindChild(p.Name:lower()) and not p.Chat.Blocked:FindChild(target.Name:lower()) then
				if target ~= p then -- if target is not our own player
					Chat:UnicastMessage(string, target) -- only send to those nearby and not muted
				end
				bubble(p, msg, target)
			end
		end
	    return false
	else
		string = "[🌍] " .. string
		for _, target in ipairs(Players:GetPlayers()) do
			-- only send to players who have not muted sender, and who are not blocked
			if not target.Chat.Muted:FindChild(p.Name:lower()) and not p.Chat.Blocked:FindChild(target.Name:lower()) then
				Chat:UnicastMessage(string, target)
				bubble(p, msg, target)
			end
		end
		return false
	end
--	returning false prevents the regular message from sending
end

Players.PlayerRemoved:Connect(function(p)
	print("Player left: " .. p.Name)
end)

Players.PlayerAdded:Connect(function(p)
	print("Player joined: " .. p.Name)
end)

toggleev.InvokedServer:Connect(function(sender, msg) -- toggle prox
	sender.Chat.ProxEnabled.Value = msg.GetBool("ProxEnabled")
end)