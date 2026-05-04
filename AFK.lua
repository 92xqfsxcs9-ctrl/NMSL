-- [[ CONFIGURATION ]]
local CorrectKey = "XiaoYu_pro_000"
local _G.AFK_Enabled = false
local CurrentLang = "EN" -- "EN" or "TW"
local TweenService = game:GetService("TweenService")

-- [[ UI SETUP ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XiaoYu_Multilingual_V3"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. Round Icon (Minimize State)
local MinimizeIcon = Instance.new("ImageButton")
MinimizeIcon.Name = "MinimizeIcon"
MinimizeIcon.Visible = false
MinimizeIcon.Size = UDim2.new(0, 65, 0, 65)
MinimizeIcon.Position = UDim2.new(0.1, 0, 0.5, 0)
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
-- 圖片使用你提供的樣式 (五條悟)
MinimizeIcon.Image = "rbxassetid://134267439369905" 
MinimizeIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = MinimizeIcon

-- 2. Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Minimize Button
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -35, 0, 5)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "_"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.TextSize = 25
MiniBtn.Parent = MainFrame

-- Language Switcher Button
local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0, 80, 0, 25)
LangBtn.Position = UDim2.new(0, 10, 0, 10)
LangBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LangBtn.Text = "English"
LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtn.TextSize = 12
LangBtn.Parent = MainFrame
local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 5)
LangCorner.Parent = LangBtn

-- UI Elements
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "XIAOYU SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, -50)
Container.Position = UDim2.new(0, 0, 0, 50)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- AUTH PAGE
local AuthPage = Instance.new("Frame")
AuthPage.Size = UDim2.new(1, 0, 1, 0)
AuthPage.BackgroundTransparency = 1
AuthPage.Parent = Container

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.15, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.PlaceholderText = "ENTER KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Parent = AuthPage

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 40)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
VerifyBtn.Text = "AUTHENTICATE"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = AuthPage

-- MAIN PAGE
local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.Parent = Container

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleBtn.Text = "ANTI-AFK: DISABLED"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = MainPage

-- [[ LANGUAGE DICTIONARY ]]
local LangTable = {
    EN = {
        Placeholder = "ENTER KEY...",
        Verify = "AUTHENTICATE",
        Denied = "ACCESS DENIED",
        AfkOff = "ANTI-AFK: DISABLED",
        AfkOn = "ANTI-AFK: ENABLED",
        Success = "Access Granted",
        LangName = "English"
    },
    TW = {
        Placeholder = "請輸入金鑰...",
        Verify = "驗證金鑰",
        Denied = "驗證失敗",
        AfkOff = "防斷線：已關閉",
        AfkOn = "防斷線：已開啟",
        Success = "驗證成功",
        LangName = "繁體中文"
    }
}

local function UpdateLanguage()
    local data = LangTable[CurrentLang]
    LangBtn.Text = data.LangName
    if not MainPage.Visible then
        KeyBox.PlaceholderText = data.Placeholder
        VerifyBtn.Text = data.Verify
    else
        ToggleBtn.Text = _G.AFK_Enabled and data.AfkOn or data.AfkOff
    end
end

-- [[ LOGIC ]]
LangBtn.MouseButton1Click:Connect(function()
    CurrentLang = (CurrentLang == "EN") and "TW" or "EN"
    UpdateLanguage()
end)

VerifyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        AuthPage.Visible = false
        MainPage.Visible = true
        UpdateLanguage()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = LangTable[CurrentLang].Denied
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AFK_Enabled = !_G.AFK_Enabled
    if _G.AFK_Enabled then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
    UpdateLanguage()
end)

-- [[ ANIMATION FUNCTIONS ]]
local function ToggleUI(showMain)
    if showMain then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 280, 0, 220)}):Play()
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        MinimizeIcon.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        MainFrame.Visible = false
        MinimizeIcon.Visible = true
        MinimizeIcon.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 65, 0, 65)}):Play()
    end
end

MiniBtn.MouseButton1Click:Connect(function() ToggleUI(false) end)
MinimizeIcon.MouseButton1Click:Connect(function() ToggleUI(true) end)

-- AFK Loop
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if _G.AFK_Enabled then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end
end)

-- Icon Dragging Logic
local dragging, dragStart, startPos
MinimizeIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MinimizeIcon.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MinimizeIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
MinimizeIcon.InputEnded:Connect(function() dragging = false end)

UpdateLanguage()
