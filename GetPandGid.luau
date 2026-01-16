local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CopyInfoUI"
ScreenGui.Parent = PlayerGui
ScreenGui.DisplayOrder = 100
ScreenGui.ResetOnSpawn = false

local ButtonFrame = Instance.new("Frame")
ButtonFrame.Name = "ButtonContainer"
ButtonFrame.Size = UDim2.new(0, 300, 0, 140)
ButtonFrame.Position = UDim2.new(0.5, -150, 0.1, 0)
ButtonFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ButtonFrame.BackgroundTransparency = 0.3
ButtonFrame.BorderSizePixel = 0
ButtonFrame.Active = true
ButtonFrame.Draggable = true
ButtonFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = ButtonFrame

local ControlFrame = Instance.new("Frame")
ControlFrame.Name = "ControlFrame"
ControlFrame.Size = UDim2.new(1, 0, 0, 30)
ControlFrame.Position = UDim2.new(0, 0, 0, 0)
ControlFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ControlFrame.BackgroundTransparency = 0.2
ControlFrame.Parent = ButtonFrame

local ControlCorner = Instance.new("UICorner")
ControlCorner.CornerRadius = UDim.new(0, 10)
ControlCorner.Parent = ControlFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = ControlFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.Parent = ControlFrame

local function CreateCopyButton(text, position, parent)
	local Button = Instance.new("TextButton")
	Button.Name = "Copy" .. text
	Button.Size = UDim2.new(0.9, 0, 0, 45)
	Button.Position = position
	Button.BackgroundColor3 = Color3.fromRGB(60, 120, 216)
	Button.BorderSizePixel = 0
	Button.Parent = parent

	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 8)
	ButtonCorner.Parent = Button

	local ButtonText = Instance.new("TextLabel")
	ButtonText.Size = UDim2.new(1, 0, 1, 0)
	ButtonText.BackgroundTransparency = 1
	ButtonText.Text = "复制" .. text
	ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
	ButtonText.Font = Enum.Font.SourceSansBold
	ButtonText.TextSize = 16
	ButtonText.Parent = Button

	return Button
end

local CopyPositionButton = CreateCopyButton("位置信息", UDim2.new(0.05, 0, 0.3, 0), ButtonFrame)
local CopyGameIDButton = CreateCopyButton("游戏ID", UDim2.new(0.05, 0, 0.65, 0), ButtonFrame)

local function ShowNotification(message, isSuccess)
	StarterGui:SetCore("SendNotification", {
		Title = "复制工具",
		Text = message,
		Duration = 2,
		Icon = isSuccess and "rbxassetid://10717640757" or "rbxassetid://10717641023"
	})
end

local isMinimized = false

CopyPositionButton.MouseButton1Click:Connect(function()
	local Character = LocalPlayer.Character
	if not Character then
		ShowNotification("角色未加载！", false)
		return
	end
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then
		ShowNotification("无法获取位置！", false)
		return
	end
	local pos = HumanoidRootPart.Position
	local positionText = string.format("X=%.8f,Y=%.8f,Z=%.8f", pos.X, pos.Y, pos.Z)
	setclipboard(positionText)
	ShowNotification("高精度位置已复制！", true)
end)

CopyGameIDButton.MouseButton1Click:Connect(function()
	local placeId = tostring(game.PlaceId)
	if placeId == "0" then
		ShowNotification("无法获取游戏ID！", false)
		return
	end
	setclipboard(placeId)
	ShowNotification("游戏ID已复制！", true)
end)

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	ShowNotification("UI已关闭！", true)
end)

MinimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		CopyPositionButton.Visible = false
		CopyGameIDButton.Visible = false
		ButtonFrame.Size = UDim2.new(0, 120, 0, 30)
		MinimizeButton.Text = "+"
	else
		CopyPositionButton.Visible = true
		CopyGameIDButton.Visible = true
		ButtonFrame.Size = UDim2.new(0, 300, 0, 140)
		MinimizeButton.Text = "−"
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F3 then
		ButtonFrame.Visible = not ButtonFrame.Visible
	end
end)
