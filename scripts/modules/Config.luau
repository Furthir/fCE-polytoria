local Config = {}

Config.Toggles = {
	Bubbles = true, -- use chat bubbles
	Proximity = true, -- enables proximity chat functionality
	TypingIndicators = true, -- show typing indicators
	Muting = true, -- allow players to mute other players (client-side)
	Blocking = true, -- allow players to block other players
	Whispering = true, -- allow players to whisper to other players
	TextColors = true, -- allows player to run !me to color their text to their username color
	ChatHistory = true -- allows player to see chat history from before they joined
}

Config.Values = {
	IndicTimeout = 2.5, -- idle seconds before typing indicator hides
	ProxRange = 40, -- studs
	cmdPrefix = "!", -- prefix for chat commands
	MaxHistLength = 20, -- max amount of messages that is kept in chat history log
}

return Config