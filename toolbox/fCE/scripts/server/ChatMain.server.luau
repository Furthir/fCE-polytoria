local cfg = require(ScriptService.Chat:WaitChild("Config"))
local cmds = require(ScriptService.Chat:WaitChild("Commands"))
local utils = require(ScriptService.Chat:WaitChild("Utils"))

local RANGE = cfg.Values.ProxRange -- range of proximity chat
local PREFIX = cfg.Values.cmdPrefix -- command prefix

local toggleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("ToggleProx")
local chatev: BindableEvent = ScriptService.Chat.Events:WaitChild("Chatted")

local colors = utils.Colors

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
	
	-- set username chat color
	local stringfmt = utils.formatmsg(p, msg)
	chatev:Invoke(p, msg) -- invoke our own event since these aren't real msgs anymore
	utils.handleProx(p, msg, stringfmt)
	return false
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