-- Made By Masterp
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayersTable = {}
local SentRequests = {} -- 🆕 เพิ่มตัวเก็บสถานะคำขอที่ส่งไปแล้ว
local Count = 0 

local function addPlayer(player)
    if player ~= LocalPlayer then
        table.insert(PlayersTable, player.Name)
        print(player.Name .. " has been added!")
    end
end

local function removePlayer(player)
    for i, v in pairs(PlayersTable) do
        if v == player.Name then
            table.remove(PlayersTable, i)
            print(player.Name .. " has been removed!")
            break
        end
    end
end

Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

print('============== << STARTING ADD ALL TO TABLE >> ==============')
for _, player in pairs(Players:GetPlayers()) do
    addPlayer(player)
end

spawn(function()
    print('============== << STARTING CHECK >> ==============')
    while true do
        task.wait(5)
        if #PlayersTable > 0 then
            for i = #PlayersTable, 1, -1 do
                local playerName = PlayersTable[i]
                local player = Players:FindFirstChild(playerName)
                if player then
                    local success, err = pcall(function()
                        if not LocalPlayer:IsFriendsWith(player.UserId) and not SentRequests[player.UserId] then
                            print('Sending friend request to: ' .. player.Name)
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Friend Request",
                                Text = player.Name,
                                Duration = 5
                            })
                            LocalPlayer:RequestFriendship(player)

                            -- ✅ จดจำว่าเคยส่งแล้ว
                            SentRequests[player.UserId] = true
                            Count += 1
                            task.wait(10)

                            if Count >= 5 then
                                table.remove(PlayersTable, i)
                                Count = 0
                            end
                        else
                            -- ✅ ถ้าเป็นเพื่อนแล้ว หรือเคยส่งไปแล้ว
                            print(player.Name .. " is already a friend or request sent.")
                            table.remove(PlayersTable, i)
                        end
                    end)
                    if not success then
                        warn("Error: " .. tostring(err))
                    end
                else
                    table.remove(PlayersTable, i)
                end
            end
        else
            print("No players left in table.")
        end
    end
end)
