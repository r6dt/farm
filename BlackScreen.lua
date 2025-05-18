local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlackScreenGui"
screenGui.Parent = playerGui

-- Create a black Frame that covers the entire screen and is larger than the edges
local blackFrame = Instance.new("Frame")
blackFrame.Size = UDim2.new(1.5, 0, 1.5, 0) -- 1.5 times the screen size
blackFrame.Position = UDim2.new(-0.25, 0, -0.25, 0) -- Centered and expanded
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0) -- Black color
blackFrame.BorderSizePixel = 0 -- No border
blackFrame.BackgroundTransparency = 0 -- Fully opaque
blackFrame.Parent = screenGui

-- Define unwanted messages in a table for easier management
local unwantedMessages = {
    "Cannot fit unit here!",
    "voted to play 'Retry'",
    "You need more yen",
    "Not Enough Money",
    "You need more YEN", -- For messages like "You need ... ¥ more to place this unit"
    "You can only place 6 of this unit", -- Previously added message
    "Unit has reached max upgrade" -- New message added
}

-- Function to check if a message is unwanted
local function isUnwantedMessage(text)
    for _, message in ipairs(unwantedMessages) do
        if text:find(message) then
            return true
        end
    end
    return false
end

-- Function to remove unwanted messages
local function removeMessages()
    -- Loop through all GUI elements and remove the specified text and their backgrounds
    for _, guiObject in ipairs(playerGui:GetDescendants()) do
        if guiObject:IsA("TextLabel") and isUnwantedMessage(guiObject.Text) then
            -- Check if it has a parent Frame or other container, and remove it
            local parentFrame = guiObject.Parent
            if parentFrame:IsA("Frame") then
                parentFrame:Destroy() -- Remove the frame with the text
            else
                guiObject:Destroy() -- Remove just the text label
            end
        end
    end
end

-- Continuously check for unwanted messages every 0.1 seconds
while true do
    removeMessages() -- Call the function to remove the messages
    wait(0.1) -- Wait for 0.1 seconds before running again
end

-- Jump functionality
local player = game.Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- Function to simulate user activity
local function onIdled()
    -- Capture the controller to prevent being kicked
    VirtualUser:CaptureController()
    -- Simulate a mouse click
    VirtualUser:ClickButton2(Vector2.new())
end

-- Connect the Idled event to the onIdled function
player.Idled:Connect(onIdled)
