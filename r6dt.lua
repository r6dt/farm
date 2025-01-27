repeat wait(10) until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/r6dt/farm/main/Del-CoreGui.lua"))()
wait(10)
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GDO_CANNON_TYCOON_EVENT = true
_G.GCANNON_TYCOON_FPS = 5
_G.GCONVERT_HELLFIRE_CRYSTALS = true
_G.GHATCH_CHARGED_EGGS = true
_G.GHOLD_GIFTS = false
_G.GHOLD_BUNDLES = false
_G.GGFX_MODE = 1
_G.GZONE_TO = 999
_G.GENCHANTS = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Coins", "Fortune", "Strong Pets"}
_G.GWEBHOOK_USERID = "" -- your discord userID, not your name. numerical id.
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1330044667114291303/dDUp-QKB4KPghtF5s22-WVvQOlJ8xd1m8-kCJgOD848pEM9gOrEdd1ZhrCTkSrveWVTv" -- a webhook URL from your private discord channel.
_G.GMAIL_RECEIVERS = {"zigsua"}  -- an account to receive hatched Huges etc
_G.GLOOTBOXES = {"Locked Hype Egg"}
_G.GMAIL_ITEMS = {
  ["All Huges"] = {Class = "Pet", Id = "All Huges", Amount = 1},
  ["Hype Egg 2 "] = {Class = "Lootbox", Id = "Hype Egg 2", MinAmount = 1},
  ["Hype Egg"] = {Class = "Lootbox", Id = "Hype Egg", MinAmount = 1},
  ["Hellfire Gifts"] = {Class = "Lootbox", Id = "Hellfire Gift", MinAmount = 100},
  ["Send all Diamonds"] = {Class = "Currency", Id = "Diamonds", MinAmount = "50m"},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
  ["Normal Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 50},
  ["Golden Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 25, IsGold = true},
  ["RB Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 10, IsRainbow = true},
  ["Shiny Normal Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 1, IsShiny = true},
  ["Shiny Golden Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 1, IsGold = true, IsShiny = true},
  ["Shiny RB Fireball Cat"] = {Class = "Pet", Id = "Fireball Cat", MinAmount = 1, IsRainbow = true, IsShiny = true},
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/gscripts.lua"))()
