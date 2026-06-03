local Config = {}

Config.Toggles = {
	Bubbles = true,
	Proximity = true, -- will disable custom bubbles if false
	TypingIndicators = true,
	Muting = true,
	Blocking = true,
	Whispering = true,
}

Config.Values = {
	IndicTimeout = 3, -- idle seconds before typing indicator hides
	ProxRange = 40, -- studs
	cmdPrefix = "!", -- prefix for chat commands
}

return Config