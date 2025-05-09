local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- RemoteEvent
local vipEvent = ReplicatedStorage:WaitForChild("VipAnimation")

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DanceUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Draggable Frame
local dragFrame = Instance.new("Frame")
dragFrame.Size = UDim2.new(0, 320, 0, 200)
dragFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
dragFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
dragFrame.BorderSizePixel = 0
dragFrame.Active = true
dragFrame.Draggable = true
dragFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = dragFrame

-- Title Label
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Emotes"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = dragFrame

-- Emotes Container
local danceFrame = Instance.new("Frame")
danceFrame.Size = UDim2.new(1, -16, 1, -40)
danceFrame.Position = UDim2.new(0, 8, 0, 32)
danceFrame.BackgroundTransparency = 1
danceFrame.Parent = dragFrame

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -28, 0, 4)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = dragFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Credit Label
local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0, 20)
creditLabel.Position = UDim2.new(0, 0, 1, -28)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "Credits: Gab"
creditLabel.Font = Enum.Font.Gotham
creditLabel.TextSize = 12
creditLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
creditLabel.TextStrokeTransparency = 0.8
creditLabel.Parent = dragFrame

-- Emote Button Logic
local currentTrack = nil
local currentButton = nil

local function createEmoteButton(buttonName, animationId, col, row)
	local button = Instance.new("TextButton")
	button.Name = buttonName
	button.Size = UDim2.new(0.48, 0, 0, 30)
	button.Position = UDim2.new(col, 0, 0, row * 35)
	button.Text = buttonName
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.Parent = danceFrame

	local cornerButton = Instance.new("UICorner")
	cornerButton.CornerRadius = UDim.new(0, 6)
	cornerButton.Parent = button

	button.MouseButton1Click:Connect(function()
		if currentTrack then
			currentTrack:Stop()
			vipEvent:FireServer("DanceStop")

			if currentButton then
				currentButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				currentButton.Text = currentButton.Name
			end

			if currentButton == button then
				currentTrack = nil
				currentButton = nil
				return
			end
		end

		local animation = Instance.new("Animation")
		animation.AnimationId = animationId
		currentTrack = humanoid:LoadAnimation(animation)
		currentTrack.Priority = Enum.AnimationPriority.Action
		currentTrack:Play()

		vipEvent:FireServer("DanceStart")
		button.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
		button.Text = "Stop"

		currentButton = button
	end)
end

-- Add Emote Buttons
createEmoteButton("Cheer", "rbxassetid://507770677", 0, 0)
createEmoteButton("Dance1", "rbxassetid://507776043", 0.52, 0)
createEmoteButton("Dance3", "rbxassetid://507777268", 0, 1)
createEmoteButton("Wave", "rbxassetid://507770239", 0.52, 1)
createEmoteButton("Laugh", "rbxassetid://507770818", 0, 2)
