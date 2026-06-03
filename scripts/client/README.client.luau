--[[
	frthr's Chat Enhancements
	
	Definitions: 
		Sender - The player who sent the message or command
		Player(s) - The target player(s), that is not the Sender
	
	-----
	
	Functionality:
		Proximity Chat - Messages sent by players, when enabled, will only be seen by other 
		players within the configured range in studs. All messages are sent through 
		UnicastMessage, which means they aren't real player messages. This requires a 
		custom chat bubble system and username color system, however the latter is easy to
		replicate. Messages tagged with the globe emoji are global messages, meaning anyone
		from anywhere can see it. Messages tagged with the person emoji will only be shown
		to those around Sender.
		
		Chat Bubble - As mentioned, regular chat bubbles cannot be used with prox chat, so
		it needs to be reimplemented. This tries to mimic the regular chat bubbles closely,
		with a few quirks. There may be an off chance that the text won't get wrapped, may
		break out of the bubble, or not layer correctly and text will end up behind
		the bubble itself (very annoying). Emojis currently work, however still count
		towards the character count before needing to wrap (e.g. :sunglasses: count as 12
		characters, instead of 1), which means there can only be 1-3 emojis per line
		before it makes a new one. Didn't bother to fix it cause it was already getting
		too complex.
		
		Muting - Using !mute [playername] in chat will mute a Player, meaning Sender can
		no longer see messages from Player, until !unmute [playername] is run.
		
		Blocking - Using !block [playername] in chat will block a Player, meaning the
		Player can no longer see messages from Sender, until !unblock [playername] is run.
	
		Whispering - Using !whisper [playername] [msg] in chat will whisper a message to
		the Player, while no one else can see that message.
	
		Typing Indicators - This is done by sending the server a signal whenever a key is 
		typed while the chat is focused, that isn't a blacklisted key defined in 
		ScriptService.Chat.TypingIndicLocal (mostly modifier keys). This times out after
		x seconds defined in ScriptService.Chat.Config and will hide the indicator.
		
	
	-----
	
	To put this into your own game, copy everything in 
	ScriptService.Chat,
	Hidden,
	ServerHidden,
	PlayerDefaults.Chat,
	PlayerGUI.ChatGUI
	
	to your own game (yeah it's a bit). Mostly everything chat related is inside of 
	ScriptService.Chat.ChatMain, and all visuals are in their own scripts 
	(e.g. BubbleLocal, TypingIndicLocal). Otherwise nothing else is necessary for this to work.
	To choose what you want to use, configure the settings in ScriptService.Chat.Config.
	
	You can adjust the proximity chat range inside of ScriptService.Chat.Config with the
	ProxRange variable, in studs, and the command prefix with the cmdPrefix variable. 
	
	All commands are located in ScriptService.Chat.Commands (module), which can be used in
	the future for UI integration (e.g. lists, UI for block/mute/whisper without commands).
	
	I've tried to comment a bunch of things to explain how it works but i almost never
	document my own code so uhhhh hopefully it makes sense. 
]]