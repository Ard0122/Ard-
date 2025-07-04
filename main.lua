-- main.luau (Redz Hub Style with Settings support)
local Settings = Settings or {
    JoinTeam = "Pirates",
    Translator = true
}

-- Auto Join Team
if Settings.JoinTeam == "Pirates" or Settings.JoinTeam == "Marines" then
    local args = {
        [1] = "SetTeam",
        [2] = Settings.JoinTeam
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

-- Translator mode (contoh fitur aktif)
if Settings.Translator then
    print("Translator aktif!")
    -- Tambah fitur translatormu di sini
end
