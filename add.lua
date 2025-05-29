-- Made By Masterp
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayersTable = {}

-- ฟังก์ชันเพิ่มผู้เล่นใหม่เข้าตาราง
local function addPlayer(player)
    if player ~= LocalPlayer then
        table.insert(PlayersTable, player.Name)
        print(player.Name .. " has been added!")
    end
end

-- ฟังก์ชันลบผู้เล่นที่ออกเกมออกจากตาราง
local function removePlayer(player)
    for i, v in pairs(PlayersTable) do
        if v == player.Name then
            table.remove(PlayersTable, i)
            print(player.Name .. " has been removed!")
            break
        end
    end
end

-- เชื่อมต่อเหตุการณ์เมื่อผู้เล่นเข้า/ออก
Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

-- เพิ่มผู้เล่นที่อยู่แล้วในเกมตอนเริ่ม
print('============== << STARTING ADD ALL TO TABLE >> ==============')
for _, player in pairs(Players:GetPlayers()) do
    addPlayer(player)
end

-- ตรวจสอบสถานะเพื่อน (โดยไม่ส่งคำขอ)
spawn(function()
    print('============== << STARTING FRIEND STATUS CHECK >> ==============')
    while true do
        task.wait(10)
        for i = #PlayersTable, 1, -1 do
            local playerName = PlayersTable[i]
            local player = Players:FindFirstChild(playerName)

            if player then
                local userId = player.UserId
                local success, err = pcall(function()
                    if not LocalPlayer:IsFriendsWith(userId) then
                        -- แสดง Notification ถ้ายังไม่เป็นเพื่อน
                        print(player.Name .. " is NOT your friend yet.")
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "ไม่ใช่เพื่อนกัน",
                            Text = player.Name .. " ยังไม่ได้เป็นเพื่อนกับคุณ",
                            Duration = 5
                        })
                    end
                end)

                if not success then
                    warn("Error checking friend status: " .. tostring(err))
                end
            else
                table.remove(PlayersTable, i) -- เอาออกถ้าผู้เล่นออกจากเกม
            end
        end
    end
end)
