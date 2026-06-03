local Config = {}

Config.Toggles = {
	Bubbles = true, -- custom chat bubbles
	Proximity = true, -- will disable custom bubbles if false
	TypingIndicators = true, -- show typing indicators
	Muting = true, -- allow players to mute other players (client-side)
	Blocking = true, -- allow players to block other players
	Whispering = true, -- allow players to whisper to other players
}

Config.Values = {
	IndicTimeout = 3, -- idle seconds before typing indicator hides
	ProxRange = 40, -- studs
	cmdPrefix = "!", -- prefix for chat commands
}

return Config