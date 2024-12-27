-- Load the EnhancedTweenUtility module
local TweenUtility = require(game:GetService("ReplicatedStorage"):WaitForChild("EnhancedTweenUtility"))

-- Enable Debugging
TweenUtility.DebugEnabled = true -- do false for no output information

-- Create the test part
local function createTestPart()
	local part = Instance.new("Part")
	part.Size = Vector3.new(4, 4, 4)
	part.Position = Vector3.new(0, 5, 0)
	part.Anchored = true
	part.BrickColor = BrickColor.new("Bright yellow")
	part.Parent = workspace
	return part
end

-- Create a simple UI for testing
local function createControlPanel()
	local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))

	local function createButton(text, position, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 150, 0, 50)
		button.Position = position
		button.Text = text
		button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Font = Enum.Font.SourceSans
		button.TextSize = 20
		button.Parent = screenGui

		button.MouseButton1Click:Connect(callback)
		return button
	end

	return screenGui, createButton
end

-- Main test function
local function testTweens()
	local testPart = createTestPart()
	local screenGui, createButton = createControlPanel()

	-- Tween Examples
	local function basicTween()
		local tweenInfo = TweenUtility:CreateTweenInfo(2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
		local properties = {Position = Vector3.new(0, 10, 0), Color = Color3.fromRGB(0, 255, 0)}
		TweenUtility:Tween(testPart, tweenInfo, properties, function()
			print("Basic tween finished!")
		end)
	end

	local function chainedTweens()
		local chain = {
			{
				instance = testPart,
				tweenInfo = TweenUtility:CreateTweenInfo(1, Enum.EasingStyle.Linear),
				properties = {Position = Vector3.new(-10, 5, 0)},
			},
			{
				instance = testPart,
				tweenInfo = TweenUtility:CreateTweenInfo(1, Enum.EasingStyle.Linear),
				properties = {Size = Vector3.new(6, 6, 6)},
			},
			{
				instance = testPart,
				tweenInfo = TweenUtility:CreateTweenInfo(1, Enum.EasingStyle.Linear),
				properties = {Color = Color3.fromRGB(255, 0, 0)},
			},
		}
		TweenUtility:ChainTweens(chain)
	end

	local function cancelTween()
		local tweenInfo = TweenUtility:CreateTweenInfo(5, Enum.EasingStyle.Linear)
		local properties = {Position = Vector3.new(10, 5, 0)}

		print("Starting a long-running tween...")
		TweenUtility:Tween(testPart, tweenInfo, properties)

		task.delay(2, function()
			print("Attempting to cancel the tween...")
			TweenUtility:CancelTween(testPart)
		end)
	end

	-- Buttons for testing
	createButton("Basic Tween", UDim2.new(0, 10, 0, 10), basicTween)
	createButton("Chain Tweens", UDim2.new(0, 10, 0, 70), chainedTweens)
	createButton("Cancel Tween", UDim2.new(0, 10, 0, 130), cancelTween)
end

-- Run the test
testTweens()
