-- ARD HUB v2 - Full Features Blox Fruits GUI (Mobile-Friendly, Black Theme)
-- Author: Ard0122 | Inspired by Redz Hub
-- Features: Auto Farm, Sea Beast, Mirage, Skull Guitar, Bones, Quest, Tool Selector, Teleport, More

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    lp.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- UI LIBRARY
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "🟥 ARD HUB | Blox Fruits", HidePremium = false, SaveConfig = true, ConfigFolder = "ARDHUB"})

-- VARIABLES
local autofarm = false
local autofarmNearest = false
local autoSkullGuitar = false
local autoSeaBeast = false
local autoMirage = false
local autoBones = false
local autoKillReaper = false
local walkSpeedEnabled = false

-- TOOLS TAB
local toolTab = Window:MakeTab({Name = "Tools", Icon = "rbxassetid://6031260786", PremiumOnly = false})
toolTab:AddDropdown({
    Name = "Select Tool",
    Default = "Melee",
    Options = {"Melee", "Sword", "Gun", "Fruit"},
    Callback = function(val)
        local inv = lp.Backpack:GetChildren()
        for _,v in pairs(inv) do
            if v:IsA("Tool") and v.ToolTip == val then
                lp.Character.Humanoid:EquipTool(v)
            end
        end
    end
})

-- FARM TAB
local farmTab = Window:MakeTab({Name = "Farm", Icon = "rbxassetid://6031071058", PremiumOnly = false})

farmTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(v)
        autofarm = v
        while autofarm do
            task.wait()
            pcall(function()
                -- Quest + Attack logic here (basic)
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,-3,2)
                        ReplicatedStorage.Remotes.Combat:FireServer("Attack", true)
                        task.wait(0.2)
                    end
                end
            end)
        end
    end
})

farmTab:AddToggle({
    Name = "Auto Farm Nearest",
    Default = false,
    Callback = function(v)
        autofarmNearest = v
        while autofarmNearest do
            task.wait()
            pcall(function()
                for _,v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,-3,2)
                        ReplicatedStorage.Remotes.Combat:FireServer("Attack", true)
                        task.wait(0.2)
                    end
                end
            end)
        end
    end
})

farmTab:AddToggle({
    Name = "Auto Skull Guitar",
    Default = false,
    Callback = function(v)
        autoSkullGuitar = v
        while autoSkullGuitar do
            task.wait(0.3)
            pcall(function()
                ReplicatedStorage.Remotes.Combat:FireServer("SkullGuitarAttack")
            end)
        end
    end
})

-- BONES TAB
local bonesTab = Window:MakeTab({Name = "Bones", Icon = "rbxassetid://6031071059", PremiumOnly = false})

bonesTab:AddToggle({
    Name = "Auto Farm Bones",
    Default = false,
    Callback = function(v)
        autoBones = v
        -- Tambahkan logika farming bones dari monster event
    end
})

bonesTab:AddToggle({
    Name = "Auto Kill Soul Reaper",
    Default = false,
    Callback = function(v)
        autoKillReaper = v
        -- Tambahkan logic lokasi & serang soul reaper boss
    end
})

-- SEA TAB
local seaTab = Window:MakeTab({Name = "Sea", Icon = "rbxassetid://6031071053", PremiumOnly = false})

seaTab:AddToggle({
    Name = "Auto Farm Sea Beast",
    Default = false,
    Callback = function(v)
        autoSeaBeast = v
        while autoSeaBeast do
            task.wait()
            -- Tambahkan logika deteksi + serang Sea Beast
        end
    end
})

seaTab:AddToggle({
    Name = "Auto Mirage Island Hop",
    Default = false,
    Callback = function(v)
        autoMirage = v
        while autoMirage do
            task.wait(15)
            -- Hop server atau teleport ke Mirage Island
        end
    end
})

-- MISC TAB
local miscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://6034509993", PremiumOnly = false})

miscTab:AddButton({
    Name = "WalkSpeed Boost",
    Callback = function()
        local h = lp.Character and lp.Character:FindFirstChild("Humanoid")
        if h then h.WalkSpeed = (h.WalkSpeed == 16 and 60 or 16) end
    end
})

miscTab:AddToggle({
    Name = "Auto Haki",
    Default = false,
    Callback = function(v)
        -- aktifkan haki saat menyerang
    end
})

OrionLib:Init()
print("[ARD HUB Loaded]")
