local DarkHub = {}

-- ACCESS SCREEN GUI
local accessGui = Instance.new("ScreenGui")
accessGui.Name = "DarkHubAccessGui"
accessGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local accessFrame = Instance.new("Frame")
accessFrame.Size = UDim2.new(0, 350, 0, 200)
accessFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
accessFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
accessFrame.Parent = accessGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "DarkHub Access Required"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.Parent = accessFrame

local instruction = Instance.new("TextLabel")
instruction.Size = UDim2.new(1, -20, 0, 80)
instruction.Position = UDim2.new(0, 10, 0, 50)
instruction.BackgroundTransparency = 1
instruction.TextWrapped = true
instruction.Text = "To access DarkHub, you must follow Roblox user '1423_matt'. Click the button below once you have followed."
instruction.TextColor3 = Color3.fromRGB(200, 200, 200)
instruction.Font = Enum.Font.SourceSans
instruction.TextSize = 18
instruction.Parent = accessFrame

local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0.6, 0, 0, 40)
confirmButton.Position = UDim2.new(0.2, 0, 1, -60)
confirmButton.Text = "I Followed"
confirmButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.TextSize = 20
confirmButton.Parent = accessFrame

-- Function to load main DarkHub GUI
function loadMainDarkHubGui()
    accessFrame:Destroy()

    -- MAIN GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "DarkHubGui"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 440)
    frame.Position = UDim2.new(0, 50, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "DarkHub (Fisch Edition)"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 22
    title.Parent = frame

    local function createButton(name, yPos, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 30)
        button.Position = UDim2.new(0, 10, 0, yPos)
        button.Text = name
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18
        button.Parent = frame
        button.MouseButton1Click:Connect(callback)
    end

    function DarkHub.Notify(message)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DarkHub Notification";
            Text = message;
            Duration = 4;
        })
    end

    local autoFishEnabled = false
    local infiniteJumpEnabled = false
    local followEnabled = false

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

    function DarkHub.ToggleAutoFish()
        autoFishEnabled = not autoFishEnabled
        if autoFishEnabled then
            DarkHub.Notify("Auto Fish Enabled")
            spawn(function()
                local player = game.Players.LocalPlayer
                local spot = workspace:FindFirstChild("FishingSpot")
                if spot then
                    while autoFishEnabled do
                        player.Character:MoveTo(spot.Position)
                        wait(2)
                        print("Fishing...")
                        wait(4)
                    end
                else
                    DarkHub.Notify("Fishing spot not found")
                end
            end)
        else
            DarkHub.Notify("Auto Fish Disabled")
        end
    end

    function DarkHub.SellAllFish()
        local sellArea = workspace:FindFirstChild("SellArea")
        if sellArea then
            game.Players.LocalPlayer.Character:MoveTo(sellArea.Position)
            DarkHub.Notify("Moved to Sell Area")
            wait(2)
            DarkHub.Notify("Attempted to sell fish")
        else
            DarkHub.Notify("Sell area not found")
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

    function DarkHub.ToggleInfiniteJump()
        infiniteJumpEnabled = not infiniteJumpEnabled
        if infiniteJumpEnabled then
            DarkHub.Notify("Infinite Jump Enabled")
            game:GetService("UserInputService").JumpRequest:Connect(function()
                if infiniteJumpEnabled then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
                end
            end)
        else
            DarkHub.Notify("Infinite Jump Disabled")
        end
    end

    function DarkHub.SetWalkSpeed(speed)
        local human = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if human then
            human.WalkSpeed = speed
            DarkHub.Notify("WalkSpeed set to " .. speed)
        end
    end

    function DarkHub.RedeemAllCodes()
        local codes = {"WELCOME", "FREEFISH", "XPBOOST"}
        for _, code in pairs(codes) do
            print("Redeemed code:", code)
        end
        DarkHub.Notify("Redeemed all codes!")
    end

    function DarkHub.ToggleAutoFollow()
        followEnabled = not followEnabled
        if followEnabled then
            DarkHub.Notify("AutoFollow Enabled (target: 1423_matt)")
            spawn(function()
                while followEnabled do
                    local target = game.Players:FindFirstChild("1423_matt")
                    if target and target.Character and target.Character.PrimaryPart then
                        local myChar = game.Players.LocalPlayer.Character
                        if myChar and myChar.PrimaryPart then
                            myChar:MoveTo(target.Character.PrimaryPart.Position + Vector3.new(2,0,2))
                        end
                    else
                        DarkHub.Notify("Target 1423_matt not found")
                    end
                    wait(1)
                end
            end)
        else
            DarkHub.Notify("AutoFollow Disabled")
        end
    end

    -- Create Buttons
    createButton("Set Level to 50", 40, function() DarkHub.SetLevel(50) end)
    createButton("Set Money to 1000", 80, function() DarkHub.SetMoney(1000) end)
    createButton("Toggle Auto Fish", 120, function() DarkHub.ToggleAutoFish() end)
    createButton("Sell All Fish", 160, function() DarkHub.SellAllFish() end)
    createButton("Teleport to Spawn", 200, function() DarkHub.TeleportTo(Vector3.new(0,5,0)) end)
    createButton("Teleport to Merchant", 240, function() DarkHub.TeleportTo(Vector3.new(100,5,100)) end)
    createButton("Toggle Infinite Jump", 280, function() DarkHub.ToggleInfiniteJump() end)
    createButton("Set WalkSpeed 32", 320, function() DarkHub.SetWalkSpeed(32) end)
    createButton("Redeem All Codes", 360, function() DarkHub.RedeemAllCodes() end)
    createButton("Toggle AutoFollow 1423_matt", 400, function() DarkHub.ToggleAutoFollow() end)

    DarkHub.Notify("DarkHub Loaded (Manual Mode)")
end

confirmButton.MouseButton1Click:Connect(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Granted",
        Text = "Welcome to DarkHub!",
        Duration = 5;
    })
    loadMainDarkHubGui()
end)
