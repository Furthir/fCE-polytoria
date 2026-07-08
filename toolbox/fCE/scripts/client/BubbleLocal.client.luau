local ev: NetworkEvent = ScriptService.Chat.Events:WaitChild("Bubble")

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

ev.InvokedClient:Connect(function(msg)
	local player = msg.GetInstance("Player")
	local text = msg.GetString("msg")
	if not player then return end
	
	local bubble: VoiceBox = player.Chat.ChatBubble
	text = formatemojis(text)
	bubble:Speak(text)
end)