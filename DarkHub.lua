local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- DarkHub ScreenGui Setup with Realistic Effects
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "DarkHub"

-- Main Frame with Gradient and Shadow
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 600, 0, 600)
Frame.Position = UDim2.new(0.5, -300, 0.5, -300)
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BorderRadius = UDim.new(0, 20)
Frame.Visible = false -- Initially hidden

-- Gradient Background for Frame
local gradient = Instance.new("UIGradient", Frame)
gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))})

-- Drop Shadow Effect
local shadow = Instance.new("Frame", Frame)
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, 5, 0, 5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.BorderSizePixel = 0
shadow.BorderRadius = UDim.new(0, 20)

-- Title Bar with Gradient
local titleBar = Instance.new("Frame", Frame)
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.BorderRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "DarkHub - Fish Events"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center

-- Sidebar Navigation with Hover Effects
local sidebar = Instance.new("Frame", Frame)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
sidebar.BorderRadius = UDim.new(0, 20)

-- Function to create navigation buttons with click effect
local function createNavButton(text, position, callback)
    local button = Instance.new("TextButton", sidebar)
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = position
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.TextButton1Click = callback

    -- Hover effects for button
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    -- Click effect: Shrink and revert back
    button.MouseButton1Down:Connect(function()
        -- Shrink the button and change color briefly
        button:TweenSize(UDim2.new(1, -10, 0, 45), "Out", "Quad", 0.1, true)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    button.MouseButton1Up:Connect(function()
        -- Revert back to original size and color
        button:TweenSize(UDim2.new(1, 0, 0, 50), "Out", "Quad", 0.1, true)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

createNavButton("Fish Events", UDim2.new(0, 0, 0, 60), function() 
    eventMenu.Visible = not eventMenu.Visible
end)

-- Close Button with Animation
local closeButton = Instance.new("TextButton", Frame)
closeButton.Size = UDim2.new(0, 60, 0, 60)
closeButton.Position = UDim2.new(1, -70, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 24
closeButton.BorderRadius = UDim.new(0, 10)
closeButton.MouseButton1Click:Connect(function()
    Frame.Visible = false  -- Hide the entire GUI
end)

-- Open Button to Show the Menu
local openButton = Instance.new("TextButton", player.PlayerGui)
openButton.Size = UDim2.new(0, 120, 0, 60)
openButton.Position = UDim2.new(0, 10, 0.5, -30)
openButton.Text = "Open DarkHub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.Font = Enum.Font.SourceSans
openButton.TextSize = 20
openButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
end)

-- Event Menu Frame
local eventMenu = Instance.new("Frame", Frame)
eventMenu.Size = UDim2.new(1, -150, 1, -60)
eventMenu.Position = UDim2.new(0, 150, 0, 60)
eventMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
eventMenu.BorderSizePixel = 0
eventMenu.BorderRadius = UDim.new(0, 20)
eventMenu.Visible = false

-- Title for Event Menu with Gradient
local eventTitle = Instance.new("TextLabel", eventMenu)
eventTitle.Size = UDim2.new(1, 0, 0, 50)
eventTitle.Position = UDim2.new(0, 0, 0, 0)
eventTitle.Text = "Select Fish Event"
eventTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
eventTitle.BackgroundTransparency = 1
eventTitle.Font = Enum.Font.GothamBold
eventTitle.TextSize = 22

-- Function to create event buttons with click effect
local function createEventButton(eventName, posY, eventLocation, eventAction)
    local button = Instance.new("TextButton", eventMenu)
    button.Size = UDim2.new(1, -10, 0, 50)
    button.Position = UDim2.new(0, 5, 0, posY)
    button.Text = "Join " .. eventName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18

    -- Click effect: Shrink and revert back
    button.MouseButton1Down:Connect(function()
        button:TweenSize(UDim2.new(1, -10, 0, 45), "Out", "Quad", 0.1, true)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)

    button.MouseButton1Up:Connect(function()
        button:TweenSize(UDim2.new(1, 0, 0, 50), "Out", "Quad", 0.1, true)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    -- Event action when button is clicked
    button.MouseButton1Click:Connect(function()
        player.Character:SetPrimaryPartCFrame(eventLocation.CFrame)
        eventAction()
        print("Joined " .. eventName)
    end)
end

-- Create event buttons dynamically
-- Example of creating an event button
createEventButton("Whale Migration", 40, workspace.WhaleMigration, startWhaleMigrationEvent)
