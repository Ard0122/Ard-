-- ✅ Script by Ard0122 (Redz Hub Style)
local Settings = Settings or {
    JoinTeam = "Pirates", -- atau "Marines"
    Translator = true
}

-- 🔹 Auto Join Team
if Settings.JoinTeam == "Pirates" or Settings.JoinTeam == "Marines" then
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", Settings.JoinTeam)
    end)
end

-- 🔹 Translator Mode
if Settings.Translator then
    print("[✔️] Translator aktif!")
end

-- 💤 Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end)

-- 💻 GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ArdGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 230, 0, 350)
Frame.Position = UDim2.new(0, 10, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local function makeButton(text, order, func)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 210, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, 10 + (order * 35))
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(func)
end

-- ⚡ Auto Click
local autoClick = false
makeButton("Toggle Auto Click", 0, function()
    autoClick = not autoClick
    task.spawn(function()
        while autoClick do
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
            task.wait(0.01)
        end
    end)
end)

-- ⚔️ Auto Farm
local autoFarm = false
makeButton("Toggle Auto Farm", 1, function()
    autoFarm = not autoFarm
    task.spawn(function()
        while autoFarm do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Attack", true)
            end)
            task.wait(0.15)
        end
    end)
end)

-- 🎸 Skull Guitar Skill Spam
local autoGuitar = false
makeButton("Auto Skull Guitar", 2, function()
    autoGuitar = not autoGuitar
    task.spawn(function()
        while autoGuitar do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("SkullGuitarAttack")
            end)
            task.wait(0.3)
        end
    end)
end)

-- ⚡ Attack Speed (1-Hit Style)
makeButton("Enable Attack Speed", 3, function()
    pcall(function()
        local human = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if human then
            human.WalkSpeed = 100
            human.JumpPower = 100
        end
    end)
end)

-- 🏃‍♂️ Speed Boost
makeButton("Speed x2 Toggle", 4, function()
    local human = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if human then
        human.WalkSpeed = (human.WalkSpeed == 16) and 60 or 16
    end
end)

-- 🚪 GUI Toggle
makeButton("Toggle GUI", 5, function()
    Frame.Visible = not Frame.Visible
end)
