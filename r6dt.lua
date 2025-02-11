repeat wait(10) until game:IsLoaded()
getgenv().KiTTYWARE = {
    ["Optimize"] = true,
    ["GuiStats"] = true, -- "stats in a gui duh" - Nazov 2024
    
    ["TycoonLoadingTimeout"] = 20, -- time to wait for tycoon to load before server hopping
    ["EggHatchTimeout"] = 30, -- time to wait to find egg before server hopping

    ["CraftGifts"] = true, -- auto crafts love gifts
    ["HatchBestEgg"] = true, -- teleports to and hatches best egg available

    ["Mailing"] = false,
    ["LoveGiftAmount"] = 0, -- amount of love gifts needed before mailing (0 to disable mailing of gifts)
    ["Username"] = "", -- username to mail new huges to

    ["Webhook"] = "https://discord.com/api/webhooks/1338698467786096681/c6A3Zp5vjJLkK09TzZN9nRSO-MU_X8o66BPg_giDcVA2M7emA_VwmEruhS0aOvpQGDeP",
    ["DiscordId"] = "" -- will @ you
}
script_key="wGBALsgnVctWLWLFobHGUonyhAXQTGkM";
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b5d2645e8868be24e57409c6fe4669c.lua"))()
