local indicev: NetworkEvent = ScriptService.Chat.Events:WaitChild("TypingIndic")
local chatev: BindableEvent = ScriptService.Chat.Events:WaitChild("Chatted")
local cfg = require(ScriptService.Chat:WaitChild("Config"))

local indic: Text3D = ServerHidden:WaitChild("TypingIndic")

local TIMEOUT = cfg.Values.IndicTimeout
local timers = {}

-- stops typing indicator
local function stop(p)
	if not p then return end
	timers[p] = nil
	if p and p.Chat.TypingIndic then p.Chat.TypingIndic:Destroy() end
	-- sometimes doesn't replicate to the client for whatever reason.. polytoria
	local msg = NetMessage.New()
	msg.AddInstance("Player", p)
	indicev:InvokeClients(msg)
end

-- triggers typing indicator went received from clients
indicev.InvokedServer:Connect(function(sender, msg)
	if not cfg.Toggles.TypingIndicators then return end
	if not sender then return end
	if not msg.GetBool("Trigger") then -- stop signal
		stop(sender)
		return
	end
	local cloned: Text3D = nil
	if not timers[sender] then
		if not sender.Chat:FindChild("TypingIndic") then
			cloned = indic:Clone(sender.Chat)
		end
		cloned = sender.Chat.TypingIndic
		cloned.Position = sender.Position + Vector3.New(0, 5, 0)
		timers[sender] = 0
	else
		timers[sender] = 0
		return
	end
	
	spawn(function()
		while wait(1) do
			if not sender then
				timers[sender] = nil
				return
			end
			if not timers[sender] then 
				cloned:Destroy()
				return
			end
			timers[sender] += 1
			if timers[sender] and timers[sender] > TIMEOUT then
				cloned:Destroy()
				timers[sender] = nil
				return
			end
		end
	end)
end)

chatev.Invoked:Connect(function(p, msg) -- chatted event, since we're not using real messages
	stop(p)
end)

Chat.NewChatMessage:Connect(function(p, msg)
	stop(p)
end)

Players.PlayerRemoved:Connect(function(p)
	timers[p] = nil
end)