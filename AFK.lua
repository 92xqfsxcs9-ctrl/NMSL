-- [[ XiaoYu Pro Professional UI - Full Version ]]
-- [[ ALL CODE STRUCTURE IN ENGLISH ]]

local CorrectKey = "XiaoYu_Pro_0611"
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local VU = game:GetService("VirtualUser")
local LP = game:GetService("Players").LocalPlayer

local SG = Instance.new("ScreenGui", game.CoreGui)
SG.Name = "XiaoYuPro_V3"

-- [[ 1. Key System Window ]]
local KeyFrame = Instance.new("Frame", SG)
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.4, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 50)
KeyTitle.Text = "XiaoYu Pro - Authentication"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KeyInput)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
SubmitBtn.Text = "Verify & Start"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SubmitBtn)

-- [[ 2. Main Menu (Left Sidebar, Right Content) ]]
local MainFrame = Instance.new("Frame", SG)
MainFrame.Size = UDim2.new(0, 450, 0, 280)
MainFrame.Position = UDim2.new(0.5, -225, 0.4, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Sidebar (Left)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Instance.new("UICorner", Sidebar)

-- Content Area (Right)
local PageContainer = Instance.new("Frame", MainFrame)
PageContainer.Size = UDim2.new(1, -135, 1, -20)
PageContainer.Position = UDim2.new(0, 127, 0, 10)
PageContainer.BackgroundTransparency = 1

-- [[ 3. Floating Avatar (Circle Head) ]]
local AvatarBall = Instance.new("ImageButton", SG)
AvatarBall.Size = UDim2.new(0, 65, 0, 65)
AvatarBall.Visible = false
AvatarBall.Image = "rbxassetid://135898863618386" -- 確保這是正確的資產 ID
AvatarBall.BackgroundColor3 = Color3.new(1,1,1)
local BallCorner = Instance.new("UICorner", AvatarBall)
BallCorner.CornerRadius = UDim.new(1, 0)

-- [[ Functions & Logic ]]
local function OpenMenu()
    KeyFrame.Visible = false
    MainFrame.Visible = true
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        OpenMenu()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY!"
    end
end)

-- Tab Buttons Logic
local function CreateTab(name, pos)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = name
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    return b
end

local AFKTab = CreateTab("AFK System", 10)
local LangTab = CreateTab("Language", 50)

-- Minimize Function
local MinBtn = Instance.new("TextButton", PageContainer)
MinBtn.Size = UDim2.new(0.9, 0, 0, 40)
MinBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
MinBtn.Text = "Minimize to Avatar"
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    AvatarBall.Visible = true
    AvatarBall.Position = MainFrame.Position
end)

AvatarBall.MouseButton1Click:Connect(function()
    AvatarBall.Visible = false
    MainFrame.Visible = true
end)

-- Anti-AFK Background Task
LP.Idled:Connect(function()
    VU:CaptureController()
    VU:ClickButton2(Vector2.new(0,0))
end)

print("XiaoYu Pro V3 Loaded!")
