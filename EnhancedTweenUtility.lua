local TweenService = game:GetService("TweenService")

local EnhancedTweenUtility = {}

-- Global Debugging Toggle
EnhancedTweenUtility.DebugEnabled = false -- do true if you want to see output information

-- Store active tweens for cancellation
EnhancedTweenUtility.ActiveTweens = {}

-- Function to create and play a tween
function EnhancedTweenUtility:Tween(instance, tweenInfo, properties, callback)
	assert(typeof(instance) == "Instance", "Instance must be a valid Roblox object.")
	assert(typeof(tweenInfo) == "TweenInfo", "tweenInfo must be a TweenInfo object.")
	assert(typeof(properties) == "table", "Properties must be a table.")

	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()

	if self.DebugEnabled then
		print("Tween started for:", instance:GetFullName(), "Properties:", properties)
	end

	tween.Completed:Connect(function()
		if callback then callback() end
		if self.DebugEnabled then
			print("Tween completed for:", instance:GetFullName())
		end
	end)

	-- Store the tween for cancellation
	self.ActiveTweens[instance] = tween
	return tween
end

-- Function to create chained tweens
function EnhancedTweenUtility:ChainTweens(tweenChain)
	local function playNext(index)
		if index > #tweenChain then return end
		local tweenData = tweenChain[index]
		self:Tween(tweenData.instance, tweenData.tweenInfo, tweenData.properties, function()
			playNext(index + 1)
		end)
	end

	playNext(1)
end

-- Function to cancel an active tween
function EnhancedTweenUtility:CancelTween(instance)
	if self.ActiveTweens[instance] then
		self.ActiveTweens[instance]:Cancel()
		self.ActiveTweens[instance] = nil
		if self.DebugEnabled then
			print("Tween canceled for:", instance:GetFullName())
		end
	else
		if self.DebugEnabled then
			print("No active tween found for:", instance:GetFullName())
		end
	end
end

-- Function to create TweenInfo
function EnhancedTweenUtility:CreateTweenInfo(duration, easingStyle, easingDirection, repeatCount, reverses, delayTime)
	return TweenInfo.new(
		duration or 1,
		easingStyle or Enum.EasingStyle.Linear,
		easingDirection or Enum.EasingDirection.Out,
		repeatCount or 0,
		reverses or false,
		delayTime or 0
	)
end

-- Preview easing styles (prints easing style and direction effects in the output)
function EnhancedTweenUtility:PreviewEasingStyles()
	for _, style in ipairs(Enum.EasingStyle:GetEnumItems()) do
		for _, direction in ipairs(Enum.EasingDirection:GetEnumItems()) do
			if self.DebugEnabled then
				print("EasingStyle:", style.Name, "EasingDirection:", direction.Name)
			end
		end
	end
end

return EnhancedTweenUtility