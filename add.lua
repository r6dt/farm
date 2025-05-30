-- รอจนกว่าเกมจะโหลดเสร็จ
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- รอจนกว่าจะได้ LocalPlayer และตัวละคร
while not LocalPlayer or not LocalPlayer.Character do
    task.wait()
end

local PlayersTable = {}

-- ฟังก์ชันส่งคำขอเป็นเพื่อน (หากยังไม่เป็นเพื่อน)
local function trySendFriendRequest(player)
    if not LocalPlayer:IsFriendsWith(player.UserId) then
        print('ส่งคำขอเป็นเพื่อนไปยัง: ' .. player.Name)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Friend Request",
            Text = player.Name,
            Duration = 5
        })
        LocalPlayer:RequestFriendship(player)
    end
end

-- เพิ่มผู้เล่นใหม่เข้าตาราง และส่งคำขอเป็นเพื่อน
local function addPlayer(player)
    if player ~= LocalPlayer then
        table.insert(PlayersTable, player.Name)
        print(player.Name .. " ได้ถูกเพิ่มเข้าตารางแล้ว!")
        trySendFriendRequest(player)
    end
end

-- ลบผู้เล่นออกจากตารางเมื่อออกจากเกม
local function removePlayer(player)
    for i, v in pairs(PlayersTable) do
        if v == player.Name then
            table.remove(PlayersTable, i)
            print(player.Name .. " ได้ออกจากตารางแล้ว!")
            break
        end
    end
end

-- เชื่อมต่อเหตุการณ์
Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

-- ใส่ผู้เล่นที่อยู่แล้วในเกม และส่งคำขอเป็นเพื่อน
print('============== << เริ่มเพิ่มผู้เล่นทั้งหมดในตาราง >> ==============')
for _, player in pairs(Players:GetPlayers()) do
    addPlayer(player)
end
