-- [[ XiaoYu Pro - Professional Synthetic Script ]]
local K, ID = "XiaoYu_Pro_0611", "rbxassetid://135898863618386"
local TS, VU, LP = game:GetService("TweenService"), game:GetService("VirtualUser"), game:GetService("Players").LocalPlayer
local SG = Instance.new("ScreenGui", game.CoreGui)

-- 1. Key System Setup
local KF = Instance.new("Frame", SG)
KF.Size, KF.Position, KF.BackgroundColor3 = UDim2.new(0,300,0,160), UDim2.new(0.5,-150,0.4,-80), Color3.fromRGB(25,25,25)
Instance.new("UICorner", KF).CornerRadius = UDim.new(0,12)

local KI = Instance.new("TextBox", KF)
KI.Size, KI.Position, KI.PlaceholderText = UDim2.new(0.8,0,0,35), UDim2.new(0.1,0,0.3,0), "Enter Key..."
KI.BackgroundColor3, KI.TextColor3 = Color3.fromRGB(40,40,40), Color3.new(1,1,1)
Instance.new("UICorner", KI)

local SB = Instance.new("TextButton", KF)
SB.Size, SB.Position, SB.Text = UDim2.new(0.8,0,0,35), UDim2.new(0.1,0,0.7,0), "Verify Key"
SB.BackgroundColor3, SB.TextColor3 = Color3.fromRGB(0,120,215), Color3.new(1,1,1)
Instance.new("UICorner", SB)

-- 2. Main Menu (Left Sidebar + Right Options)
local MF = Instance.new("Frame", SG)
MF.Size, MF.Position, MF.BackgroundColor3, MF.Visible = UDim2.new(0,400,0,250), UDim2.new(0.5,-200,0.4,-125), Color3.fromRGB(15,15,15), false
Instance.new("UICorner", MF)

local Side = Instance.new("Frame", MF)
Side.Size, Side.BackgroundColor3 = UDim2.new(0,100,1,0), Color3.fromRGB(10,10,10)
Instance.new("UICorner", Side)

local Cont = Instance.new("Frame", MF)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1,-110,1,-10), UDim2.new(0,105,0,5), 1

-- 3. Floating Avatar (Minimize Ball)
local Ball = Instance.new("ImageButton", SG)
Ball.Size, Ball.Visible, Ball.Image = UDim2.new(0,65,0,65), false, ID
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1,0)

-- Core Logic
SB.MouseButton1Click:Connect(function()
    if KI.Text == K then 
        KF.Visible, MF.Visible = false, true 
    else 
        KI.Text = "" KI.PlaceholderText = "WRONG KEY!" 
    end
end)

local function Tab(txt, y)
    local b = Instance.new("TextButton", Side)
    b.Size, b.Position, b.Text = UDim2.new(0.9,0,0,35), UDim2.new(0.05,0,0,y), txt
    b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(30,30,30), Color3.new(1,1,1)
    Instance.new("UICorner", b) return b
end

local AT = Tab("AFK Sys", 10)
local LT = Tab("Lang", 50)

local MBtn = Instance.new("TextButton", Cont)
MBtn.Size, MBtn.Position, MBtn.Text = UDim2.new(0.9,0,0,45), UDim2.new(0.05,0,0.7,0), "Minimize to Head"
MBtn.BackgroundColor3, MBtn.TextColor3 = Color3.fromRGB(45,45,45), Color3.new(1,1,1)
Instance.new("UICorner", MBtn)

-- Minimize & Restore with Smooth Transition
MBtn.MouseButton1Click:Connect(function() MF.Visible, Ball.Visible = false, true Ball.Position = MF.Position end)
Ball.MouseButton1Click:Connect(function() Ball.Visible, MF.Visible = false, true end)

-- Background Anti-AFK
LP.Idled:Connect(function() VU:CaptureController() VU:ClickButton2(Vector2.new(0,0)) end)

print("XiaoYu Pro V3 Synthesized & Loaded!")
