local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")

-- ปิดการแสดงผล 3D (จอมืด)
runService:Set3dRenderingEnabled(false)

-- ปิดแชททั้งหมด
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

-- ปิด UI อื่น ๆ เช่น Leaderboard, Health Bar
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
