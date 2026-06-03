# fCE-polytoria
Source of frthr's Chat Enhancements

# Details
Provides a set of chat enhancements that Polytoria does not currently have with its chat.

- Proximity Chat: Messages sent by players, when enabled, will only show to those nearby, based on the configured range.
- Muting: Using `!mute [playername]` in chat will mute a player, and you can no longer see their messages. Using `!unmute [playername]` will undo that.
- Blocking: Using `!block [playername]` in chat will block a player, and that player can no longer see your messages. Using `!unblock [playername]` will undo that.
- Whispering: Using `!whisper [playername] [msg]` will whisper to a player. You and that player will be the only people who can see that message.
- Typing Indicators: This is triggered when typing in chat and will show an indicator above the player's head.

All features can be toggled on or off inside ScriptService/Chat/Config.

# Instructions to Use
###### A README is additionally provided under ScriptService/Chat/README with more details.

1. Download this repository as a zip or clone this repo by running 

```
git clone https://github.com/Furthir/fCE-polytoria
```

2. Open project in Creator

3. Add the files
  - If you are starting fresh (using this as a base), you can safely delete anything in Environment and ScriptService/Unrelated.
  
  - If you have an existing game and want to add this, copy everything that isn't in Environment or ScriptService/Unrelated into your game. The provided README inside ScriptService/Chat will have the specific paths if you're unsure.

4. Configure the settings in ScriptService/Chat/Config to your preference.


---
You are free to do whatever you want with this game, credits unnecessary. If you need any help, feel free to ping me in the Polytoria Discord or comment on the game. 
