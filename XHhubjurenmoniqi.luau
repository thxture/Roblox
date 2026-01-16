local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/thxture/Roblox/refs/heads/main/WindUI.lua"))()
local Window = WindUI:CreateWindow({
	Title = "DIX <font color='#02FF70'>HUB</font>  <font color='#0F0F70'>2026</font>",
	Icon = "rbxassetid://87735686608986",
	IconTransparency = 5,
	IconThemed = true,
	Author = "欢迎使用",
	Folder = "CloudHub",
	Size = UDim2.fromOffset(400, 300),
	Transparent = true,
	Theme = "Dark",
	User = {
		Enabled = true,
		Callback = function() print("clicked") end,
		Anonymous = false
	},
	SideBarWidth = 200,
	ScrollBarEnabled = true,
	Background = "rbxassetid://81503152709972"
})

WindUI:Notify({
	Title = "受支持的服务器!",
	Content = "当前服务器:巨人模拟器",
	Duration = 5
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer

local function getCurrentSpeed()
	local character = localPlayer.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			return humanoid.WalkSpeed
		end
	end
	return 16
end


local currentSpeed = getCurrentSpeed()
local currentGravity = Workspace.Gravity

local function updateWalkSpeed(speed)
	currentSpeed = speed
	local character = localPlayer.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = speed
		end
	end
end

local function updateGravity(gravity)
	currentGravity = gravity
	Workspace.Gravity = gravity
end

local function applyCharacterStats(character)
	task.wait(0.5)
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = currentSpeed
	end
end

localPlayer.CharacterAdded:Connect(applyCharacterStats)

local character = localPlayer.Character
if character then
	applyCharacterStats(character)
end


Window:EditOpenButton({
	Title = "XH HUB",
	Icon = "monitor",
	CornerRadius = UDim.new(0, 8),
	StrokeThickness = 1,
	Draggable = true,
})

local MainTab = Window:Tab({
	Title = "关于XH HUB",
	Icon = "zap",
	Locked = false,
})

MainTab:Paragraph({
	Title = "Made By ThxTure",
	Desc = "XH HUB 2026",
})

MainTab:Paragraph({
	Title = "QQ群",
	Desc = "群号:892445242",
	ImageSize = 20,
	Color = "Grey",
	Buttons = {
		{
			Title = "点击复制Q群",
			Icon = "copy",
			Variant = "Tertiary",
			Callback = function()
				setclipboard("892445242")
				WindUI:Notify({
					Title = "已复制",
					Content = "已复制到剪贴板",
					Duration = 3
				})
			end
		}
	}
})

MainTab:Paragraph({
	Title = "支持的服务器:",
	Desc = "巨人模拟器",
})

local Tab = Window:Tab({
	Title = "通用",
	Icon = "drama",
	Locked = false,
})

Tab:Button({
	Title = "飞行1",
	Default = true,
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/fly.lua"))()
		WindUI:Notify({
			Title = "飞行",
			Content = "已开启 注:此飞行无绕过",
			Duration = 3
		})
	end
})

Tab:Button({
	Title = "反挂机踢出",
	Default = true,
	Callback = function()
		local vu = game:GetService("VirtualUser")
		game:GetService("Players").LocalPlayer.Idled:connect(function()
			vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			wait(1)
			vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end)
		print("OK")
		WindUI:Notify({
			Title = "反挂机踢出",
			Content = "已开启 反挂机踢出",
			Duration = 3
		})
	end
})

Tab:Slider({
	Title = "速度调整",
	Value = {
		Min = 16,
		Max = 500,
		Default = 16,
	},
	Increment = 1,
	Callback = function(value)
		updateWalkSpeed(value)
	end
})

Tab:Slider({
	Title = "重力调整",
	Value = {
		Min = 0.001,
		Max = 1000,
		Default = currentGravity,
	},
	Increment = 1,
	Callback = function(value)
		updateGravity(value)
	end
})

local Tab = Window:Tab({
	Title = "主要功能",
	Icon = "drama",
	Locked = false,
})

MainTab:Paragraph({
	Title = "刷怪区",
	Desc = nil,
})

local snowmanRunning = false
local attackDuration = 3.5

Tab:Toggle({
	Title = "刷雪人",
	Default = false,
	Callback = function(value)
		snowmanRunning = value
		if value then
			coroutine.wrap(function()
				local Players = game:GetService("Players")
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				local RunService = game:GetService("RunService")

				local lp = Players.LocalPlayer
				local attack = ReplicatedStorage.Aero.AeroRemoteServices.GameService.WeaponAttackStart
				local anim = ReplicatedStorage.Aero.AeroRemoteServices.GameService.WeaponAnimComplete
				local hrp

				local function getHRP()
					if not hrp or not hrp.Parent then
						local c = lp.Character or lp.CharacterAdded:Wait()
						hrp = c:WaitForChild("HumanoidRootPart")
					end
					return hrp
				end

				local function waitForSnowmen()
					while #workspace.TechBoxes:GetChildren() == 0 do
						RunService.Heartbeat:Wait()
					end
				end

				local function attackSequence()
					local root = getHRP()

					local special = workspace.TechBoxes:FindFirstChild("TechBox")
					if special and special:IsDescendantOf(workspace) then
						local start = tick()
						while tick() - start < attackDuration and special:IsDescendantOf(workspace) and snowmanRunning do
							root.CFrame = special.CFrame * CFrame.new(0, 0, 3)
							attack:FireServer()
							anim:FireServer()
							RunService.Heartbeat:Wait()
						end
					end

					for i = 2, 15 do
						local snowman = workspace.TechBoxes:GetChildren()[i]
						if snowman and snowman:IsDescendantOf(workspace) then
							local start = tick()
							while tick() - start < attackDuration and snowman:IsDescendantOf(workspace) and snowmanRunning do
								root.CFrame = snowman.CFrame * CFrame.new(0, 0, 3)
								attack:FireServer()
								anim:FireServer()
								RunService.Heartbeat:Wait()
							end
						end
					end
				end

				while snowmanRunning do
					waitForSnowmen()
					attackSequence()
					RunService.Heartbeat:Wait()
				end
			end)()
		end
	end
})

Tab:Slider({
	Title = "刷雪人时间",
	Value = {
		Min = 2,
		Max = 10,
		Default = 3.5,
	},
	Increment = 0.1,
	Callback = function(value)
		attackDuration = value
	end
})

local swordLoopRunning = false

local function startSwordLoop()
	swordLoopRunning = true
	coroutine.wrap(function()
		local attack = game:GetService("ReplicatedStorage"):WaitForChild("Aero"):WaitForChild("AeroRemoteServices"):WaitForChild("GameService"):WaitForChild("WeaponAttackStart")
		local anim = game:GetService("ReplicatedStorage"):WaitForChild("Aero"):WaitForChild("AeroRemoteServices"):WaitForChild("GameService"):WaitForChild("WeaponAnimComplete")

		while swordLoopRunning do
			attack:FireServer()
			anim:FireServer()
			task.wait(0.1)
		end
	end)()
end

local function stopSwordLoop()
	swordLoopRunning = false
end

Tab:Toggle({
	Title = "自动挥剑",
	Default = false,
	Callback = function(value)
		if value then
			startSwordLoop()
		else
			stopSwordLoop()
		end
	end
})

MainTab:Paragraph({
	Title = "传送区",
	Desc = "done",
})

Tab:Button({
	Title = "传送至 出生点 ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(61.23952103,-256.52297974,-410.02697754)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 出生点",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 活动世界1 ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(17434.75781250,865.40350342,-9312.77636719)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 活动世界1",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = nil,
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 活动世界2 ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(6717.80371094,259.03393555,-1688.87048340)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 活动世界2",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 TEMPLE ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(2756.65063477,243.95176697,-1248.38928223)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 TEMPLE",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 BOSS LAIR ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(2065.21997070,-239.74232483,2342.31494141)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 BOSS LAIR",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 CYBER CITY ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(11047.40429688,675.74871826,-1923.48327637)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 CYBER CITY",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})
Tab:Button({
	Title = "传送至 EGYPT ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(14477.83398438,-34.20671463,-2187.63549805)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 EGYPT",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

Tab:Button({
	Title = "传送至 MAYAN ",
	Default = true,
	Callback = function()
		local localPlayer = game:GetService("Players").LocalPlayer
		local character = localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local targetPosition = Vector3.new(19772.05078125,-38.86917496,-1613.31176758)
				humanoidRootPart.CFrame = CFrame.new(targetPosition)

				WindUI:Notify({
					Title = "传送",
					Content = "已传送到 MAYAN",
					Duration = 3
				})
			else
				WindUI:Notify({
					Title = "传送失败",
					Content = "nil",
					Duration = 3
				})
			end
		else
			WindUI:Notify({
				Title = "传送失败",
				Content = "nil",
				Duration = 3
			})
		end
	end
})

local Tab2 = Window:Tab({
	Title = "开发者工具",
	Icon = "drama",
	Locked = false,
})

Tab2:Button({
	Title = "Infinite Yield",
	Default = true,
	Callback = function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-yield-reborn-83505"))()
		WindUI:Notify({
			Title = "Infinite Yield",
			Content = "已开启 Infinite Yield",
			Duration = 3
		})
	end
})

Tab2:Button({
	Title = "DEX++",
	Default = true,
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Twbtx/tiamxiabuwu/main/txbw%20dex%2B%2B%20huan%20huan%20HUN%20NB%21"))()
		WindUI:Notify({
			Title = "DEX++",
			Content = "已开启 DEX++",
			Duration = 3
		})
	end
})

Tab2:Button({
	Title = "辅助工具",
	Default = false,
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/thxture/Roblox/refs/heads/main/GetPandGid.luau"))()
		WindUI:Notify({
			Title = "辅助工具",
			Content = "已开启 辅助工具",
			Duration = 3
		})
	end
})