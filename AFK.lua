-- [[ XiaoYu Pro Professional UI - AFK Version ]]
-- [[ ALL SOURCE CODE IN ENGLISH ]]

local CorrectKey = "XiaoYu_Pro_0611"
local EnteredKey = "" -- User will enter this in GUI

local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local VU = game:GetService("VirtualUser")
local LP = game:GetService("Players").LocalPlayer

-- [[ GUI Setup ]]
local SG = Instance.new("ScreenGui", game.CoreGui)
SG.Name = "XiaoYuPro_Professional"

-- Key System Window
local KeyFrame = Instance.new("Frame", SG)
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.4, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", KeyFrame)

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "Enter Key"
KeyTitle.TextColor3 = Color3.new(1, 1, 1)
KeyTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "Paste Key Here..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyInput.TextColor3 = Color3.new(1, 1, 1)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
SubmitBtn.Text = "Verify Key"
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.TextColor3 = Color3.new(1, 1, 1)

-- Main Menu (Initially Invisible)
local MainFrame = Instance.new("Frame", SG)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.4, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)

-- Left Tab Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 100, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", Sidebar)

-- Right Content Area
local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -110, 1, -10)
Content.Position = UDim2.new(0, 105, 0, 5)
Content.BackgroundTransparency = 1

-- Floating Avatar (Minimize Ball)
local Ball = Instance.new("ImageButton", SG)
Ball.Size = UDim2.new(0, 60, 0, 60)
Ball.Visible = false
Ball.Image = "rbxassetid://135898863618386" -- Ensure this ID is correct in Roblox
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

-- [[ Functions ]]
local function ShowMain()
    KeyFrame.Visible = false
    MainFrame.Visible = true
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        ShowMain()
    else
        KeyTitle.Text = "Wrong Key! Try Again."
        KeyTitle.TextColor3 = Color3.new(1, 0, 0)
    end
end)

-- Tab Buttons (Left)
local AFKTab = Instance.new("TextButton", Sidebar)
AFKTab.Size = UDim2.new(1, 0, 0, 40)
AFKTab.Text = "AFK"
AFKTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AFKTab.TextColor3 = Color3.new(1, 1, 1)

local LangTab = Instance.new("TextButton", Sidebar)
LangTab.Size = UDim2.new(1, 0, 0, 40)
LangTab.Position = UDim2.new(0, 0, 0, 45)
LangTab.Text = "Language"
LangTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LangTab.TextColor3 = Color3.new(1, 1, 1)

-- Options (Right)
local StatusLabel = Instance.new("TextLabel", Content)
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Text = "Status: Anti-AFK Running"
StatusLabel.TextColor3 = Color3.new(0, 1, 0)
StatusLabel.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", Content)
MinBtn.Size = UDim2.new(0.9, 0, 0, 40)
MinBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
MinBtn.Text = "Minimize to Avatar"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

-- Toggle Logic
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Ball.Visible = true
    Ball.Position = MainFrame.Position
end)

Ball.MouseButton1Click:Connect(function()
    Ball.Visible = false
    MainFrame.Visible = true
end)

-- Anti-AFK
LP.Idled:Connect(function()
    VU:CaptureController()
    VU:ClickButton2(Vector2.new(0,0))
end)
