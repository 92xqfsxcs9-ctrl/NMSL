-- [[ XiaoYu Pro Script - Multi-Language AFK Version ]]
-- [[ ALL CODE IN ENGLISH FOR STABILITY ]]

local CorrectKey = "XiaoYu_Pro_0611"
local EnteredKey = "XiaoYu_Pro_0611" -- Key Check

if EnteredKey ~= CorrectKey then
    warn("Invalid Key!")
    return
end

-- [[ Services ]]
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- [[ GUI Setup ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XiaoYuPro_Global"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- State Variables
local currentLang = "EN" -- Default Language
local isMinimized = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Circle Avatar (Minimize Result)
local AvatarBall = Instance.new("ImageButton")
AvatarBall.Size = UDim2.new(0, 60, 0, 60)
AvatarBall.Visible = false
AvatarBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AvatarBall.Image = "rbxassetid://135898863618386" -- Your provided image
AvatarBall.Parent = ScreenGui

local BallCorner = Instance.new("UICorner")
BallCorner.CornerRadius = UDim.new(1, 0)
BallCorner.Parent = AvatarBall

-- UI Elements
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "XiaoYu Pro v2.0"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.25, 0)
StatusLabel.Text = "Status: Anti-AFK Active"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.new(0.8, 0, 0, 35)
LangBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
LangBtn.Text = "Language: EN / 中文"
LangBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LangBtn.TextColor3 = Color3.new(1, 1, 1)
LangBtn.Font = Enum.Font.Gotham
LangBtn.Parent = MainFrame

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0.8, 0, 0, 35)
MinBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
MinBtn.Text = "Minimize to Head"
MinBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.Gotham
MinBtn.Parent = MainFrame

-- Rounded Corners for buttons
local b1c = Instance.new("UICorner") b1c.Parent = LangBtn
local b2c = Instance.new("UICorner") b2c.Parent = MinBtn

-- [[ Logic ]]

-- Language Toggle
LangBtn.MouseButton1Click:Connect(function()
    if currentLang == "EN" then
        currentLang = "CH"
        StatusLabel.Text = "狀態：防掉線運行中"
        MinBtn.Text = "縮小至頭像"
        LangBtn.Text = "語言：中文"
    else
        currentLang = "EN"
        StatusLabel.Text = "Status: Anti-AFK Active"
        MinBtn.Text = "Minimize to Head"
        LangBtn.Text = "Language: EN"
    end
end)

-- Minimize Logic
MinBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
    AvatarBall.Position = MainFrame.Position
    AvatarBall.Visible = true
end)

AvatarBall.MouseButton1Click:Connect(function()
    AvatarBall.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 220, 0, 180), "Out", "Back", 0.3, true)
end)

-- Smooth Dragging
local dragStart, startPos, dragging
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Core Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0,0))
end)

print("XiaoYu Pro loaded successfully!")
