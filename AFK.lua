-- [[ XiaoYu Pro - Ultimate RGB Key System V8 ]]
-- [[ KEY: XiaoYu_Pro_0611 ]]

local K, ID = "XiaoYu_Pro_0611", "rbxassetid://135898863618386"
local VU, LP = game:GetService("VirtualUser"), game:GetService("Players").LocalPlayer
local UIS, TS, RunService = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService")
local SG = Instance.new("ScreenGui", game.CoreGui)

-- [[ 1. Key System with RGB ]]
local KF = Instance.new("Frame", SG)
KF.Size, KF.Position, KF.BackgroundColor3 = UDim2.new(0,300,0,180), UDim2.new(0.5,-150,0.4,-90), Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", KF)

local KeyHint = Instance.new("TextLabel", KF)
KeyHint.Size, KeyHint.Position = UDim2.new(1,0,0,30), UDim2.new(0,0,0,10)
KeyHint.Text = "Key: " .. K
KeyHint.Font = Enum.Font.GothamBold
KeyHint.TextSize = 16
KeyHint.BackgroundTransparency = 1
-- RGB Logic for KeyHint
RunService.RenderStepped:Connect(function()
    local hue = tick() % 3 / 3
    KeyHint.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
end)

local KI = Instance.new("TextBox", KF)
KI.Size, KI.Position, KI.PlaceholderText = UDim2.new(0.8,0,0,35), UDim2.new(0.1,0,0.35,0), "Paste Key Here..."
KI.BackgroundColor3, KI.TextColor3 = Color3.fromRGB(40,40,40), Color3.new(1,1,1)
Instance.new("UICorner", KI)

local SB = Instance.new("TextButton", KF)
SB.Size, SB.Position, SB.Text = UDim2.new(0.8,0,0,35), UDim2.new(0.1,0,0.7,0), "Verify Key"
SB.BackgroundColor3, SB.TextColor3 = Color3.fromRGB(0,120,215), Color3.new(1,1,1)
Instance.new("UICorner", SB)

-- [[ 2. Main Menu (Resizable) ]]
local MF = Instance.new("Frame", SG)
MF.Size, MF.Position, MF.BackgroundColor3, MF.Visible = UDim2.new(0,400,0,250), UDim2.new(0.5,-200,0.4,-125), Color3.fromRGB(15,15,15), false
MF.Active, MF.Draggable = true, true
Instance.new("UICorner", MF)

local ResizeHandle = Instance.new("TextButton", MF)
ResizeHandle.Size, ResizeHandle.Position, ResizeHandle.Text = UDim2.new(0,20,0,20), UDim2.new(1,-20,1,-20), "◢"
ResizeHandle.TextColor3, ResizeHandle.BackgroundTransparency = Color3.new(1,1,1), 1

local Side = Instance.new("Frame", MF)
Side.Size, Side.BackgroundColor3 = UDim2.new(0,100,1,0), Color3.fromRGB(10,10,10)
Instance.new("UICorner", Side)

local Cont = Instance.new("Frame", MF)
Cont.Size, Cont.Position, Cont.BackgroundTransparency = UDim2.new(1,-110,1,-70), UDim2.new(0,105,0,5), 1

-- [[ 3. Options & Toggles ]]
local AFK_Enabled, currentLang = true, "EN"

local AFKToggle = Instance.new("TextButton", Cont)
AFKToggle.Size, AFKToggle.Position = UDim2.new(0.9,0,0,40), UDim2.new(0.05,0,0.1,0)
AFKToggle.Text, AFKToggle.BackgroundColor3, AFKToggle.TextColor3 = "Anti-AFK: ON", Color3.fromRGB(0,150,0), Color3.new(1,1,1)
AFKToggle.Visible = false
Instance.new("UICorner", AFKToggle)

local LangBtn = Instance.new("TextButton", Cont)
LangBtn.Size, LangBtn.Position = UDim2.new(0.9,0,0,40), UDim2.new(0.05,0,0.1,0)
LangBtn.Text, LangBtn.BackgroundColor3, LangBtn.TextColor3 = "Language: English", Color3.fromRGB(60,60,60), Color3.new(1,1,1)
LangBtn.Visible = false
Instance.new("UICorner", LangBtn)

-- [[ 4. Floating Avatar ]]
local Ball = Instance.new("ImageButton", SG)
Ball.Size, Ball.Visible, Ball.Image = UDim2.new(0,65,0,65), false, ID
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1,0)

-- [[ Logic ]]
SB.MouseButton1Click:Connect(function()
    if KI.Text == K then KF.Visible, MF.Visible = false, true else KI.Text = "" KI.PlaceholderText = "WRONG!" end
end)

local function Tab(txt, y, callback)
    local b = Instance.new("TextButton", Side)
    b.Size, b.Position, b.Text = UDim2.new(0.9,0,0,35), UDim2.new(0.05,0,0,y), txt
    b.BackgroundColor3, b.TextColor3 = Color3.fromRGB(30,30,30), Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
end

Tab("AFK Sys", 10, function() AFKToggle.Visible, LangBtn.Visible = true, false end)
Tab("Lang", 50, function() AFKToggle.Visible, LangBtn.Visible = false, true end)

AFKToggle.MouseButton1Click:Connect(function()
    AFK_Enabled = not AFK_Enabled
    AFKToggle.Text = AFK_Enabled and (currentLang == "EN" and "Anti-AFK: ON" or "防掉線：開啟") or (currentLang == "EN" and "Anti-AFK: OFF" or "防掉線：關閉")
    AFKToggle.BackgroundColor3 = AFK_Enabled and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
end)

LangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "EN") and "CH" or "EN"
    LangBtn.Text = (currentLang == "EN") and "Language: English" or "語言：中文"
    AFKToggle.Text = AFK_Enabled and (currentLang == "EN" and "Anti-AFK: ON" or "防掉線：開啟") or (currentLang == "EN" and "Anti-AFK: OFF" or "防掉線：關閉")
end)

local MBtn = Instance.new("TextButton", MF)
MBtn.Size, MBtn.Position, MBtn.Text = UDim2.new(0.7,0,0,40), UDim2.new(0.25,0,0.85,0), "Minimize"
MBtn.BackgroundColor3, MBtn.TextColor3 = Color3.fromRGB(45,45,45), Color3.new(1,1,1)
Instance.new("UICorner", MBtn)

MBtn.MouseButton1Click:Connect(function() MF.Visible, Ball.Visible = false, true Ball.Position = MF.Position end)
Ball.MouseButton1Click:Connect(function() Ball.Visible, MF.Visible = false, true end)

-- Resizing Logic
local resizing = false
ResizeHandle.MouseButton1Down:Connect(function() resizing = true end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then resizing = false end end)
UIS.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UIS:GetMouseLocation()
        MF.Size = UDim2.new(0, mousePos.X - MF.AbsolutePosition.X, 0, mousePos.Y - MF.AbsolutePosition.Y - 36)
    end
end)

LP.Idled:Connect(function() if AFK_Enabled then VU:CaptureController() VU:ClickButton2(Vector2.new(0,0)) end end)
