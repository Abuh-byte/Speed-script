local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Abuh-Byte/Speed-script/main/speed-roblox-script.Lua")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- References to GUI elements
local screenGui = script.Parent
local barFrame = screenGui:WaitForChild("BarFrame") -- Replace with the actual name of the frame
local continueButton = screenGui:WaitForChild("ContinueButton") -- Replace with the actual name of the button
local speedLabel = screenGui:WaitForChild("SpeedLabel") -- Replace with the actual name of the text label

local barWidth = barFrame.AbsoluteSize.X
local minSpeed = 16 -- Default walking speed
local maxSpeed = 100

local function updateSpeed()
    local mousePosition = game.Players.LocalPlayer:GetMouse().X
    local relativePosition = math.clamp((mousePosition - barFrame.AbsolutePosition.X) / barWidth, 0, 1)
    local speed = math.floor(minSpeed + (maxSpeed - minSpeed) * relativePosition)

    -- Update the label text to show the selected speed
    speedLabel.Text = "Speed: " .. speed

    return speed
end

-- Adjust the speed as the player drags the mouse across the bar
barFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local speed = updateSpeed()
        barFrame.InputChanged:Connect(updateSpeed)
    end
end)

-- Apply the selected speed when the "Continue" button is clicked
continueButton.MouseButton1Click:Connect(function()
    local selectedSpeed = updateSpeed()
    humanoid.WalkSpeed = selectedSpeed
    print("Player speed changed to: " .. selectedSpeed)
end)
