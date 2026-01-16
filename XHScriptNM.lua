--这个脚本的只有基础功能 
local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "XH Script",
    Text = "loading...",
    Duration = 5
})

print("Anti AFK")

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

CoreGui:SetCore("SendNotification", {
    Title = "XH Script",
    Text = "反挂机Anti-AFK 已开启",
    Duration = 4
})

CoreGui:SetCore("SendNotification", {
    Title = "XH Script",
    Text = "未在游戏ID池里找到对应的\n只加载基础功能 ",
    Duration = 6
})

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/nainshu/no/main/ori.lua'))()

local Window = OrionLib:MakeWindow({Name = "XH Script", HidePremium = false, SaveConfig = true, IntroText = "XH Script", ConfigFolder = "XH Script"})

local about = Window:MakeTab({
    Name = "关于",
    Icon = "rbxassetid://104249998363078",
    PremiumOnly = false
})

about:AddParagraph("您的用户名:", " "..game.Players.LocalPlayer.Name.."")

about:AddParagraph("您的注入器:", " "..identifyexecutor().."")

about:AddParagraph("您当前服务器的ID", " "..game.GameId.."")

local function getBeijingTime()
    local utcTime = os.time()
    local beijingTime = utcTime + 8 * 3600
    return os.date("%Y-%m-%d %H:%M:%S", beijingTime)
end

about:AddParagraph("当前北京时间", " " .. getBeijingTime() .. "")

about:AddParagraph("XH Script\nMade By Thre")

local Tab = Window:MakeTab({
  Name = "通用",
  Icon = "rbxassetid://104249998363078",
  PremiumOnly = false
  })
  
  Tab:AddButton({
	Name = "飞行",
	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/nainshu/no/main/fly.lua"))()

end
})


Tab:AddButton({
	Name = "翻译",
	Callback = function()
	
loadstring(loadstring("local CoreGui = game:GetService("StarterGui")
CoreGui:SetCore("SendNotification", {
    Title = "TX Script",
    Text = "TX公益系列",
    Icon = "rbxassetid://82031063194606",
    Duration = 6, 
})
CoreGui:SetCore("SendNotification", {
    Title = "正在加载",
    Text = "自动翻译",
    Icon = "rbxassetid://82031063194606",
    Duration = 6, 
})
loadstring(game:HttpGet("https://pastefy.app/TbI0vupa/raw"))()")()


})
)

local about = Window:MakeTab({
    Name = "支持的服务系列表",
    Icon = "rbxassetid://104249998363078",
    PremiumOnly = false
})

about:AddParagraph("开发中")

local Tab = Window:MakeTab({
  Name = "开发专区",
  Icon = "rbxassetid://104249998363078",
  PremiumOnly = false
  })
  
Tab:AddButton({
	Name = "Infinite Yield(脚本制作必备)",
	Callback = function()

loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-yield-reborn-83505"))()

})

Tab:AddButton({
	Name = "Dex汉化版",
	Callback = function()

loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
})


Tab:AddButton({
	Name = "Dex++",
	Callback = function()

loadstring(game:HttpGet("https://raw.githubusercontent.com/Twbtx/tiamxiabuwu/main/txbw%20dex%2B%2B%20huan%20huan%20HUN%20NB%21"))()
})
