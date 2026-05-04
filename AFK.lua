-- [[ XIAOYU PREMIUM V3 - MULTILINGUAL ]]
local CorrectKey = "XiaoYu_pro_000"
local _G.AFK_Enabled = false
local CurrentLang = "EN" -- Default Language
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- [[ UI SETUP ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XiaoYu_Final_UI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- 1. Round Icon (The Gojo Image)
local MinimizeIcon = Instance.new("ImageButton")
MinimizeIcon.Name = "MinimizeIcon"
MinimizeIcon.Visible = false
MinimizeIcon.Size = UDim2.new(0, 65, 0, 65)
MinimizeIcon.Position = UDim2.new(0.05, 0, 0.4, 0)
MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeIcon.Image = "rbxassetid://134267439369905" -- Using your uploaded image style
MinimizeIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = MinimizeIcon

-- 2. Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Language Switcher
local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0, 90, 0, 25)
LangBtn.Position = UDim2.new(0, 10, 0, 10)
LangBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
LangBtn.Text = "English / 中文"
LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtn.TextSize = 12
LangBtn.Font = Enum.Font.Gotham
LangBtn.Parent = MainFrame

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 6)
LangCorner.Parent = LangBtn

-- Minimize Button (On Main Frame)
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -35, 0, 5)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Text = "−"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.TextSize = 25
MiniBtn.Parent = MainFrame

-- UI Content Container
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "XIAOYU SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, -60)
Container.Position = UDim2.new(0, 0, 0, 60)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- Pages
local AuthPage = Instance.new("Frame")
AuthPage.Size = UDim2.new(1, 0, 1, 0)
AuthPage.BackgroundTransparency = 1
AuthPage.Parent = Container

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.1, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
KeyBox.PlaceholderText = "ENTER KEY..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Parent = AuthPage

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 45)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 102, 204)
VerifyBtn.Text = "VERIFY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = AuthPage

local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Visible = false
MainPage.Parent = Container

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 55)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleBtn.Text = "AFK: DISABLED"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = MainPage

-- [[ TRANSLATIONS ]]
local Langs = {
    EN = {
        KeyPlace = "ENTER KEY...", Verify = "VERIFY", Denied = "WRONG KEY!",
        AfkOff = "AFK: DISABLED", AfkOn = "AFK: ENABLED", Title = "XIAOYU SYSTEM"
    },
    TW = {
        KeyPlace = "請輸入金鑰...", Verify = "驗證登入", Denied = "金鑰錯誤！",
        AfkOff = "防斷線：關閉中", AfkOn = "防斷線：運行中", Title = "小宇系統"
    }
}

local function UpdateUI()
    local L = Langs[CurrentLang]
    Title.Text = L.Title
    if not MainPage.Visible then
        KeyBox.PlaceholderText = L.KeyPlace
        VerifyBtn.Text = L.Verify
    end
    ToggleBtn.Text = _G.AFK_Enabled and L.AfkOn or L.AfkOff
end

-- [[ LOGIC ]]
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
        KeyBox.PlaceholderText = Langs[CurrentLang].Denied
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AFK_Enabled = !_G.AFK_Enabled
    ToggleBtn.BackgroundColor3 = _G.AFK_Enabled and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(180, 40, 40)
    UpdateUI()
end)

-- [[ ANIMATION FUNCTIONS ]]
local function ToggleUI(toIcon)
    if toIcon then
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.4)
        MainFrame.Visible = false
        MinimizeIcon.Visible = true
        MinimizeIcon.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 65, 0, 65)}):Play()
    else
        TweenService:Create(MinimizeIcon, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        MinimizeIcon.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 280, 0, 220)}):Play()
    end
end

MiniBtn.MouseButton1Click:Connect(function() ToggleUI(true) end)
MinimizeIcon.MouseButton1Click:Connect(function() ToggleUI(false) end)

-- Dragging Logic for Icon
local dragging, dragStart, startPos
MinimizeIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = MinimizeIcon.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MinimizeIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
MinimizeIcon.InputEnded:Connect(function() dragging = false end)

-- AFK Loop
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if _G.AFK_Enabled then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end
end)

UpdateUI()
