# EnhancedTweenUtility

EnhancedTweenUtility is a Roblox Lua module designed to simplify and extend the functionality of the Roblox `TweenService`. This utility provides an easy-to-use API for creating, chaining, managing, and canceling tweens. It also includes debugging features and tools for visualizing easing styles, making it perfect for both simple animations and complex, dynamic workflows.

---

## Features
- **Centralized Tween Management**: Keep track of active tweens for easy cancellation and control.
- **Chained Tweens**: Create sequences of animations effortlessly.
- **Tween Cancellation**: Cancel tweens dynamically without disrupting your game flow.
- **Global Debugging Toggle**: Debug your tweens with detailed logs for better understanding and troubleshooting.
- **Simplified `TweenInfo` Creation**: Create `TweenInfo` objects with sensible defaults in a single line.
- **Easing Style Preview**: Experiment with easing styles to find the perfect animation behavior.

---

## Installation
1. Clone or download this repository.
2. Place the `EnhancedTweenUtility` module into `ReplicatedStorage` in your Roblox project.
3. Require the module in your scripts:
   ```lua
   local TweenUtility = require(game:GetService("ReplicatedStorage").EnhancedTweenUtility)
   ```

---

## API Reference

### **Tween(instance, tweenInfo, properties, callback)**
Creates and plays a tween.

- **Parameters**:
  - `instance` (*Instance*): The object to tween.
  - `tweenInfo` (*TweenInfo*): The `TweenInfo` object defining the animation.
  - `properties` (*table*): A table of properties to animate.
  - `callback` (*function*, optional): A function to call when the tween completes.

- **Example**:
  ```lua
  local tweenInfo = TweenUtility:CreateTweenInfo(2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
  local properties = {Position = Vector3.new(0, 10, 0), Color = Color3.fromRGB(255, 0, 0)}
  TweenUtility:Tween(part, tweenInfo, properties, function()
      print("Tween complete!")
  end)
  ```

---

### **ChainTweens(tweenChain)**
Plays a sequence of tweens in order.

- **Parameters**:
  - `tweenChain` (*table*): An array of tween data, where each entry contains `instance`, `tweenInfo`, and `properties`.

- **Example**:
  ```lua
  local chain = {
      {
          instance = part,
          tweenInfo = TweenUtility:CreateTweenInfo(1, Enum.EasingStyle.Linear),
          properties = {Position = Vector3.new(10, 5, 0)},
      },
      {
          instance = part,
          tweenInfo = TweenUtility:CreateTweenInfo(1, Enum.EasingStyle.Linear),
          properties = {Size = Vector3.new(6, 6, 6)},
      },
  }
  TweenUtility:ChainTweens(chain)
  ```

---

### **CancelTween(instance)**
Cancels an active tween for a specific instance.

- **Parameters**:
  - `instance` (*Instance*): The object whose tween you want to cancel.

- **Example**:
  ```lua
  TweenUtility:CancelTween(part)
  ```

---

### **CreateTweenInfo(duration, easingStyle, easingDirection, repeatCount, reverses, delayTime)**
Generates a `TweenInfo` object with default or specified parameters.

- **Parameters**:
  - `duration` (*number*): Length of the animation.
  - `easingStyle` (*Enum.EasingStyle*): Style of easing (default: `Enum.EasingStyle.Linear`).
  - `easingDirection` (*Enum.EasingDirection*): Direction of easing (default: `Enum.EasingDirection.Out`).
  - `repeatCount` (*number*): Number of repeats (default: 0).
  - `reverses` (*boolean*): Whether the tween reverses (default: false).
  - `delayTime` (*number*): Delay before starting (default: 0).

- **Example**:
  ```lua
  local tweenInfo = TweenUtility:CreateTweenInfo(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
  ```

---

### **PreviewEasingStyles()**
Prints all available easing styles and directions to the output for experimentation.

- **Example**:
  ```lua
  TweenUtility:PreviewEasingStyles()
  ```

---

## Testing the Module
A test script is included to demonstrate the module's functionality interactively. It features a UI with buttons to:
- Run a basic tween.
- Chain multiple tweens.
- Cancel an active tween.

### **How to Test**
1. Place the test script into `StarterPlayerScripts`.
2. Run the game in Play mode.
3. Use the on-screen buttons to trigger different tween scenarios.

---

## Contributing
Contributions are welcome! Feel free to submit pull requests or open issues for bug fixes, feature requests, or general improvements.

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

