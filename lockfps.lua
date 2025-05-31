-- ตรวจสอบว่ามีการรันสคริปต์นี้ไปแล้วหรือยัง
if _G.LOOKFPSX then
    warn("สคริปต์ได้ทำงานไปแล้วก่อนหน้านี้!")
    return -- หยุดการทำงานถ้าเคยรันแล้ว
end

-- กำหนดว่าได้เริ่มรันสคริปต์นี้แล้ว
_G.LOOKFPSX = true
_G.LOOKFPS_STOP = false  -- ตัวแปรสำหรับหยุดสคริปต์อย่างปลอดภัย

spawn(function()
    -- ตั้งค่าการควบคุม FPS
    _G.fpsSettings = {
        default = 5,  -- ค่า FPS เริ่มต้น
        allowedFps = {5},  -- ค่า FPS ที่อนุญาต
        timeMarks = {18000, 36000},  -- เวลา (วินาที): 5 ชม., 10 ชม.
        fpsLevels = {5, 5}  -- ค่า FPS ตามช่วงเวลา
    }

    _G.overrideFps = 5  -- ค่า FPS สำหรับเปลี่ยนแบบแมนนวล

    setfpscap(_G.fpsSettings.default)
    print("ตั้งค่า fpscap เป็น", _G.fpsSettings.default)

    local startTime = tick()
    local nextMark = 1

    while true do
        -- ตรวจสอบว่ามีคำสั่งหยุดหรือไม่
        if _G.LOOKFPS_STOP then
            print("กำลังหยุดสคริปต์...")
            _G.LOOKFPS5 = nil
            return
        end

        task.wait()
        local elapsedTime = tick() - startTime
        local currentFpsCap = getfpscap()

        -- เช็กว่าให้เปลี่ยน FPS แบบแมนนวลไหม
        if _G.overrideFps then
            setfpscap(_G.overrideFps)
            print("เปลี่ยน FPS แบบแมนนวลเป็น", _G.overrideFps)
            _G.overrideFps = nil
        end

        -- ตรวจสอบว่า FPS ถูกเปลี่ยนเป็นค่าที่ไม่อนุญาตหรือไม่
        if not table.find(_G.fpsSettings.allowedFps, currentFpsCap) then
            local newCap = _G.fpsSettings.default
            for i, time in ipairs(_G.fpsSettings.timeMarks) do
                if elapsedTime >= time then
                    newCap = _G.fpsSettings.fpsLevels[i]
                end
            end
            setfpscap(newCap)
            print("ค่า FPS ถูกเปลี่ยนโดยไม่ได้รับอนุญาต, ตั้งกลับเป็น", newCap)
        end

        -- ตรวจสอบว่าเลยเวลาลด FPS หรือยัง
        if nextMark <= #_G.fpsSettings.timeMarks and elapsedTime >= _G.fpsSettings.timeMarks[nextMark] then
            setfpscap(_G.fpsSettings.fpsLevels[nextMark])
            print(string.format("ตั้งค่า fpscap เป็น %d หลังผ่านไป %d ชั่วโมง!", _G.fpsSettings.fpsLevels[nextMark], _G.fpsSettings.timeMarks[nextMark] / 3600))
            nextMark = nextMark + 1
        end
    end
end)
