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
- Pinging: If DND (the bell button) is not on and Player's name is present anywhere in the message, a sound will be played and an indicator will show behind the chat button.

All features can be toggled on or off inside ScriptService.Chat.Config.

# Instructions to Use
###### A README is additionally provided under ScriptService.Chat.README with more details.

## Installation

1. Download the model from the [latest release](https://github.com/furthir/fCE-Polytoria/releases/latest/download/ChatEnhancements.ptmd)

2. Import the model into your game (Menu bar > Model > Import)

3. Detach the model (Right click model > Detach Model) to view its contents

4. Drag the instances into their respective locations

4. Configure the settings in ScriptService.Chat.Config to your preference.


## Updating
1. Save your Config (ScriptService.Chat.Config) script somewhere temporary, including any chat script that you've changed yourself, and remove everything else related to chat:
 - ScriptService.Chat
 - PlayerGUI.ChatGUI
 - PlayerDefaults.Chat
 - ServerHidden.TypingIndic (low prio, can usually skip)
 - Hidden.Range & Hidden.Ping (low prio, can usually skip)

2. Repeat the installation steps above.

3. Copy over your desired config settings.

4. Replace/merge any scripts as needed, make sure to look at what has actually changed so you can safely replace it without breaking/losing things.

---

You are free to do whatever you want with this game, credits unnecessary. If you need any help, feel free to comment on the game or on my profile's wall. 
