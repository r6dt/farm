local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันส่งคำขอเป็นเพื่อนอัตโนมัติ
local function autoSendFriendRequest()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not LocalPlayer:IsFriendsWith(player.UserId) then
            LocalPlayer:RequestFriendship(player)
            print("ได้ส่งคำขอเป็นเพื่อนไปยัง:", player.Name)
        end
    end
end

-- ฟังก์ชันรับคำขอเป็นเพื่อนอัตโนมัติ
local function autoAcceptFriendRequests()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player:IsFriendRequestSent() then
            LocalPlayer:AcceptFriendRequest(player)
            print("ได้ยอมรับคำขอเป็นเพื่อนจาก:", player.Name)
        end
    end
end

-- วนลูปเพื่อส่งและรับคำขอเป็นเพื่อนอย่างต่อเนื่อง
while true do
    autoSendFriendRequest()
    autoAcceptFriendRequests()
    task.wait(10) -- ทำซ้ำทุก 10 วินาที
end
