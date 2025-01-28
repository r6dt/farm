repeat wait(10) until game:IsLoaded()


loadstring(game:HttpGet("https://raw.githubusercontent.com/r6dt/farm/main/Del-CoreGui.lua"))()
task.wait(10)


loadstring(game:HttpGet("https://raw.githubusercontent.com/r6dt/farm/main/farm.lua"))()


task.wait(120)

-- ตั้งค่า fps cap ทุกๆ 5 วินาที
while task.wait(5) do
    setfpscap(5)
end
