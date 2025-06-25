-- 🧰 ฟังก์ชันส่งสัตว์เลี้ยงอัตโนมัติ
task.spawn(function()
    while true do 
        task.wait(1)

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        local LocalPlayer = Players.LocalPlayer
        local Client = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client")
        local SaveModule = require(Client:WaitForChild("Save"))
        local Network = require(Client:WaitForChild("Network"))

        -- 🧰 เช็คสัตว์เลี้ยงในคลัง
        local inventory = SaveModule.Get().Inventory.Tower or {}

        -- 🎯 รายชื่อสัตว์เลี้ยงที่ต้องเช็ค
        local petIds = {
            "Nuclear Dominus",
            "Blurred Owl",
            "Nightmare Cyclops",
			"Arcade Angelus"
        }

        -- 🎁 ตั้งค่าผู้รับ + ข้อความ
        local username = "gymjft"
        local messages = {
            "Here's a gift, %s!",
            "Sending you something cool, %s!",
            "Take this one, %s!",
            "You've got mail, %s!"
        }

        for _, targetId in ipairs(petIds) do
            local pets = {}
            local count = 0

            for uid, obj in pairs(inventory) do
                if obj.id == targetId or obj.name == targetId then
                    local amount = obj._am or 1
                    local xp = (obj._uq and obj._uq.xp) or 0

                    table.insert(pets, {
                        uid = uid,
                        amount = amount,
                        xp = xp
                    })

                    count += amount
                    warn(string.format("🐾 [%s] UID: %s | XP: %d | จำนวน: %d", targetId, uid, xp, amount))
                end
            end

            warn(string.format("✅ [%s] พบทั้งหมด %d ตัว จาก %d UID.", targetId, count, #pets))

            if #pets > 1 then
                table.sort(pets, function(a, b)
                    return a.xp > b.xp
                end)

                warn(string.format("🔒 [%s] เก็บตัวที่ XP สูงสุดไว้: %s | XP: %d", targetId, pets[1].uid, pets[1].xp))

                for i = 2, #pets do
                    local pet = pets[i]
                    task.wait(2)

                    local message = string.format(messages[math.random(1, #messages)], username)
                    warn(string.format("📤 [%s] ส่ง UID: %s | XP: %d", targetId, pet.uid, pet.xp))

                    local success, err = Network.Invoke("Mailbox: Send", username, message, "Tower", pet.uid, pet.amount)
                    if success then
                        warn("✅ ส่งสำเร็จ:", pet.uid)
                    else
                        warn("❌ ส่งไม่สำเร็จ:", err)
                    end
                end
            else
                warn("⚠️ [" .. targetId .. "] ไม่มีสัตว์เลี้ยงเหลือหรือมีเพียงตัวเดียว.")
            end
        end

        task.wait(1800) -- ทำงานซ้ำทุก 30 นาที
    end
end)

-- 🖥️ แสดงจำนวนไอเทมกลางหน้าจอ
task.spawn(function()
	task.wait(1)

	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local Client = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client")
	local SaveModule = require(Client:WaitForChild("Save"))

	local itemsToTrack = {
	
		{ id = "Blurred Owl", guiName = "Item3", row = 1, col = 0, color = Color3.fromRGB(0, 255, 255) },		-- ฟ้า
		{ id = "Nightmare Cyclops", guiName = "Item4", row = 1, col = 1, color = Color3.fromRGB(192,192,192) }, -- เงิน
		{ id = "Arcade Angelus", guiName = "Item1", row = 0, col = 0, color = Color3.fromRGB(255, 165, 0) },	-- ส้ม
		{ id = "Nuclear Dominus", guiName = "Item2", row = 0, col = 1, color = Color3.fromRGB(255, 255, 255) },	-- ขาว
	}

	local function createItemFrame(itemConfig, itemCount)
		local frameSize = 100
		local spacing = 10
		local cols = 2
		local rows = 2

		local offsetX = (itemConfig.col * (frameSize + spacing)) - ((cols - 1) * (frameSize + spacing) / 2)
		local offsetY = (itemConfig.row * (frameSize + spacing)) - ((rows - 1) * (frameSize + spacing) / 2) + 80

		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = itemConfig.guiName
		screenGui.Parent = PlayerGui
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local frame = Instance.new("Frame")
		frame.Name = "ItemFrame"
		frame.Size = UDim2.new(0, frameSize, 0, frameSize)
		frame.Position = UDim2.new(0.5, offsetX, 1, -offsetY)
		frame.AnchorPoint = Vector2.new(0.5, 1)
		frame.BackgroundColor3 = itemConfig.color
		frame.BorderSizePixel = 2
		frame.Parent = screenGui

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.BackgroundTransparency = 1
		label.Text = tostring(itemCount)
		label.TextColor3 = Color3.fromRGB(0, 0, 0)
		label.TextScaled = true
		label.Font = Enum.Font.GothamBold
		label.Parent = frame
	end

	local function checkInventory()
		local inventory = SaveModule.Get().Inventory or {}
		for _, item in ipairs(itemsToTrack) do
			local oldGui = PlayerGui:FindFirstChild(item.guiName)
			if oldGui then oldGui:Destroy() end
		end

		for _, item in ipairs(itemsToTrack) do
			local count = 0
			for _, group in pairs(inventory) do
				for _, obj in pairs(group) do
					if obj.id == item.id then
						count += (obj._am or 1)
					end
				end
			end
			createItemFrame(item, count)
		end
	end

	checkInventory()
	while true do
		task.wait(10)
		checkInventory()
	end
end)

-- 📍 ตรวจสอบพิกัด + ออกจากเกมเมื่อไม่พบผู้เล่น
task.spawn(function()
	task.wait(150)
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")

	local player = Players.LocalPlayer
	local screenGui = Instance.new("ScreenGui")
	screenGui.Parent = player:WaitForChild("PlayerGui")

	local coordLabel = Instance.new("TextLabel")
	coordLabel.Size = UDim2.new(0, 400, 0, 50)
	coordLabel.Position = UDim2.new(0.5, -200, 0.5, -25)
	coordLabel.BackgroundTransparency = 0.4
	coordLabel.BackgroundColor3 = Color3.new(0, 0, 0)
	coordLabel.TextColor3 = Color3.new(1, 1, 1)
	coordLabel.TextScaled = true
	coordLabel.Font = Enum.Font.SourceSansBold
	coordLabel.Text = "wait..."
	coordLabel.Parent = screenGui

	RunService.RenderStepped:Connect(function()
		local character = player.Character
		if character and character:FindFirstChild("HumanoidRootPart") then
			-- local pos = character.HumanoidRootPart.Position
			-- coordLabel.Text = string.format("X: %.1f | Y: %.1f | Z: %.1f", pos.X, pos.Y, pos.Z)
		else
			coordLabel.Text = "ไม่พบผู้เล่น!"
			game:Shutdown()
		end
	end)
end)

-- 🧪 อัปเกรดยาและหนังสืออัตโนมัติหากเลเวลน้อย
task.spawn(function()
	task.wait(150)
	local Save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
	local level = Save.Get().Mastery and Save.Get().Mastery.Potions

	if level and level < 13034430 then
		local function upgradePotion(name, lvl)
			local inventory = Save.Get().Inventory.Potion
			local count, uid = 0, nil
			for k, v in pairs(inventory) do
				if v.id == name and v.tn == lvl then
					count += (v._am or 1)
					uid = tostring(k)
				end
			end
			local up = count // 3
			if uid and up > 0 then
				game.ReplicatedStorage.Network.UpgradePotionsMachine_Activate:InvokeServer(uid, up)
				warn("อัปเกรดยา: " .. name .. " x" .. up)
			end
		end

		local potions = { "Treasure Hunter", "Walkspeed", "Strong Pets", "Lucky Eggs", "Diamonds", "Coins" }
		for _, name in ipairs(potions) do
			upgradePotion(name, 1)
			task.wait(2)
			upgradePotion(name, 2)
			task.wait(2)
		end
	end

	local levelE = Save.Get().Mastery and Save.Get().Mastery.Enchants
	if levelE and levelE < 13034430 then
		local function upgradeEnchant(name, lvl)
			local inventory = Save.Get().Inventory.Enchant
			local count, uid = 0, nil
			for k, v in pairs(inventory) do
				if v.id == name and v.tn == lvl then
					count += (v._am or 1)
					uid = tostring(k)
				end
			end
			local up = count // 5
			if uid and up > 0 then
				game.ReplicatedStorage.Network.UpgradeEnchantsMachine_Activate:InvokeServer(uid, up)
				warn("อัปเกรดหนังสือ: " .. name .. " lv" .. lvl .. " x" .. up)
			end
		end

		local enchants = {
			"Treasure Hunter", "Tap Power", "Strong Pets", "Walkspeed",
			"Magnet", "Lucky Eggs", "Diamonds", "Criticals", "Coins"
		}

		for _, name in ipairs(enchants) do
			upgradeEnchant(name, 1)
			task.wait(2)
			upgradeEnchant(name, 2)
			task.wait(2)
		end
	end
end)
