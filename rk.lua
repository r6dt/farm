repeat wait(10) until game:IsLoaded()
script_key = "ipXBywOqWcuQMMEBBCmVrvDBXrSRfJLd";
_G.GPROGRESS_MODE = "Hybrid"
_G.GGFX_MODE = 1
_G.GRANK_TO = 99
_G.GZONE_TO = 999
_G.GHATCH_SPEED_MS = 0
_G.GWAIT_AT_GATES_TILL_RANK = 5
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
