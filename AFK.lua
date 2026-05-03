-- [[ CONFIGURATION ]]
local CorrectKey = "XiaoYu_pro_000"
local HasKey = false

-- [[ UI SETUP ]]
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local VerifyBtn = Instance.new("TextButton")

-- UI Properties
ScreenGui.Name = "XiaoYuKeySystem"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -65)
MainFrame.Size = UDim2.new(0, 250, 0, 130)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "AFK SYSTEM VERIFY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

KeyBox.Name = "KeyBox"
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 30)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 5)
KeyCorner.Parent = KeyBox

VerifyBtn.Name = "VerifyBtn"
VerifyBtn.Parent = MainFrame
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
VerifyBtn.Position = UDim2.new(0.1, 0, 0.65, 5)
VerifyBtn.Size = UDim2.new(0.8, 0, 0, 30)
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Text = "VERIFY"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 5)
BtnCorner.Parent = VerifyBtn

-- [[ FUNCTIONS ]]
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function StartAFK()
    local vu = game:GetService("VirtualUser")
    Notify("Success", "AFK Script Activated!")
    warn("AFK System Running...")

    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new(0,0))
        Notify("AFK Action", "Anti-AFK click performed.")
    end)
end

-- Button Logic
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CorrectKey then
        ScreenGui:Destroy()
        StartAFK()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "INVALID KEY!"
        KeyBox.PlaceholderColor3 = Color3.fromRGB(255, 85, 85)
        Notify("Error", "Invalid key provided.")
    end
end)
