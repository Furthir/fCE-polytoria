local Config = {}

Config.Toggles = {
	Bubbles = true, -- use chat bubbles
	Proximity = true, -- enables proximity chat functionality
	TypingIndicators = true, -- show typing indicators
	Muting = true, -- allow players to mute other players (client-side)
	Blocking = true, -- allow players to block other players
	Whispering = true, -- allow players to whisper to other players
	Me = true, -- allows player to run !me to color their text to their username color
}

Config.Values = {
	IndicTimeout = 3, -- idle seconds before typing indicator hides
	ProxRange = 40, -- studs
	cmdPrefix = "!", -- prefix for chat commands
}

return Config