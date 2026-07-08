-- deprecated, no longer used in favor of new voiceboxes (2.0.16)

-- create a chat bubble, since using broadcast/unicast is not a real player message anymore
local ev: NetworkEvent = ScriptService.Chat.Events:WaitChild("Bubble")

local WRAP_AT_CHAR = 22 -- amount of characters in a line before needing to wrap, based on bubble width

local chatBubble: Image3D = Hidden:WaitChild("Bubble3D")

local ids = {}
local msgID = 0

local emojis = {
    "biglike", "cat", "catsmirk", "cobras", "cryjoy", "dead",
    "derp", "durr", "flushed", "horrified", "like", "love", 
	"nerd", "nervous", "neutral", "nomouth", "phantoms", "plead",
    "polytoria", "question", "sad", "salute", "scream", "shock",
    "smile", "sob", "sunglasses", "sweat", "troll", "yay", "yum",
}

local function formatemojis(msg) -- formats chat bubble msg to add emojis
	local regex = ":([^:%s]+):" -- match emoji
	local pathbase = "res://assets/textures/client/emojis/"
	return msg:gsub(regex, function(name) -- match all present emojis if any
		if emojis[table.find(emojis, name)] then -- if emoji exists
			local path = pathbase .. name .. ".png"
			return string.format("[img=64x64 color=white]%s[/img]", path) -- return emoji image
		end
		return ":" .. name .. ":" -- return :name: if emoji doesn't exist
	end)
end

-- wraps text over WRAP_AT_CHAR (22 here) characters
local function wraptext(text: string)
	local parts = {}
	local line = ""
	for word in text:gmatch("%S+") do -- match each word
		if #line == 0 then -- if first word of line
			if #word <= WRAP_AT_CHAR then -- check if word is shorter than WRAP_AT_CHAR
				line = word
			else
				for i = 1, #word, WRAP_AT_CHAR do -- if it is longer then just cut it off
					table.insert(parts, word:sub(i, i+(WRAP_AT_CHAR-1)))
				end
				line = ""
			end
		else
			if #line + 1 + #word <= WRAP_AT_CHAR then
				line = line .. " " .. word
			else
				table.insert(parts, line)
				if #word <= WRAP_AT_CHAR then
					line = word
				else
					for i = 1, #word, WRAP_AT_CHAR do
						table.insert(parts, word:sub(i, i+(WRAP_AT_CHAR-1)))
					end
					line = ""
				end
			end
		end
	end
	if #line > 0 then
		table.insert(parts, line) 
	end
	return table.concat(parts, "[br]"), #parts -- adds a break after each line
end

ev.InvokedClient:Connect(function(msg)
	local player = msg.GetInstance("Player")
	local text = msg.GetString("msg")
	if not player then return end
	lines = 0
	
	-- set a unique message id
	msgID += 1
	local id = msgID
	ids[player] = id
	
	local chatText: Text3D = player.Chat:WaitChild("ChatText")
	local bubble = chatBubble:Clone(chatText)
	
	bubble.Position = player.Position + Vector3.New(0, 6, 0)
	bubble.Size = Vector3.New(6, 1, 2)
	if text:len() > WRAP_AT_CHAR then
		local t, lines = wraptext(text)
		text = t
		for i = 1, lines do -- make bubble bigger based on lines
			bubble.Size += Vector3.New(0, .5, 0)
		end
	end
	text = formatemojis(text)
	
	-- color workaround for emoijs, they appear black if text.Color is black,
	-- so instead just override the text manually as black
	chatText.Text = "[center][color=black]" .. text .. "[/color]"
	chatText.Color = Color.New(1, 1, 1, 1)
	
	-- hide bubble if not chatted for 5 seconds
	-- i swear whenever i try to do timers it's always a mess
	spawn(function()
		local elapsed = 0
		while wait(1) do
			if not player then
				ids[player] = nil
				return
			end
			elapsed += 1
			if ids[player] ~= id then
				bubble:Destroy()
				return
			end
			if elapsed >= 5 then
				bubble:Destroy()
				ids[player] = nil
				chatText.Color = Color.New(1, 1, 1, 0)
				elapsed = 0
				return
			end
		end
	end)
end)