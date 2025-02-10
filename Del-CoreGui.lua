local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

-- ซ่อนตัวละครของผู้เล่น
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            end
        end
    end)
end)

-- ซ่อนวัตถุทั้งหมดในเกมที่เป็น BasePart หรือ Part
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") or v:IsA("Part") then
        v.Transparency = 1
    end
end

-- ปิด GUI ของผู้เล่นใน PlayerGui
local localPlayer = Players.LocalPlayer
if localPlayer then
    for _, v in pairs(localPlayer.PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            v.Enabled = false
        end
    end
end

-- ปิด GUI ใน StarterGui
for _, v in pairs(StarterGui:GetChildren()) do
    if v:IsA("ScreenGui") then
        v.Enabled = false
    end
end

-- ลบทุกอย่างใน CoreGui (ใช้ pcall เพื่อป้องกัน error)
for _, v in pairs(CoreGui:GetDescendants()) do
    pcall(function()
        v:Destroy()
    end)
end
