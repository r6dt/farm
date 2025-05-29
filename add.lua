repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayersTable = {}

-- เพิ่มผู้เล่นใหม่เข้าตาราง
local function addPlayer(player)
    if player ~= LocalPlayer then
        table.insert(PlayersTable, player.Name)
        print(player.Name .. " has been added!")
    end
end

-- ลบผู้เล่นออกจากตารางเมื่อออกจากเกม
local function removePlayer(player)
    for i, v in pairs(PlayersTable) do
        if v == player.Name then
            table.remove(PlayersTable, i)
            print(player.Name .. " has been removed!")
            break
        end
    end
end

-- เชื่อมต่อเหตุการณ์
Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

-- ใส่ผู้เล่นที่อยู่แล้วในเกม
print('============== << STARTING ADD ALL TO TABLE >> ==============')
for _, player in pairs(Players:GetPlayers()) do
    addPlayer(player)
end

-- วนตรวจสอบ
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

                    local success, err = pcall(function()
                        if not LocalPlayer:IsFriendsWith(userId) then
                            -- ✅ ส่งคำขอเพื่อนทันทีโดยไม่มี cooldown
                            print('Sending friend request to: ' .. player.Name)
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Friend Request",
                                Text = player.Name,
                                Duration = 5
                            })
                            LocalPlayer:RequestFriendship(player)
                        end
                    end)

                    if not success then
                        warn("Error: " .. tostring(err))
                    end
                else
                    table.remove(PlayersTable, i) -- ถ้า player ออกจากเกม
                end
            end
        else
            print("No players left in table.")
        end
    end
end)
