local DarkHub = {}

-- ACCESS SCREEN GUI
local accessGui = Instance.new("ScreenGui")
accessGui.Name = "DarkHubAccessGui"
accessGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local accessFrame = Instance.new("Frame")
accessFrame.Size = UDim2.new(0, 350, 0, 250)
accessFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
accessFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Yellow background
accessFrame.Parent = accessGui

-- Fish background image
local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.Image = "rbxassetid://INSERT_IMAGE_ID_HERE" -- replace with your image ID
backgroundImage.BackgroundTransparency = 1
backgroundImage.ImageTransparency = 0.3
backgroundImage.ZIndex = 0
backgroundImage.Parent = accessFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "DarkHub Access Required"
title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24
title.ZIndex = 1
title.Parent = accessFrame

local instruction = Instance.new("TextLabel")
instruction.Size = UDim2.new(1, -20, 0, 80)
instruction.Position = UDim2.new(0, 10, 0, 50)
instruction.BackgroundTransparency = 1
instruction.TextWrapped = true
instruction.Text = "Click below to access DarkHub."
instruction.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow text
instruction.Font = Enum.Font.SourceSans
instruction.TextSize = 18
instruction.ZIndex = 1
instruction.Parent = accessFrame

local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0.6, 0, 0, 40)
confirmButton.Position = UDim2.new(0.2, 0, 1, -60)
confirmButton.Text = "Access DarkHub"
confirmButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red button
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow text
confirmButton.Font = Enum.Font.SourceSansBold
confirmButton.TextSize = 20
confirmButton.ZIndex = 1
confirmButton.Parent = accessFrame

function loadMainDarkHubGui()
    accessFrame:Destroy()

    local gui = Instance.new("ScreenGui")
    gui.Name = "DarkHubGui"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 480)
    frame.Position = UDim2.new(0.5, -175, 0.5, -240)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black background
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "DarkHub"
    title.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red text
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 24
    title.Parent = frame

    local function createButton(name, yPos, callback)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -20, 0, 30)
        button.Position = UDim2.new(0, 10, 0, yPos)
        button.Text = name
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Yellow button
        button.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text
        button.Font = Enum.Font.SourceSans
        button.TextSize = 18
        button.Parent = frame
        button.MouseButton1Click:Connect(callback)
    end

    local autoFishEnabled = false
    local infiniteJumpEnabled = false
    local followEnabled = false

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

    createButton("Toggle Auto Fish", 40, function() DarkHub.ToggleAutoFish() end)
    createButton("Toggle Infinite Jump", 80, function() DarkHub.ToggleInfiniteJump() end)
    createButton("Toggle AutoFollow 1423_matt", 120, function() DarkHub.ToggleAutoFollow() end)

    DarkHub.Notify("DarkHub Loaded (ForgeHub Style)")
end

function DarkHub.Notify(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "DarkHub Notification";
        Text = message;
        Duration = 4;
    })
end

confirmButton.MouseButton1Click:Connect(function()
    -- No need to check for following anymore, so we directly load the DarkHub GUI
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Granted",
        Text = "Welcome to DarkHub!",
        Duration = 5;
    })
    loadMainDarkHubGui()
end)
