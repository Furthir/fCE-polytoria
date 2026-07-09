local cfg = require(ScriptService.Chat:WaitChild("Config"))
local cmds = require(ScriptService.Chat:WaitChild("Commands"))
local utils = require(ScriptService.Chat:WaitChild("Utils"))
local log = require(ScriptService.Chat:WaitChild("ChatHistory"))

local RANGE = cfg.Values.ProxRange -- range of proximity chat
local PREFIX = cfg.Values.cmdPrefix -- command prefix

local toggleev: NetworkEvent = ScriptService.Chat.Events:WaitChild("ToggleProx")
local chatev: BindableEvent = ScriptService.Chat.Events:WaitChild("Chatted")
local histev: NetworkEvent = ScriptService.Chat.Events:WaitChild("LoadHistory")

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
	if not cfg.Toggles.Proximity then
		local fmtmsg = utils.formatmsg(p, msg)
		if cfg.Toggles.ChatHistory then log.Add(fmtmsg) end
		return true
	end
	
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
	if cfg.Toggles.ChatHistory then
		local hist = log.Get()
		wait(3)
		for _, m in pairs(hist) do
			local msg = NetMessage.New()
			msg.AddString("msg", m)
			histev:InvokeClient(msg, p)
			wait(0.05)
		end
		local msg = NetMessage.New()
		msg.AddString("msg", "[center]----- New messages start below -----	 [/center]")
		histev:InvokeClient(msg, p)
	end
end)

toggleev.InvokedServer:Connect(function(sender, msg) -- toggle prox
	sender.Chat.ProxEnabled.Value = msg.GetBool("ProxEnabled")
end)