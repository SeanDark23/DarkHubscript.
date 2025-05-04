-- DarkHub Fish Event System Script (Hide/Show GUI)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- DarkHub ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "DarkHub"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 500, 0, 500)
Frame.Position = UDim2.new(0.5, -250, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BorderRadius = UDim.new(0, 10)
Frame.Visible = false -- Initially hidden

local titleBar = Instance.new("Frame", Frame)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleBar.BorderSizePixel = 0
titleBar.BorderRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "DarkHub - Fish Events"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center

-- Sidebar for Navigation
local sidebar = Instance.new("Frame", Frame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
sidebar.BorderRadius = UDim.new(0, 10)

local eventButton = Instance.new("TextButton", sidebar)
eventButton.Size = UDim2.new(1, 0, 0, 40)
eventButton.Position = UDim2.new(0, 0, 0, 60)
eventButton.Text = "Fish Events"
eventButton.TextColor3 = Color3.fromRGB(255, 255, 255)
eventButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
eventButton.Font = Enum.Font.SourceSans
eventButton.TextSize = 18
eventButton.TextButton1Click = function() 
    -- Toggle visibility of the event menu
    eventMenu.Visible = not eventMenu.Visible
end

-- Close Button to hide the menu
local closeButton = Instance.new("TextButton", Frame)
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(1, -60, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.MouseButton1Click:Connect(function()
    Frame.Visible = false  -- Hide the entire GUI
end)

-- Open Button to show the menu
local openButton = Instance.new("TextButton", player.PlayerGui)
openButton.Size = UDim2.new(0, 100, 0, 50)
openButton.Position = UDim2.new(0, 10, 0.5, -25)
openButton.Text = "Open DarkHub"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.Font = Enum.Font.SourceSans
openButton.TextSize = 18
openButton.MouseButton1Click:Connect(function()
    Frame.Visible = true  -- Show the entire GUI
end)

-- Content Frame for Fish Event Menu
local eventMenu = Instance.new("Frame", Frame)
eventMenu.Size = UDim2.new(1, -120, 1, -50)
eventMenu.Position = UDim2.new(0, 120, 0, 50)
eventMenu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
eventMenu.BorderSizePixel = 0
eventMenu.BorderRadius = UDim.new(0, 10)
eventMenu.Visible = false -- Initially hidden

-- Title for Event Menu
local eventTitle = Instance.new("TextLabel", eventMenu)
eventTitle.Size = UDim2.new(1, 0, 0, 40)
eventTitle.Position = UDim2.new(0, 0, 0, 0)
eventTitle.Text = "Select Fish Event"
eventTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
eventTitle.BackgroundTransparency = 1
eventTitle.Font = Enum.Font.GothamBold
eventTitle.TextSize = 20

-- Function to create event buttons
local function createEventButton(eventName, posY, eventLocation, eventAction)
    local button = Instance.new("TextButton", eventMenu)
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, posY)
    button.Text = "Join " .. eventName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16

    -- Event action when button is clicked
    button.MouseButton1Click:Connect(function()
        player.Character:SetPrimaryPartCFrame(eventLocation.CFrame)
        eventAction()
        print("Joined " .. eventName)
    end)
end

-- Define events (with unique event locations, actions, and rewards)
local events = {
    {name = "Whale Migration", location = workspace.WhaleMigration, action = startWhaleMigrationEvent, reward = "WhaleScale"},
    {name = "Rare Fish Spawn", location = workspace.RareFishSpawn, action = startRareFishEvent, reward = "GoldenFish"},
    {name = "Shark Hunt", location = workspace.SharkHunt, action = startSharkHuntEvent, reward = "SharkTooth"},
    {name = "Treasure Hunt", location = workspace.TreasureHunt, action = startTreasureHuntEvent, reward = "TreasureChest"},
    {name = "Fish Frenzy", location = workspace.FishFrenzy, action = startFishFrenzyEvent, reward = "FishBait"},
    {name = "Ocean Cleanup", location = workspace.OceanCleanup, action = startOceanCleanupEvent, reward = "CleanerKit"},
}

-- Create buttons for each event dynamically
for i, event in ipairs(events) do
    createEventButton(event.name, 40 + (i - 1) * 50, event.location, event.action)
end

-- Event Logic for Whale Migration (with reward)
local function startWhaleMigrationEvent()
    print("Whale Migration Event Started!")
    -- Example: Spawning whales or spawning rare fish
    local whale = Instance.new("Part")
    whale.Size = Vector3.new(10, 5, 20)
    whale.Position = workspace.WhaleMigration.Position + Vector3.new(0, 10, 0)
    whale.Anchored = true
    whale.Parent = workspace

    -- Reward the player
    rewardPlayer("WhaleScale")
end

-- Event Logic for Rare Fish Spawn (with reward)
local function startRareFishEvent()
    print("Rare Fish Spawn Event Started!")
    local rareFish = Instance.new("Part")
    rareFish.Size = Vector3.new(2, 1, 2)
    rareFish.Position = workspace.RareFishSpawn.Position + Vector3.new(0, 5, 0)
    rareFish.Anchored = true
    rareFish.Parent = workspace

    -- Reward the player
    rewardPlayer("GoldenFish")
end

-- Event Logic for Shark Hunt (with reward)
local function startSharkHuntEvent()
    print("Shark Hunt Event Started!")
    local shark = Instance.new("Part")
    shark.Size = Vector3.new(5, 3, 10)
    shark.Position = workspace.SharkHunt.Position + Vector3.new(0, 5, 0)
    shark.Anchored = true
    shark.Parent = workspace

    -- Reward the player
    rewardPlayer("SharkTooth")
end

-- Event Logic for Treasure Hunt (with reward)
local function startTreasureHuntEvent()
    print("Treasure Hunt Event Started!")
    local treasureChest = Instance.new("Part")
    treasureChest.Size = Vector3.new(4, 4, 4)
    treasureChest.Position = workspace.TreasureHunt.Position + Vector3.new(0, 5, 0)
    treasureChest.Anchored = true
    treasureChest.Parent = workspace

    -- Reward the player
    rewardPlayer("TreasureChest")
end

-- Event Logic for Fish Frenzy (with reward)
local function startFishFrenzyEvent()
    print("Fish Frenzy Event Started!")
    for i = 1, 5 do
        local fish = Instance.new("Part")
        fish.Size = Vector3.new(2, 1, 2)
        fish.Position = workspace.FishFrenzy.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
        fish.Anchored = true
        fish.Parent = workspace
    end

    -- Reward the player
    rewardPlayer("FishBait")
end

-- Event Logic for Ocean Cleanup (with reward)
local function startOceanCleanupEvent()
    print("Ocean Cleanup Event Started!")
    local trash = Instance.new("Part")
    trash.Size = Vector3.new(1, 1, 1)
    trash.Position = workspace.OceanCleanup.Position + Vector3.new(0, 5, 0)
    trash.Anchored = true
    trash.Parent = workspace

    -- Reward the player
    rewardPlayer("CleanerKit")
end

-- Reward Logic for Players
local function rewardPlayer(item)
    local inventory = player.Backpack -- Modify as per game inventory
    local reward = Instance.new("Tool")
    reward.Name = item
    reward.Parent = inventory
    print(player.Name .. " received " .. item)
end
