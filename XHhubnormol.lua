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
    Title = " 暂未支持当前服务器",
    Content = "只加载基本功能",
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
    Default = true,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thxture/Roblox/refs/heads/main/GetPandGid.luau"))()
        WindUI:Notify({
            Title = "辅助工具",
            Content = "已开启 辅助工具",
            Duration = 3
        })
    end
})
