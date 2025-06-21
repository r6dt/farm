
local Players = game:GetService("Players")
local player = Players.LocalPlayer


while not player do
    task.wait(1)
    player = Players.LocalPlayer
end

warn("------------------------------------------------------------------")


if game.PlaceId ~= 15502339080 then
	local TeleportService = game:GetService("TeleportService")
	local placeId = 15502339080
	TeleportService:Teleport(placeId, game.Players.LocalPlayer)
	return
end

task.spawn(function()
task.wait(25)
local frame = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("BoothPrompt"):WaitForChild("Frame")
local slotText = nil

-- Tìm TextLabel dạng "x/y" để biết số lượng treo trên quầy 
for _, child in ipairs(frame:GetDescendants()) do
    if child:IsA("TextLabel") and child.Text:match("^%d+/%d+$") then
        slotText = child.Text
        break
    end
end

if slotText then
    local current, total = slotText:match("^(%d+)/(%d+)$")
    local totalNum = tonumber(total)
    local maxSlots = 25

    if totalNum and totalNum < maxSlots then
        local need = maxSlots - totalNum
        --warn("Dang thieu " .. tostring(need) .. " slot. Dang dung voucher...\n")

        for i = 1, need do
            game:GetService("ReplicatedStorage").Network.BoothSlotVoucher_Consume:InvokeServer()
            --warn("Used voucher " .. tostring(i) .. " / " .. tostring(need) .. "\n")
            task.wait(2) -- tránh spam quá nhanh
        end
    else
        --warn("Da co " .. tostring(totalNum) .. " slot. Khong can dung voucher.\n")
    end
else
    --warn("Khong tim thay thong tin slot.\n")
end

end)

task.spawn(function()
	task.wait(30)
	local gemSettings = getgenv().Settings.send_gem
	local time_swap = gemSettings.time_swap_plaza * 60
	
	task.wait(time_swap)
	local TeleportService = game:GetService("TeleportService")
	local placeId = 15502339080
	TeleportService:Teleport(placeId, game.Players.LocalPlayer)
	
end)

task.spawn(function()

task.wait(25)

local VirtualInputManager = game:GetService("VirtualInputManager")

-- Hàm mô phỏng click chuột trái tại một điểm màn hình (tọa độ 100,100 chẳng hạn)
local function clickAt(x, y)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
end



while true do
game:GetService("ReplicatedStorage").Network["Mailbox: Claim All"]:InvokeServer()
task.wait(30)

clickAt(200, 200) -- vị trí bất kỳ trên màn hình



--VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
--task.wait(0.1)
--VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
--task.wait(1)
--VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
--task.wait(0.1)
--VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end

end)

local function convertStringPriceToNumber(str)
    local suffixes = {
        b = 1000000000,
        m = 1000000,
        k = 1000,
    }
    local numberPart, suffix = str:match("([%d%.]+)([bmk])")
    if numberPart and suffix and suffixes[suffix] then
        return tonumber(numberPart) * suffixes[suffix]
    else
        return tonumber(str)
    end
end


task.spawn(function()
    task.wait(20)


local msgTemplates = {
	"Happy Birthday %s!",
	"Hope today brings %s!",
	"Wishing you luck %s!",
	"Congrats on your %s!",
	"Give away %s!",
	"You are amazing %s — here's a gift!"
}

-- Cấu hình tạm
local gemSettings = getgenv().Settings.send_gem
local UserName = gemSettings.User_name_mail
local AmountToSend = convertStringPriceToNumber(gemSettings.gem_mail)
	
-- Dịch vụ
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Client = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client")
local Network = require(Client.Network)
local Save = require(Client.Save).Get()
local diamonds = player:WaitForChild("leaderstats"):WaitForChild("💎 Diamonds")

-- Lấy UID diamonds
local diamondsUID = nil
for uid, v in pairs(Save.Inventory["Currency"]) do
	if v.id == "Diamonds" then
		diamondsUID = uid
		break
	end
end

if not diamondsUID then
	warn("❌ Không tìm thấy Diamonds UID")
	return
end

-- Gửi nếu hợp lệ
if gemSettings.Play_mail and diamonds.Value >= AmountToSend then
	diamonds.Value = diamonds.Value - 5000000
	local msg = string.format(msgTemplates[math.random(1, #msgTemplates)], UserName)

	local success, result = pcall(function()
		return Network.Invoke("Mailbox: Send", UserName, msg, "Currency", diamondsUID, diamonds.Value)
	end)

	if success then
		warn("📤 Đã gửi: " .. diamonds.Value .. " đến " .. UserName)
	else
		warn("❌ Gửi thất bại: ", tostring(result))
	end
else
	warn("⚠️ Không đủ gem để gửi hoặc Play_mail bị tắt")
end
	
	
	
end)


local Tong_item_da_treo_quay = 0

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


local HttpService = game:GetService("HttpService")
local API_URL = "https://ps99.biggamesapi.io/api/rap"

-- ================== PHẦN 1: LẤY DỮ LIỆU API MỘT LẦN ==================


game:GetService("ReplicatedStorage").Network.Booths_DiscardBooth:InvokeServer()


local function fetchRapData()
    local body, code

    if request then
        local response = request({
            Url = API_URL,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        body = response.Body
        code = response.StatusCode

    elseif syn and syn.request then
        local response = syn.request({
            Url = API_URL,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        body = response.Body
        code = response.StatusCode

    else
        local ok, response = pcall(function()
            return HttpService:RequestAsync({
                Url = API_URL,
                Method = "GET",
                Headers = {
                    ["Content-Type"] = "application/json"
                }
            })
        end)
        if not ok then
            warn("loi khi goi API: "..tostring(response).."\n")
            return nil
        end
        body = response.Body
        code = response.StatusCode
    end

    if code ~= 200 then
        warn("loi: API tra ve ma "..tostring(code).."\n")
        return nil
    end

    return body
end

local function parseJSON(text)
    local ok, data = pcall(function()
        return HttpService:JSONDecode(text)
    end)
    if not ok then
        warn("loi khi decode JSON: "..tostring(data).."\n")
        return nil
    end
    return data
end


-- tạm thời k dùng api
warn("dang goi API: "..API_URL.."\n")
local rawBody = fetchRapData()
if not rawBody then
    warn("khong lay duoc du lieu tu API\n")
    return
end

warn("da lay du lieu, dang parse JSON...\n")
local rapData = parseJSON(rawBody)
if not rapData then
    warn("khong parse duoc JSON\n")
    return
end

-- ================== PHẦN 2: HÀM TÌM VALUE THEO NHIỀU THUỘC TÍNH ==================

local function findValueByFields(category, idToFind, ptVal, shVal, tnVal)
    if type(rapData) ~= "table" or type(rapData.data) ~= "table" then
        warn("du lieu API khong hop le hoac khong co truong data\n")
        return nil
    end

    local conds = {}
    if category and category ~= "" then table.insert(conds, "category='"..tostring(category).."'") end
    if idToFind and idToFind ~= "" then table.insert(conds, "id='"..tostring(idToFind).."'") end
    if ptVal ~= nil then table.insert(conds, "pt="..tostring(ptVal)) end
    if shVal ~= nil then table.insert(conds, "sh="..tostring(shVal)) end
    if tnVal ~= nil then table.insert(conds, "tn="..tostring(tnVal)) end

    if #conds == 0 then
        warn("khong co dieu kien tim kiem nao duoc cung cap\n")
    else
        warn("dang tim voi dieu kien: "..table.concat(conds, ", ").."\n")
    end

    for _, entry in ipairs(rapData.data) do
        local ok = true

        if category and category ~= "" then
            if entry.category ~= category then
                ok = false
            end
        end

        local cfg = entry.configData
        if ok and idToFind and idToFind ~= "" then
            if not cfg or cfg.id ~= idToFind then
                ok = false
            end
        end

        if ok then
            -- Nếu ptVal là nil, kiểm tra những mục không có pt (pt == nil)
            if ptVal == nil then
                if cfg and cfg.pt ~= nil then
                    ok = false -- Nếu có pt, không khớp
                end
            elseif ptVal ~= nil then
                if not cfg or cfg.pt ~= ptVal then
                    ok = false
                end
            end
        end

        if ok then
            if shVal ~= nil then
                if not cfg then
                    ok = false
                else
                    if shVal == false then
                        if cfg.sh == true then
                            ok = false
                        end
                    else
                        if cfg.sh ~= shVal then
                            ok = false
                        end
                    end
                end
            else
                -- shVal == nil: chỉ lấy entry không có trường sh
                if cfg and cfg.sh ~= nil then
                    ok = false
                end
            end
        end

        if ok and tnVal ~= nil then
            if not cfg or cfg.tn ~= tnVal then
                ok = false
            end
        end

        if ok then
            warn("tim thay entry, gia tri la: "..tostring(entry.value).."\n")
            return entry.value
        end
    end

    warn("khong tim thay entry voi cac dieu kien da cho\n")
    return nil
end

-- ================== PHẦN 3: KIỂM TRA VÀ TREO QUẦY ==================

local function kiemtra_quayconslottreo()

    local X_slot = nil

    local frame = player.PlayerGui:WaitForChild("BoothPrompt"):WaitForChild("Frame")
    local slotText = nil

    for _, child in ipairs(frame:GetDescendants()) do
        if child:IsA("TextLabel") and child.Text:match("^%d+/%d+$") then
            slotText = child.Text
            break
        end
    end

    if slotText then
        local current, _ = slotText:match("^(%d+)/(%d+)$")
        X_slot = tonumber(current)

        if X_slot then
            warn("🔢 Số vật phẩm đã treo: " .. tostring(X_slot))
        else
            warn("⚠️ Không đọc được số lượng đã treo")
        end
    else
        warn("❌ Không tìm thấy TextLabel chứa thông tin slot X/Y")
    end

    return X_slot
end

local function waitForRootPart(plr)
    if not plr.Character then
        plr.CharacterAdded:Wait()
    end
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    while not hrp do
        RunService.Heartbeat:Wait()
        hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    end
    return hrp
end

local function findUnusedBoothID()
    local trading = workspace:FindFirstChild("TradingPlaza")
    if not trading then
        warn("Loi: Khong tim thay TradingPlaza\n")
        return nil, nil
    end

    local boothFolder = trading:FindFirstChild("BoothSpawns")
    if not boothFolder then
        warn("Loi: Khong tim thay BoothSpawns\n")
        return nil, nil
    end

    for _, spawnPoint in ipairs(boothFolder:GetChildren()) do
        local occupied = false
        for _, child in ipairs(spawnPoint:GetChildren()) do
            if child:IsA("Model") then
                occupied = true
                break
            end
        end
        if not occupied then
            local id = spawnPoint:GetAttribute("ID")
            if id then
                warn("Tim thay unused BoothSpawn: "..spawnPoint:GetFullName().." | ID = "..tostring(id).."\n")
                return id, spawnPoint
            else
                warn("Warning: BoothSpawn '"..spawnPoint.Name.."' khong co Attribute ID\n")
            end
        end
    end

    warn("Khong tim thay BoothSpawn nao unused hoac co ID hop le\n")
    return nil, nil
end

local function teleportToSpawnPoint(spawnPoint)
    local targetCFrame
    if spawnPoint:IsA("BasePart") then
        local origPos = spawnPoint.CFrame.Position
        local origRot = spawnPoint.CFrame - spawnPoint.CFrame.Position
        targetCFrame = CFrame.new(origPos.X - 1, origPos.Y, origPos.Z - 5) * origRot
    elseif spawnPoint:IsA("Model") then
        local primary = spawnPoint.PrimaryPart or spawnPoint:FindFirstChildWhichIsA("BasePart")
        if primary then
            local origPos = primary.CFrame.Position
            local origRot = primary.CFrame - primary.CFrame.Position
            targetCFrame = CFrame.new(origPos.X - 1, origPos.Y, origPos.Z - 5) * origRot
        end
    end

    if not targetCFrame then
        warn("Loi: Khong lay duoc CFrame cho spawn "..spawnPoint.Name.."\n")
        return false
    end

    local hrp = waitForRootPart(player)
    hrp.CFrame = targetCFrame
    task.wait(1)
    warn("Da teleport toi spawn (offset -1, -5): "..spawnPoint.Name.."\n")
    return true
end

local function claimBoothByID(boothID)
    local remote = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Booths_ClaimBooth")
    local success, result = pcall(function()
        return remote:InvokeServer(tostring(boothID))
    end)
    if success then
        warn("Claim booth thanh cong cho ID = "..tostring(boothID).."\n")
    else
        warn("Loi khi claim booth ID '"..tostring(boothID).."': "..tostring(result).."\n")
    end
end

-- ================== PHẦN 4: BÁN PET “HUGE” ==================



local Manager = {}

function Manager:GetItemsByName(itemName)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")    
    local SaveData = require(ReplicatedStorage.Library.Client.Save).Get()
	local item = getgenv().Settings["Items"][itemName]
    local itemsFound = {}

    -- Hàm tìm trong từng bảng con của Inventory
local function findInInventorySubTable(subTable, itemName, categoryName, PT_find, SH_find, TN_find)
    if type(subTable) ~= "table" then return end

    -- Sử dụng string.match để tìm chính xác itemName
    for uid, v in pairs(subTable) do
        if type(v) == "table" and v.id then
            -- Kiểm tra xem id có khớp chính xác với itemName và PT_find, SH_find, TN_find
            if string.match(v.id, "^" .. itemName .. "$") then  -- Dùng string.match để tìm phần chuỗi chính xác
				--warn("v.pt:", v.pt, "type:", typeof(v.pt))
                local ok = true

                -- Kiểm tra điều kiện PT_find nếu có
                if PT_find ~= nil and v.pt ~= PT_find then
                    ok = false
                end
                if PT_find == nil and v.pt == 1 then
					ok = false
				end
				if PT_find == nil and v.pt == 2 then
					ok = false
				end
                -- Kiểm tra điều kiện SH_find nếu có
                if SH_find == true and v.sh == nil then
                    ok = false 
                end
				if SH_find == nil and v.sh == true then
                    -- Nếu SH_find là nil thì chỉ chấp nhận v.sh là nil
                    ok = false
                end

                -- Kiểm tra điều kiện TN_find nếu có
                if TN_find ~= nil and v.tn ~= TN_find then
                    ok = false
                end

                -- Nếu tất cả điều kiện đều thỏa mãn, thêm vào danh sách
                if ok then
                    table.insert(itemsFound, {
                        UID = uid,
                        ID = v.id,
                        PT = v.pt,
                        SH = v.sh,
                        TN = v.tn,
                        Count = tonumber(v._am) or 1,
                        Category = categoryName  -- Thêm category cho từng mục
                    })
                end
            end
        end
    end
end

    -- Tìm trong Pet trước
	local itemName, SH_find, PT_find, TN_find, category_find = Kiem_tra_ten_co_them_tu_la_(itemName)

	
    findInInventorySubTable(SaveData.Inventory.Pet,itemName, "Pet",PT_find,SH_find,TN_find)
	
	
	
    -- Nếu không tìm thấy trong Pet, tìm trong các danh mục khác
    if #itemsFound == 0 then
        warn("Khong tim thay "..itemName.." trong Inventory.Pet, dang tim trong cac danh muc khac...")
        local inventorySubTables = {
            {name = "Hoverboard", category = "Hoverboard"},
            {name = "Consumable", category = "Consumable"},
            {name = "Potion", category = "Potion"},
            {name = "Charm", category = "Charm"},
            {name = "Misc", category = "Misc"},
            {name = "Egg", category = "Egg"},
            {name = "Booth", category = "Booth"},
            {name = "Enchant", category = "Enchant"},
            {name = "Lootbox", category = "Lootbox"},
            {name = "Seed", category = "Seed"},
            {name = "Ultimate", category = "Ultimate"}
        }
 			if category_find == "Potion" or category_find == "Enchant" or category_find == "XPPotion" or category_find == "Tower" then
				local inventorySubTables = {
					name = category_find , category = category_find
				}	
			end       
        for _, subTable in ipairs(inventorySubTables) do

            findInInventorySubTable(SaveData.Inventory[subTable.name],itemName, subTable.category,PT_find,SH_find,TN_find)
        end
    end

    -- In kết quả tìm thấy hoặc không
    if #itemsFound == 0 then
        warn("Khong tim thay vat pham nao voi ten chua '" .. tostring(itemName) .. "'")
    else
        warn("Danh sach tim thay:")
        for _, info in ipairs(itemsFound) do
            warn(
                "UID: " .. tostring(info.UID)
                .. " | ID: " .. tostring(info.ID)
                .. " | PT: " .. tostring(info.PT)
                .. " | SH: " .. tostring(info.SH)
                .. " | TN: " .. tostring(info.TN)
                .. " | SL: " .. tostring(info.Count)
                .. " | Category: " .. tostring(info.Category)  -- In thêm category
            )			

				local val1 = findValueByFields(
					info.Category, 
					info.ID,
					info.PT,
					info.SH,
					info.TN
				)
				warn("0")
				local valFinal = val1 or 0
				local priceRaw = item.Price
				warn("1")
				if type(priceRaw) == "number" then
					valFinal = priceRaw
				elseif type(priceRaw) == "string" then
					local percentMatch = priceRaw:match("^[+]?[%d%.]+%%$")
					if percentMatch then
						local sign = priceRaw:sub(1,1)
						local numberPart = tonumber(priceRaw:match("[%d%.]+"))
						if numberPart then
							if sign == "+" then
								valFinal = valFinal + (valFinal * numberPart / 100)
								valFinal = math.floor(valFinal) 
								warn(itemName .. ": Tang gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
							else
								valFinal = valFinal - (valFinal * numberPart / 100)
								valFinal = math.floor(valFinal) 
								warn(itemName .. ": Giam gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
							end
						else
							warn("Loi phan tich phan tram cua item: " .. itemName)
						end
					else
						local converted = convertStringPriceToNumber(priceRaw)
						if converted then
							valFinal = converted
							warn(itemName .. ": Chuyen chuoi '" .. tostring(priceRaw) .. "' thanh so: " .. tostring(valFinal))
						else
							warn(itemName .. ": Khong the chuyen doi gia: " .. tostring(priceRaw))
						end
					end
				end
					
					local ohString1 = tostring(info.UID)
					local ohNumber2 = valFinal or 0
					local ohNumber3 = tonumber(info.Count) or 1
					
					warn("Da tao listing "..info.ID..". UID : "..info.UID.." voi gia "..tostring(ohNumber2).." so luong "..tostring(ohNumber3))

					
					local so_du_sau_50k = 0
					while true do
						-- Kiểm tra nếu số lượng (ohNumber3) lớn hơn 50,000, chia thành từng phần 50,000
						if ohNumber3 > 50000 then
							so_du_sau_50k = ohNumber3 - 50000  -- Lưu lại phần dư sau khi trừ 50,000
							ohNumber3 = 50000  -- Cập nhật số lượng 50,000 để xử lý
						end
						
						-- Gửi yêu cầu tạo listing
						task.wait(1)
						game:GetService("ReplicatedStorage").Network.Booths_CreateListing:InvokeServer(
							ohString1,    -- ID vật phẩm
							ohNumber2,    -- Giá trị
							ohNumber3     -- Số lượng
						)
						
						-- Kiểm tra nếu vẫn còn phần dư sau 50,000
						task.wait(2)
						if so_du_sau_50k > 0 then
							-- Cập nhật lại số lượng còn lại
							ohNumber3 = so_du_sau_50k
							so_du_sau_50k = 0  -- Đặt lại phần dư sau khi xử lý
						else
							-- Nếu không còn phần dư, thoát vòng lặp
							break
						end
					end

					
					
					Tong_item_da_treo_quay = Tong_item_da_treo_quay + 1
					if Tong_item_da_treo_quay == 25 then 
						while true do							
							local X_slot = kiemtra_quayconslottreo()
							warn("slot : "..X_slot)
							
							if X_slot < 25 then
								Tong_item_da_treo_quay = X_slot
								break
							end
							task.wait(60)
						end
					end

			
        end
    end

    return itemsFound
end




function Kiem_tra_ten_co_them_tu_la_(itemName)
    local SH_find = nil
    local PT_find = nil
    local TN_find = nil    
    local category_find = nil
	
    -- Kiểm tra nếu itemName có từ "Shiny"
    if string.find(itemName, "Shiny") then
        SH_find = true
        itemName = string.gsub(itemName, "Shiny ", "") -- Loại bỏ từ "Shiny"
        warn("SH_find true")
    end

    -- Kiểm tra nếu itemName có từ "Golden"
    if string.find(itemName, "Golden") then
        PT_find = 1
        itemName = string.gsub(itemName, "Golden ", "") -- Loại bỏ từ "Golden"
        warn("PT_find 1")
    end

    -- Kiểm tra nếu itemName có từ "Rainbow"
    if string.find(itemName, "Rainbow") then
        PT_find = 2
        itemName = string.gsub(itemName, "Rainbow ", "") -- Loại bỏ từ "Rainbow"
        warn("PT_find 2")
    end

    -- Kiểm tra nếu itemName có từ "Shiny Golden"
    if string.find(itemName, "Shiny Golden") then
        SH_find = true
        PT_find = 1
        itemName = string.gsub(itemName, "Shiny Golden ", "") -- Loại bỏ từ "Shiny Golden"
        warn("PT_find 1 SH_find true")
    end

    -- Kiểm tra nếu itemName có từ "Shiny Rainbow"
    if string.find(itemName, "Shiny Rainbow") then
        SH_find = true
        PT_find = 2
        itemName = string.gsub(itemName, "Shiny Rainbow ", "") -- Loại bỏ từ "Shiny Rainbow"
        warn("PT_find 2 SH_find true")
    end

    -- Kiểm tra nếu itemName có từ "TNx"
    local tnMatch = itemName:match("TN(%d)")  -- Tìm kiếm "TN" kèm một số
    if tnMatch then
        TN_find = tonumber(tnMatch)  -- Gán giá trị của TN_find
        itemName = string.gsub(itemName, " TN%d", "")  -- Loại bỏ phần "TNx" khỏi itemName
    end

    -- Kiểm tra category
    if string.find(itemName, "Potion") then
        category_find = "Potion"
        itemName = string.gsub(itemName, "Potion ", "") -- Loại bỏ từ "Potion"
        warn("category Potion")
    end
    if string.find(itemName, "Enchant") then
        category_find = "Enchant"
        itemName = string.gsub(itemName, "Enchant ", "") -- Loại bỏ từ "Enchant"
        warn("category Enchant")
    end
	if string.find(itemName, "XPPotion") then
        category_find = "XPPotion"
        itemName = string.gsub(itemName, "XPPotion ", "") -- Loại bỏ từ "XPPotion"
        warn("category XPPotion")
    end

    -- Trả về tất cả các giá trị
    return itemName, SH_find, PT_find, TN_find, category_find
end

local function sell_item(itemName)

	local item = getgenv().Settings["Items"][itemName]
    if not item then
        warn("Khong tim thay item: " .. tostring(itemName))
        return
	else
		warn(tostring(itemName))
    end
	
	if string.find(itemName, "Tower") then
        category_find = "Tower"
        itemName = string.gsub(itemName, "Tower ", "") -- Loại bỏ từ "Tower"
        warn("category Tower")
		local SaveData = require(ReplicatedStorage.Library.Client.Save).Get()
        local Manager = {}

        function Manager:GetPets()
            local Huges = {}
            for uid, v in pairs(SaveData.Inventory.Tower) do
                if string.find(v.id, itemName) then
                    table.insert(Huges, {
                        UID = uid,
                        ID = v.id,                        
                        PT = v.pt,
						SH = v.sh
                    })
                end
            end
            return Huges
        end

        local hugesList = Manager:GetPets()
        if #hugesList == 0 then
            warn("Khong tim thay Tower co ID chua \"\"")
        else
            for _, info in ipairs(hugesList) do
                local val1 = findValueByFields(
                    "Tower",
                    info.ID,					
                    info.PT,  
					info.SH,		
                    nil
                )
                if val1 then
                    warn("Tower "..info.ID.." co value = "..tostring(val1))
                end

                -- Xử lý price
                local valFinal = val1
                local priceRaw = item.Price

                if type(priceRaw) == "number" then
                    valFinal = priceRaw
                elseif type(priceRaw) == "string" then
                    local percentMatch = priceRaw:match("^[+]?[%d%.]+%%$")
                    if percentMatch then
                        local sign = priceRaw:sub(1,1)
                        local numberPart = tonumber(priceRaw:match("[%d%.]+"))
                        if not numberPart then
                            warn("Loi phan tich phan tram cua item: " .. itemName)
                            return
                        end
                        if sign == "+" then
                            valFinal = valFinal + (valFinal * numberPart / 100)
							valFinal = math.floor(valFinal)
                            warn(itemName .. ": Tang gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
                        else
                            valFinal = valFinal - (valFinal * numberPart / 100)
							valFinal = math.floor(valFinal)
                            warn(itemName .. ": Giam gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
                        end
                    else
                        local converted = convertStringPriceToNumber(priceRaw)
                        if converted then
                            valFinal = converted
                            warn(itemName .. ": Chuyen chuoi '" .. tostring(priceRaw) .. "' thanh so: " .. tostring(valFinal))
                        else
                            warn(itemName .. ": Khong the chuyen doi gia: " .. tostring(priceRaw))
                            return
                        end
                    end
                end

                -- Treo bán trên booth
                local ohString1 = tostring(info.UID)
                local ohNumber2 = valFinal or 0
                local ohNumber3 = 1
				task.wait(1)
                game:GetService("ReplicatedStorage").Network.Booths_CreateListing:InvokeServer(
                    ohString1,
                    ohNumber2,
                    ohNumber3
                )
                warn("Da tao listing pet "..info.ID.." voi gia "..tostring(ohNumber2))
                task.wait(2)

                Tong_item_da_treo_quay = Tong_item_da_treo_quay + 1
                if Tong_item_da_treo_quay == 25 then 
					while true do
						
						local X_slot = kiemtra_quayconslottreo()
						warn("slot : "..X_slot)
						
						if X_slot < 25 then
							Tong_item_da_treo_quay = X_slot
							break
						end
						task.wait(60)
					end
				end
				
				
				
            end
        end
		
		
		
		
    end
	
    if itemName == "All Huges" then
        local SaveData = require(ReplicatedStorage.Library.Client.Save).Get()
        local Manager = {}

        function Manager:GetPets()
            local Huges = {}
            for uid, v in pairs(SaveData.Inventory.Pet) do
                if string.find(v.id, "Huge") then
                    table.insert(Huges, {
                        UID = uid,
                        ID = v.id,                        
                        PT = v.pt,
						SH = v.sh
                    })
                end
            end
            return Huges
        end

        local hugesList = Manager:GetPets()
        if #hugesList == 0 then
            warn("Khong tim thay pet co ID chua \"Huge\"")
        else
            for _, info in ipairs(hugesList) do
                local val1 = findValueByFields(
                    "Pet",
                    info.ID,					
                    info.PT,  
					info.SH,		
                    nil
                )
                if val1 then
                    warn("Pet "..info.ID.." co value = "..tostring(val1))
                end

                -- Xử lý price
                local valFinal = val1
                local priceRaw = item.Price
				local Min_sell = item.Min_sell
				local Max_sell = item.Max_sell
				
                if type(priceRaw) == "number" then
                    valFinal = priceRaw
                elseif type(priceRaw) == "string" then
                    local percentMatch = priceRaw:match("^[+]?[%d%.]+%%$")
                    if percentMatch then
                        local sign = priceRaw:sub(1,1)
                        local numberPart = tonumber(priceRaw:match("[%d%.]+"))
                        if not numberPart then
                            warn("Loi phan tich phan tram cua item: " .. itemName)
                            return
                        end
                        if sign == "+" then
                            valFinal = valFinal + (valFinal * numberPart / 100)
							valFinal = math.floor(valFinal)
                            warn(itemName .. ": Tang gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
                        else
                            valFinal = valFinal - (valFinal * numberPart / 100)
							valFinal = math.floor(valFinal)
                            warn(itemName .. ": Giam gia " .. tostring(numberPart) .. "%, gia moi: " .. tostring(valFinal))
                        end
                    else
                        local converted = convertStringPriceToNumber(priceRaw)
                        if converted then
                            valFinal = converted
                            warn(itemName .. ": Chuyen chuoi '" .. tostring(priceRaw) .. "' thanh so: " .. tostring(valFinal))
                        else
                            warn(itemName .. ": Khong the chuyen doi gia: " .. tostring(priceRaw))
                            return
                        end
                    end
                end
				
				if Min_sell ~= nil and Max_sell ~= nil then
					Min_sell = convertStringPriceToNumber(Min_sell)
					if Min_sell > valFinal then
						valFinal = Min_sell
					end
					Max_sell = convertStringPriceToNumber(Max_sell)
					if Max_sell < valFinal then
						valFinal = Max_sell
					end
				end				

				
                -- Treo bán trên booth
                local ohString1 = tostring(info.UID)
                local ohNumber2 = valFinal or 0
                local ohNumber3 = 1
				task.wait(1)
                game:GetService("ReplicatedStorage").Network.Booths_CreateListing:InvokeServer(
                    ohString1,
                    ohNumber2,
                    ohNumber3
                )
                warn("Da tao listing pet "..info.ID.." voi gia "..tostring(ohNumber2))
                task.wait(2)

                Tong_item_da_treo_quay = Tong_item_da_treo_quay + 1
                if Tong_item_da_treo_quay == 25 then 
					while true do
						
						local X_slot = kiemtra_quayconslottreo()
						warn("slot : "..X_slot)
						
						if X_slot < 25 then
							Tong_item_da_treo_quay = X_slot
							break
						end
						task.wait(60)
					end
				end
				
				
				
            end
        end
    end

	if itemName ~= "All Huges" then

		local itemsFound = Manager:GetItemsByName(itemName)

	end

end

local function sell_all_items()
    local priority_items = {}
    local normal_items = {}

    -- Phân loại các item vào priority_items hoặc normal_items
    for itemName, itemData in pairs(getgenv().Settings["Items"]) do
        if itemData.Priority then
            table.insert(priority_items, itemName)
        else
            table.insert(normal_items, itemName)
        end
    end

    -- Bán các item ưu tiên trước
    for _, itemName in ipairs(priority_items) do
        sell_item(itemName)
    end

    -- Bán các item còn lại
    for _, itemName in ipairs(normal_items) do
        sell_item(itemName)
    end
end







-- ================== PHẦN 5: CHẠY TOÀN BỘ ==================
-- 1. Tìm booth trống, dịch chuyển, claim

if getgenv().Settings.xoa_Map then
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
    -- thực thi khi xoa_Map được bật
	if workspace:FindFirstChild("__THINGS") and workspace.__THINGS:FindFirstChild("Booths") then
		for _, child in ipairs(workspace.__THINGS.Booths:GetChildren()) do
			child:Destroy()
		end
	end
	local vipParts = Workspace:FindFirstChild("TradingPlaza") and Workspace.TradingPlaza:FindFirstChild("VIP Parts")
	if vipParts then
		vipParts:Destroy()
	end

	-- Xóa INTERACT nếu tồn tại
	local interact = Workspace:FindFirstChild("TradingPlaza") and Workspace.TradingPlaza:FindFirstChild("INTERACT")
	if interact then
		interact:Destroy()
	end
	
	
	
	local parts = workspace:WaitForChild("TradingPlaza"):WaitForChild("Parts")
	-- 🧹 Xoá mọi phần tử con có tên "Waterfall"
	for _, part in ipairs(parts:GetDescendants()) do
		if part.Name == "Waterfall" then
			warn("🗑️ Destroying:", part:GetFullName())
			part:Destroy()
		end
	end


	-- 🛑 Ẩn toàn bộ map (trừ Camera, Terrain, Player)
	local function hideMap()
		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") then
				obj.Transparency = 1
				obj.CastShadow = false
			elseif obj:IsA("Decal") or obj:IsA("Texture") then
				obj.Transparency = 1
			end
		end
	end

	hideMap()
	
	local function hideOtherPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    part.CanCollide = false
                elseif part:IsA("Decal") or part:IsA("Texture") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                    part.Handle.Transparency = 1
                end
            end
        end
    end
end
	
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.wait(1)
			hideOtherPlayers()
		end)
	end)
	
end


local boothID, spawnPoint = findUnusedBoothID()
if not boothID or not spawnPoint then
    warn("Da ngung: Khong co boothID hoac spawnPoint hop le\n")
else
    local teleported = teleportToSpawnPoint(spawnPoint)
    if teleported then
        claimBoothByID(boothID)
    else
        warn("Khong the teleport, bo qua claim\n")
    end
end


if getgenv().Settings.xoa_Map then
    -- thực thi khi xoa_Map được bật
	if workspace:FindFirstChild("TradingPlaza") and workspace.TradingPlaza:FindFirstChild("BoothSpawns") then
		for _, child in ipairs(workspace.TradingPlaza.BoothSpawns:GetChildren()) do
			child:Destroy()
		end
	end
end


-- Chạy bán tất cả
local VirtualInputManager = game:GetService("VirtualInputManager")
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.1)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)



sell_all_items()
