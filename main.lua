-- ARD HUB - Manual GUI Version (No OrionLib, Fully Mobile Support)

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local rs = game:GetService("ReplicatedStorage")

-- Anti-AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    plr.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ARDHUB_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 310)
frame.Position = UDim2.new(0.02, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "🟥 ARD HUB"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

local y = 35
function makeBtn(text, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(callback)
    y = y + 35
end

-- Toggles
local autoFarm = false
local autoNearest = false
local autoGuitar = false

makeBtn("Auto Farm Level", function()
    autoFarm = not autoFarm
    makeBtn("Auto Farm Level ["..(autoFarm and "ON" or "OFF").."]", function() end)
    task.spawn(function()
        while autoFarm do
            pcall(function()
                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, -3, 2)
                        rs.Remotes.Combat:FireServer("Attack", true)
                        task.wait(0.25)
                    end
                end
            end)
            task.wait(0.3)
        end
    end)
end)

makeBtn("Auto Farm Nearest", function()
    autoNearest = not autoNearest
    makeBtn("Auto Farm Nearest ["..(autoNearest and "ON" or "OFF").."]", function() end)
    task.spawn(function()
        while autoNearest do
            pcall(function()
                for _,mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, -3, 2)
                        rs.Remotes.Combat:FireServer("Attack", true)
                        task.wait(0.25)
                    end
                end
            end)
            task.wait(0.3)
        end
    end)
end)

makeBtn("Auto Skull Guitar", function()
    autoGuitar = not autoGuitar
    makeBtn("Auto Skull Guitar ["..(autoGuitar and "ON" or "OFF").."]", function() end)
    task.spawn(function()
        while autoGuitar do
            rs.Remotes.Combat:FireServer("SkullGuitarAttack")
            task.wait(0.3)
        end
    end)
end)

makeBtn("Speed Boost", function()
    local hum = plr.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = hum.WalkSpeed == 16 and 60 or 16
    end
end)

makeBtn("Toggle GUI", function()
    frame.Visible = not frame.Visible
end)
