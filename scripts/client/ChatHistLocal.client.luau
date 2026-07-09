local histev: NetworkEvent = ScriptService.Chat.Events:WaitChild("LoadHistory")

histev.InvokedClient:Connect(function(msg)
	local string = msg.GetString("msg")
	Chat:UnicastMessage(string, Players.LocalPlayer)
end)