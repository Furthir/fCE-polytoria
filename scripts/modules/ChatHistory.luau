local ChatHistory = {}

local cfg = require(ScriptService.Chat:WaitChild("Config"))

local MAXLENGTH = cfg.Values.MaxHistLength

local log = {}

function ChatHistory.Add(msg)
	table.insert(log, msg)
	if #log > MAXLENGTH then
		table.remove(log, 1)
	end
end

function ChatHistory.Get()
	local l = table.clone(log)
	return l
end

return ChatHistory