task.spawn(function()
task.wait(10)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}

	if tostring(self) == "TD_Play" and method == "InvokeServer" then
		local tdId = args[1]		
		local TD_SetSpeed = ReplicatedStorage:WaitForChild("Network"):WaitForChild("TD_SetSpeed")
		warn("⚙️ Gọi TD_SetSpeed:InvokeServer với:", tdId, 2)
		TD_SetSpeed:InvokeServer(tdId, 2)
	end

	return oldNamecall(self, ...)
end)


end)
