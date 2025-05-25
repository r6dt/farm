repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayersTable = {}
local SentRequests = {} -- 🆕 เก็บเวลา timestamp ที่ส่งคำขอครั้งล่าสุด

local COOLDOWN_TIME = 300 -- 300 วินาที (5 นาที)

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
        task.wait(10)
        if #PlayersTable > 0 then
            for i = #PlayersTable, 1, -1 do
                local playerName = PlayersTable[i]
                local player = Players:FindFirstChild(playerName)
                if player then
                    local userId = player.UserId
                    local currentTime = os.time()
                    local lastSent = SentRequests[userId] or 0

                    local success, err = pcall(function()
                        if not LocalPlayer:IsFriendsWith(userId) and (currentTime - lastSent >= COOLDOWN_TIME) then
                            print('Sending friend request to: ' .. player.Name)
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Friend Request",
                                Text = player.Name,
                                Duration = 5
                            })
                            LocalPlayer:RequestFriendship(player)

                            -- ✅ บันทึกเวลาที่ส่งล่าสุด
                            SentRequests[userId] = currentTime
                        else
                            print(player.Name .. " is already your friend or waiting cooldown.")
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
