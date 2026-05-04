-- [[ XIAOYU PREMIUM FINAL VERSION ]]
local CorrectKey = "XiaoYu_pro_000"
local _G.AFK_Enabled = false
local CurrentLang = "EN"
local TweenService = game:GetService("TweenService")

-- [[ UI SETUP ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XiaoYu_Final"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Round Icon for Minimize
local MinimizeIcon = Instance.new("ImageButton")
MinimizeIcon.Visible = false
MinimizeIcon.Size = UDim2.new(0, 60, 0, 60)
MinimizeIcon.Position = UDim2.new(0.05, 0, 0.4, 0)
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeIcon.Image = "rbxassetid://134267439369905" -- Five-jo Image
MinimizeIcon.Parent = ScreenGui
local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = MinimizeIcon

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Top Bar Elements
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "XIAOYU SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -35, 0, 8)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "_"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.TextSize = 20
MiniBtn.Parent = MainFrame

local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0, 70, 0, 20)
LangBtn.Position = UDim2.new(0, 10, 0, 12)
LangBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LangBtn.Text = "English"
LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtn.TextSize = 11
LangBtn.Parent = MainFrame
local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 4)
LangCorner.Parent = LangBtn

-- Content Pages
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, -45)
Container.Position = UDim2.new(0, 0, 0, 45)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

local AuthPage = Instance.new("Frame")
AuthPage.Size = UDim2.new(1, 0, 1, 0)
AuthPage.BackgroundTransparency = 1
AuthPage.Parent = Container

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 35)
KeyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.PlaceholderText = "ENTER KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Parent = AuthPage

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 35)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
VerifyBtn.Text = "VERIFY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Parent = AuthPage

local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.Parent = Container

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 45)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleBtn.Text = "AFK: DISABLED"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = MainPage

-- Language Data
local Langs = {
    EN = {Text = "English", Key = "ENTER KEY...", Verify = "VERIFY", Off = "AFK: DISABLED", On = "AFK: ENABLED"},
    TW = {Text = "繁體中文", Key = "請輸入金鑰...", Verify = "驗證", Off = "防斷線：已關閉", On = "防斷線：已開啟"}
}

local function UpdateUI()
    local d = Langs[CurrentLang]
    LangBtn.Text = d.Text
    KeyBox.PlaceholderText = d.Key
    VerifyBtn.Text = d.Verify
    ToggleBtn.Text = _G.AFK_Enabled and d.On or d.Off
end

LangBtn.MouseButton1Click:Connect(function()
    CurrentLang = (CurrentLang == "EN") and "TW" or "EN"
    UpdateUI()
end)

VerifyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        AuthPage.Visible = false
        MainPage.Visible = true
        UpdateUI()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = (CurrentLang == "EN") and "DENIED" or "驗證失敗"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AFK_Enabled = !_G.AFK_Enabled
    ToggleBtn.BackgroundColor3 = _G.AFK_Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    UpdateUI()
end)

-- Animation Logic
local function SetUI(main)
    if main then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 260, 0, 200), "Out", "Back", 0.4, true)
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.3) MinimizeIcon.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0,0,0,0), "In", "Quad", 0.3, true, function()
            MainFrame.Visible = false
            MinimizeIcon.Visible = true
            MinimizeIcon.Size = UDim2.new(0,0,0,0)
            MinimizeIcon:TweenSize(UDim2.new(0,60,0,60), "Out", "Back", 0.4, true)
        end)
    end
end

MiniBtn.MouseButton1Click:Connect(function() SetUI(false) end)
MinimizeIcon.MouseButton1Click:Connect(function() SetUI(true) end)

-- AFK Loop
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if _G.AFK_Enabled then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end
end)
UpdateUI()
