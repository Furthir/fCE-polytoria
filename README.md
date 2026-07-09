# fCE-polytoria
Source of [frthr's Chat Enhancements](https://polytoria.com/places/127127)

# Details
Provides a set of chat enhancements that Polytoria does not currently have with its chat.

- Proximity Chat: Messages sent by players, when enabled, will only show to those nearby, based on the configured range.
- Muting: Using `!mute [playername]` in chat will mute a player, and you can no longer see their messages. Using `!unmute [playername]` will undo that.
- Blocking: Using `!block [playername]` in chat will block a player, and that player can no longer see your messages. Using `!unblock [playername]` will undo that.
- Whispering: Using `!whisper [playername] [msg]` will whisper to a player. You and that player will be the only people who can see that message.
- Typing Indicators: This is triggered when typing in chat and will show an indicator above the player's head.
- Text Color: Using `!me [msg]` will result in the message being colored as the user's color.
- Chat History: Newly joined players can see the messages from before they joined, up to the configured amount.

All features can be toggled on or off inside ScriptService.Chat.Config.

# Instructions to Use
###### A README is additionally provided under ScriptService.Chat.README with more details.

## Using the model (Recommended)

1. Download the model from the [latest release](https://github.com/furthir/fCE-Polytoria/releases/latest/download/ChatEnhancements.ptmd)

2. Import the model into your game (Menu bar > Model > Import)

3. Detach the model (Right click model > Detach Model) to view its content

4. Drag the instances into their respective locations

4. Configure the settings in ScriptService.Chat.Config to your preference.

## Using this repo

1. Download this repository as a zip or clone this repo by running 

```
git clone https://github.com/Furthir/fCE-polytoria
```

2. Open project in Creator

3. Add the files
  - If you are starting fresh (using this as a base), you can safely delete anything in Environment and ScriptService.Unrelated.
  
  - If you have an existing game and want to add this, copy and merge the `scripts/` folder from this repo into your game's directory. Very important step so don't miss it or else nothing will work. In Creator, copy everything that isn't in Environment or ScriptService.Unrelated into your game. The provided README inside ScriptService.Chat will have the specific paths if you're unsure.

4. Configure the settings in ScriptService.Chat.Config to your preference.

---

You are free to do whatever you want with this game, credits unnecessary. If you need any help, feel free to comment on the game or on my profile's wall. 
