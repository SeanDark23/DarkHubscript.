local DarkHub = {}

function DarkHub.Notify(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "DarkHub Notification";
        Text = message;
        Duration = 5;
    })
end

function DarkHub.SetLevel(level)
    local player = game.Players.LocalPlayer
    if player:FindFirstChild("leaderstats") then
        local stat = player.leaderstats:FindFirstChild("Level")
        if stat then
            stat.Value = level
            DarkHub.Notify("Level set to " .. level)
        else
            DarkHub.Notify("Level stat not found")
        end
    end
end

function DarkHub.SetMoney(amount)
    local player = game.Players.LocalPlayer
    if player:FindFirstChild("leaderstats") then
        local stat = player.leaderstats:FindFirstChild("Money")
        if stat then
            stat.Value = amount
            DarkHub.Notify("Money set to " .. amount)
        else
            DarkHub.Notify("Money stat not found")
        end
    end
end

function DarkHub.AutoFish()
    local player = game.Players.LocalPlayer
    local spot = workspace:FindFirstChild("FishingSpot")
    if spot then
        while true do
            player.Character:MoveTo(spot.Position)
            wait(2)
            print("Fishing...")
            wait(5)
        end
    else
        DarkHub.Notify("Fishing spot not found")
    end
end

function DarkHub.TeleportTo(pos)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character.PrimaryPart then
        player.Character:SetPrimaryPartCFrame(CFrame.new(pos))
        DarkHub.Notify("Teleported to " .. tostring(pos))
    else
        DarkHub.Notify("Could not teleport")
    end
end

DarkHub.Notify("DarkHub loaded!")
DarkHub.SetLevel(50)
DarkHub.SetMoney(1000)
DarkHub.AutoFish()
DarkHub.TeleportTo(Vector3.new(100, 50, 200))
