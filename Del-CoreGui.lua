local player = game.Players.LocalPlayer
local starterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")

-- ปิดการแสดงผล 3D
runService:Set3dRenderingEnabled(false)

-- ซ่อน UI ของผู้เล่น
for _, v in ipairs(player.PlayerGui:GetChildren()) do
    if v:IsA("ScreenGui") then
        v.Enabled = false
    end
end

-- ซ่อน UI ที่มาจาก StarterGui
for _, v in ipairs(starterGui:GetChildren()) do
    if v:IsA("ScreenGui") then
        v.Enabled = false
    end
end

-- ปิด CoreGui เช่น Leaderboard, Chat ฯลฯ
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
