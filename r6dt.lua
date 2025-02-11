getgenv().KiTTYWARE = {
    ["Optimize"] = true, -- optimize game
    ["GuiStats"] = true, -- "stats in a gui duh" - Nazov 2024

    ["UseTowerBoosts"] = true, -- uses tower boosts
    ["OpenLoveGifts"] = true, -- auto opens love gifts
    ["CraftLoveGifts"] = true, -- auto crafts love gifts
    ["HatchBestEgg"] = true, -- teleports to and hatches best egg available

    ["Timeouts"] = {
        ["TycoonLoadingTimeout"] = 30, -- time to wait for tycoon to load before server hopping
        ["EggHatchTimeout"] = 120, -- time to wait to find egg before server hopping
    },

    ["Mail"] = {
        ["Mailing"] = true, -- auto mail
        ["LoveGiftAmount"] = 50, -- amount of love gifts needed before mailing (0 to disable mailing of gifts)
        ["Username"] = "zigsua", -- username to mail new huges to
    },

    ["Webhook"] = {
        ["WebhookURL"] = "https://discord.com/api/webhooks/1338698467786096681/c6A3Zp5vjJLkK09TzZN9nRSO-MU_X8o66BPg_giDcVA2M7emA_VwmEruhS0aOvpQGDeP", -- webhook url
        ["DiscordId"] = "" -- will @ you
    }
}
script_key="wGBALsgnVctWLWLFobHGUonyhAXQTGkM";
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/27ec6b1cff94c4a33d30c81cbc3e11ec.lua"))()
