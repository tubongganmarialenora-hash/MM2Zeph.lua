-- MM2 ZEPH Hub - Professional Desktop UI Edition (Smooth Glow Theme)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Create GUI Container safely
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2ZephProHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game:GetService("CoreGui")
    else
        ScreenGui.Parent = game:GetService("CoreGui")
    end
end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Theme Colors (Dark Theme + Electric Purple Glow)
local COLOR_BG = Color3.fromRGB(18, 18, 22)
local COLOR_SIDEBAR = Color3.fromRGB(24, 24, 30)
local COLOR_PANEL = Color3.fromRGB(28, 28, 36)
local COLOR_ITEM = Color3.fromRGB(35, 35, 45)
local COLOR_ITEM_HOVER = Color3.fromRGB(45, 45, 58)
local COLOR_PURPLE = Color3.fromRGB(160, 50, 255)
local COLOR_PURPLE_GLOW = Color3.fromRGB(180, 80, 255)
local COLOR_TEXT = Color3.fromRGB(235, 235, 245)
local COLOR_TEXT_DARK = Color3.fromRGB(140, 140, 160)

-- Tiny Settings Toggle Button (Top Left)
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Size = UDim2.new(0, 34, 0, 34)
SettingsBtn.Position = UDim2.new(0, 12, 0, 12)
SettingsBtn.BackgroundColor3 = COLOR_SIDEBAR
SettingsBtn.TextColor3 = COLOR_PURPLE_GLOW
SettingsBtn.Text = "⚙"
SettingsBtn.Font = Enum.Font.SourceSansBold
SettingsBtn.TextSize = 18
SettingsBtn.ZIndex = 15
SettingsBtn.Parent = ScreenGui

local UICornerSettings = Instance.new("UICorner")
UICornerSettings.CornerRadius = UDim.new(0, 8)
UICornerSettings.Parent = SettingsBtn

local StrokeSettings = Instance.new("UIStroke")
StrokeSettings.Color = COLOR_PURPLE
StrokeSettings.Thickness = 1.5
StrokeSettings.Parent = SettingsBtn

SettingsBtn.MouseEnter:Connect(function()
    TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_ITEM_HOVER}):Play()
end)
SettingsBtn.MouseLeave:Connect(function()
    TweenService:Create(SettingsBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_SIDEBAR}):Play()
end)

-- Intro / Hold Unlock Frame
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 0, 0, 0)
IntroFrame.Position = UDim2.new(0.5, -140, 0.5, -50)
IntroFrame.BackgroundColor3 = COLOR_BG
IntroFrame.BorderSizePixel = 0
IntroFrame.Visible = false
IntroFrame.ZIndex = 30
IntroFrame.Parent = ScreenGui

local UICornerIntro = Instance.new("UICorner")
UICornerIntro.CornerRadius = UDim.new(0, 10)
UICornerIntro.Parent = IntroFrame

local StrokeIntro = Instance.new("UIStroke")
StrokeIntro.Color = COLOR_PURPLE
StrokeIntro.Thickness = 2
StrokeIntro.Parent = IntroFrame

local HoldButton = Instance.new("TextButton")
HoldButton.Size = UDim2.new(0, 240, 0, 40)
HoldButton.Position = UDim2.new(0.5, -120, 0.5, -20)
HoldButton.BackgroundColor3 = COLOR_PANEL
HoldButton.TextColor3 = COLOR_TEXT
HoldButton.Text = "HOLD TO UNLOCK ZEPH HUB"
HoldButton.Font = Enum.Font.SourceSansBold
HoldButton.TextSize = 12
HoldButton.ZIndex = 32
HoldButton.Parent = IntroFrame

local UICornerHold = Instance.new("UICorner")
UICornerHold.CornerRadius = UDim.new(0, 8)
UICornerHold.Parent = HoldButton

local StrokeHold = Instance.new("UIStroke")
StrokeHold.Color = COLOR_PURPLE_GLOW
StrokeHold.Thickness = 1.2
StrokeHold.Parent = HoldButton

local HoldBar = Instance.new("Frame")
HoldBar.Size = UDim2.new(0, 0, 1, 0)
HoldBar.BackgroundColor3 = COLOR_PURPLE
HoldBar.BackgroundTransparency = 0.3
HoldBar.BorderSizePixel = 0
HoldBar.ZIndex = 31
HoldBar.Parent = HoldButton

local UICornerBar = Instance.new("UICorner")
UICornerBar.CornerRadius = UDim.new(0, 8)
UICornerBar.Parent = HoldBar

-- Main Hub Window Frame (Desktop App Layout matching `[span_1](start_span)[span_1](end_span)`)
local HubFrame = Instance.new("Frame")
HubFrame.Size = UDim2.new(0, 520, 0, 320)
HubFrame.Position = UDim2.new(0.5, -260, 0.5, -160)
HubFrame.BackgroundColor3 = COLOR_BG
HubFrame.BorderSizePixel = 0
HubFrame.Visible = false
HubFrame.ZIndex = 10
HubFrame.Parent = ScreenGui

local UICornerHub = Instance.new("UICorner")
UICornerHub.CornerRadius = UDim.new(0, 10)
UICornerHub.Parent = HubFrame

local StrokeHub = Instance.new("UIStroke")
StrokeHub.Color = COLOR_PURPLE
StrokeHub.Thickness = 2
StrokeHub.Parent = HubFrame

-- Top Title Bar (Draggable)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundTransparency = 1
TopBar.ZIndex = 11
TopBar.Parent = HubFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 220, 0, 24)
TitleLabel.Position = UDim2.new(0, 14, 0, 6)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = COLOR_TEXT
TitleLabel.Text = "ZEPH Hub [Freemium] v2.0"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 12
TitleLabel.Parent = TopBar

-- Role Status Pill inside TopBar
local RoleLabel = Instance.new("TextLabel")
RoleLabel.Size = UDim2.new(0, 180, 0, 22)
RoleLabel.Position = UDim2.new(0, 210, 0, 7)
RoleLabel.BackgroundColor3 = COLOR_PANEL
RoleLabel.TextColor3 = COLOR_TEXT
RoleLabel.TextScaled = true
RoleLabel.Font = Enum.Font.SourceSansBold
RoleLabel.RichText = true
RoleLabel.Text = "M: None | S: None"
RoleLabel.ZIndex = 12
RoleLabel.Parent = TopBar

local UICornerRole = Instance.new("UICorner")
UICornerRole.CornerRadius = UDim.new(0, 6)
UICornerRole.Parent = RoleLabel

-- Window Close / Minimize Controls
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 6)
CloseBtn.BackgroundColor3 = COLOR_PANEL
CloseBtn.TextColor3 = COLOR_TEXT
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12
CloseBtn.ZIndex = 12
CloseBtn.Parent = TopBar

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 6)
UICornerClose.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    HubFrame.Visible = false
    isHubOpen = false
end)

-- Left Sidebar Container (`[span_2](start_span)[span_2](end_span)`)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 145, 1, -36)
Sidebar.Position = UDim2.new(0, 0, 0, 36)
Sidebar.BackgroundColor3 = COLOR_SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = HubFrame

-- Sidebar Profile / Logo Box
local LogoBox = Instance.new("Frame")
LogoBox.Size = UDim2.new(1, -16, 0, 46)
LogoBox.Position = UDim2.new(0, 8, 0, 8)
LogoBox.BackgroundColor3 = COLOR_PANEL
LogoBox.ZIndex = 12
LogoBox.Parent = Sidebar

local UICornerLogo = Instance.new("UICorner")
UICornerLogo.CornerRadius = UDim.new(0, 8)
UICornerLogo.Parent = LogoBox

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, -8, 1, 0)
LogoText.Position = UDim2.new(0, 8, 0, 0)
LogoText.BackgroundTransparency = 1
LogoText.TextColor3 = COLOR_PURPLE_GLOW
LogoText.Text = "Z   ZEPH X\n<font size='9' color='#8c8cc8'>Click to view info</font>"
LogoText.Font = Enum.Font.SourceSansBold
LogoText.TextSize = 12
LogoText.RichText = true
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.ZIndex = 13
LogoText.Parent = LogoBox

-- Dragging Logic
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = HubFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(HubFrame, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

-- Content Panels Container (Right Side)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -145, 1, -36)
ContentArea.Position = UDim2.new(0, 145, 0, 36)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 11
ContentArea.Parent = HubFrame

-- Tab Scrolling Frames
local TabCombatScroll = Instance.new("ScrollingFrame")
TabCombatScroll.Size = UDim2.new(1, -12, 1, -12)
TabCombatScroll.Position = UDim2.new(0, 6, 0, 6)
TabCombatScroll.BackgroundTransparency = 1
TabCombatScroll.BorderSizePixel = 0
TabCombatScroll.CanvasSize = UDim2.new(0, 0, 0, 650)
TabCombatScroll.ScrollBarThickness = 3
TabCombatScroll.ZIndex = 12
TabCombatScroll.Visible = true
TabCombatScroll.Parent = ContentArea

local TabVisualsScroll = Instance.new("ScrollingFrame")
TabVisualsScroll.Size = UDim2.new(1, -12, 1, -12)
TabVisualsScroll.Position = UDim2.new(0, 6, 0, 6)
TabVisualsScroll.BackgroundTransparency = 1
TabVisualsScroll.BorderSizePixel = 0
TabVisualsScroll.CanvasSize = UDim2.new(0, 0, 0, 650)
TabVisualsScroll.ScrollBarThickness = 3
TabVisualsScroll.ZIndex = 12
TabVisualsScroll.Visible = false
TabVisualsScroll.Parent = ContentArea

local TabWorldScroll = Instance.new("ScrollingFrame")
TabWorldScroll.Size = UDim2.new(1, -12, 1, -12)
TabWorldScroll.Position = UDim2.new(0, 6, 0, 6)
TabWorldScroll.BackgroundTransparency = 1
TabWorldScroll.BorderSizePixel = 0
TabWorldScroll.CanvasSize = UDim2.new(0, 0, 0, 650)
TabWorldScroll.ScrollBarThickness = 3
TabWorldScroll.ZIndex = 12
TabWorldScroll.Visible = false
TabWorldScroll.Parent = ContentArea

-- Sidebar Tab Buttons Creation
local function createTabButton(name, posY, targetScroll)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 34)
    btn.Position = UDim2.new(0, 8, 0, posY)
    btn.BackgroundColor3 = COLOR_SIDEBAR
    btn.TextColor3 = COLOR_TEXT_DARK
    btn.Text = "  " .. name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.ZIndex = 12
    btn.Parent = Sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    return btn
end

local Tab1Btn = createTabButton("Combat & TPs", 62, TabCombatScroll)
local Tab2Btn = createTabButton("Visuals & ESP", 100, TabVisualsScroll)
local Tab3Btn = createTabButton("World & Farm", 138, TabWorldScroll)

local function switchTab(activeBtn, activeScroll)
    TabCombatScroll.Visible = (activeScroll == TabCombatScroll)
    TabVisualsScroll.Visible = (activeScroll == TabVisualsScroll)
    TabWorldScroll.Visible = (activeScroll == TabWorldScroll)

    for _, b in ipairs({Tab1Btn, Tab2Btn, Tab3Btn}) do
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_SIDEBAR, TextColor3 = COLOR_TEXT_DARK}):Play()
    end
    TweenService:Create(activeBtn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_PANEL, TextColor3 = COLOR_PURPLE_GLOW}):Play()
end

Tab1Btn.MouseButton1Click:Connect(function() switchTab(Tab1Btn, TabCombatScroll) end)
Tab2Btn.MouseButton1Click:Connect(function() switchTab(Tab2Btn, TabVisualsScroll) end)
Tab3Btn.MouseButton1Click:Connect(function() switchTab(Tab3Btn, TabWorldScroll) end)
switchTab(Tab1Btn, TabCombatScroll) -- default active

-- Section Header helper
local function createHeader(parent, text, posY)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 22)
    lbl.Position = UDim2.new(0, 5, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = COLOR_PURPLE_GLOW
    lbl.Text = text
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 13
    lbl.Parent = parent
    return lbl
end

-- Modern Toggle Switch Row component (matching `[span_3](start_span)[span_3](end_span)`)
local function createToggle(parent, title, desc, posY, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -10, 0, 44)
    row.Position = UDim2.new(0, 5, 0, posY)
    row.BackgroundColor3 = COLOR_PANEL
    row.ZIndex = 13
    row.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = row

    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, -80, 0, 18)
    tLabel.Position = UDim2.new(0, 12, 0, 4)
    tLabel.BackgroundTransparency = 1
    tLabel.TextColor3 = COLOR_TEXT
    tLabel.Text = title
    tLabel.Font = Enum.Font.SourceSansBold
    tLabel.TextSize = 12
    tLabel.TextXAlignment = Enum.TextXAlignment.Left
    tLabel.ZIndex = 14
    tLabel.Parent = row

    local dLabel = Instance.new("TextLabel")
    dLabel.Size = UDim2.new(1, -80, 0, 16)
    dLabel.Position = UDim2.new(0, 12, 0, 22)
    dLabel.BackgroundTransparency = 1
    dLabel.TextColor3 = COLOR_TEXT_DARK
    dLabel.Text = desc
    dLabel.Font = Enum.Font.SourceSans
    dLabel.TextSize = 10
    dLabel.TextXAlignment = Enum.TextXAlignment.Left
    dLabel.ZIndex = 14
    dLabel.Parent = row

    -- Switch Pill Container (`[span_4](start_span)[span_4](end_span)`)
    local switchBg = Instance.new("TextButton")
    switchBg.Size = UDim2.new(0, 44, 0, 22)
    switchBg.Position = UDim2.new(1, -54, 0.5, -11)
    switchBg.BackgroundColor3 = COLOR_ITEM
    switchBg.Text = ""
    switchBg.ZIndex = 14
    switchBg.Parent = row

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(1, 0)
    sCorner.Parent = switchBg

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = COLOR_TEXT_DARK
    knob.ZIndex = 15
    knob.Parent = switchBg

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local active = false
    switchBg.MouseButton1Click:Connect(function()
        active = not active
        if active then
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_PURPLE}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -19, 0.5, -8), BackgroundColor3 = COLOR_TEXT}):Play()
        else
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_ITEM}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = COLOR_TEXT_DARK}):Play()
        end
        callback(active)
    end)

    return row
end

-- Slider component
local function createSlider(parent, name, min, max, default, posY, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -10, 0, 48)
    container.Position = UDim2.new(0, 5, 0, posY)
    container.BackgroundColor3 = COLOR_PANEL
    container.ZIndex = 13
    container.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -16, 0, 18)
    label.Position = UDim2.new(0, 12, 0, 4)
    label.BackgroundTransparency = 1
    label.TextColor3 = COLOR_TEXT
    label.Text = name .. ": " .. tostring(default)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 14
    label.Parent = container

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -24, 0, 8)
    sliderBar.Position = UDim2.new(0, 12, 0, 30)
    sliderBar.BackgroundColor3 = COLOR_ITEM
    sliderBar.ZIndex = 14
    sliderBar.Parent = container

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = sliderBar

    local fillBar = Instance.new("Frame")
    fillBar.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fillBar.BackgroundColor3 = COLOR_PURPLE
    fillBar.ZIndex = 15
    fillBar.Parent = sliderBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fillBar

    local draggingSlider = false
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            fillBar.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + (max - min) * pos)
            label.Text = name .. ": " .. tostring(val)
            callback(val)
        end
    end)

    return container
end

-- ================= POPULATE TAB 1: Combat & TPs =================
local y1 = 6
createHeader(TabCombatScroll, "Player Enhancements", y1); y1 = y1 + 26
local isSpeedActive = false
createToggle(TabCombatScroll, "Speed Boost", "Increases WalkSpeed to 24", y1, function(v) isSpeedActive = v end); y1 = y1 + 50
local isNoclipActive = false
createToggle(TabCombatScroll, "Noclip", "Walk through all solid walls", y1, function(v) isNoclipActive = v end); y1 = y1 + 50
local isInfJumpActive = false
createToggle(TabCombatScroll, "Infinite Jump", "Jump infinitely in mid-air", y1, function(v) isInfJumpActive = v end); y1 = y1 + 50
local isHitboxActive = false
createToggle(TabCombatScroll, "Hitbox Expander", "Expands player hitboxes (15x)", y1, function(v) isHitboxActive = v end); y1 = y1 + 50

createHeader(TabCombatScroll, "Combat & Aim", y1); y1 = y1 + 26
local isAimlockActive = false
createToggle(TabCombatScroll, "Aimlock Murderer", "Automatically lock camera onto the murderer", y1, function(v) isAimlockActive = v end); y1 = y1 + 50

createHeader(TabCombatScroll, "Teleport Utilities", y1); y1 = y1 + 26
-- We can also make instant-action buttons styled nicely
local function createActionButton(parent, title, desc, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.BackgroundColor3 = COLOR_PANEL
    btn.Text = ""
    btn.ZIndex = 13
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = COLOR_TEXT
    l.Text = title .. " - <font color='#a032ff'>" .. desc .. "</font>"
    l.Font = Enum.Font.SourceSansBold
    l.TextSize = 12
    l.RichText = true
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 14
    l.Parent = btn

    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_ITEM_HOVER}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COLOR_PANEL}):Play() end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createActionButton(TabCombatScroll, "TP to Next Innocent", "Teleport safely to an innocent player", y1, function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if not (p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife")) then
                local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
                if targetHrp then
                    hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 3, 0)
                    break
                end
            end
        end
    end
end); y1 = y1 + 44

createActionButton(TabCombatScroll, "TP to Murderer", "Teleport directly to the murderer", y1, function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then
                local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp and targetHrp then hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 3, 0) end
                break
            end
        end
    end
end); y1 = y1 + 44

createActionButton(TabCombatScroll, "Safe Zone", "Teleport 100 studs up with platform", y1, function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
    end
end); y1 = y1 + 44

createSlider(TabCombatScroll, "WalkSpeed Slider", 16, 120, 16, y1, function(val)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").WalkSpeed = val end
end); y1 = y1 + 56

createSlider(TabCombatScroll, "JumpPower Slider", 50, 250, 50, y1, function(val)
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").JumpPower = val end
end)


-- ================= POPULATE TAB 2: Visuals & ESP =================
local y2 = 6
createHeader(TabVisualsScroll, "ESP & Highlighting", y2); y2 = y2 + 26
local isEspActive = false
createToggle(TabVisualsScroll, "Player ESP", "Highlights all players by role color", y2, function(v) isEspActive = v end); y2 = y2 + 50

local isGunEspActive = false
createToggle(TabVisualsScroll, "Gun Drop ESP", "Highlights dropped sheriff revolvers", y2, function(v) isGunEspActive = v end); y2 = y2 + 50

createHeader(TabVisualsScroll, "Lighting & Camera", y2); y2 = y2 + 26
local isFullbrightActive = false
createToggle(TabVisualsScroll, "Fullbright", "Removes shadows and brightens maps", y2, function(v)
    isFullbrightActive = v
    Lighting.Brightness = v and 2 or 1
    Lighting.GlobalShadows = not v
end); y2 = y2 + 50

createSlider(TabVisualsScroll, "FOV Slider", 10, 120, 70, y2, function(val)
    Camera.FieldOfView = val
end); y2 = y2 + 56

createSlider(TabVisualsScroll, "Brightness Slider", 0, 5, 2, y2, function(val)
    Lighting.Brightness = val
end)


-- ================= POPULATE TAB 3: World & Farm =================
local y3 = 6
createHeader(TabWorldScroll, "Automated Farming", y3); y3 = y3 + 26
local isCoinFarming = false
createToggle(TabWorldScroll, "Auto Coin Farm", "Automatically collects map coins", y3, function(v) isCoinFarming = v end); y3 = y3 + 50

local isAutoEquipActive = false
createToggle(TabWorldScroll, "Auto-Equip Gun", "Instantly picks up and equips dropped gun", y3, function(v) isAutoEquipActive = v end); y3 = y3 + 50

createHeader(TabWorldScroll, "Server Actions", y3); y3 = y3 + 26
createActionButton(TabWorldScroll, "Quick Rejoin", "Rejoin current server instantly", y3, function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end); y3 = y3 + 44

createSlider(TabWorldScroll, "Time of Day", 0, 24, 14, y3, function(val)
    Lighting.ClockTime = val
end); y3 = y3 + 56

createSlider(TabWorldScroll, "Gravity Slider", 0, 196, 196, y3, function(val)
    Workspace.Gravity = val
end)


-- ================= CORE SYSTEM LOOPS =================
-- Role Detection Loop
task.spawn(function()
    while true do
        task.wait(0.5)
        local murderer, sheriff = "None", "None"
        for _, p in ipairs(Players:GetPlayers()) do
            local char = p.Character
            if char then
                if char:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then murderer = p.Name
                elseif char:FindFirstChild("Gun") or p.Backpack:FindFirstChild("Gun") then sheriff = p.Name end
            end
        end
        local mColor = murderer ~= "None" and "#FF4444" or "#AAAAAA"
        local sColor = sheriff ~= "None" and "#4488FF" or "#AAAAAA"
        RoleLabel.Text = string.format("M: <font color='%s'>%s</font> | S: <font color='%s'>%s</font>", mColor, murderer, sColor, sheriff)
    end
end)

-- Speed Boost Loop
RunService.Heartbeat:Connect(function()
    if isSpeedActive then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").WalkSpeed = 24 end
    end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
    if isNoclipActive then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- Infinite Jump Request
UserInputService.JumpRequest:Connect(function()
    if isInfJumpActive then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Hitbox Expander Loop
RunService.RenderStepped:Connect(function()
    if not isHitboxActive then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(15, 15, 15)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end
end)

-- Aimlock Loop
local function getMurdererCharacter()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife") then return p.Character end
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    if not isAimlockActive then return end
    local murd = getMurdererCharacter()
    if murd then
        local part = murd:FindFirstChild("HumanoidRootPart") or murd:FindFirstChild("Head")
        if part then Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position) end
    end
end)

-- ESP Rendering Loop
RunService.RenderStepped:Connect(function()
    if isEspActive then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("MM2_ProHighlight") then
                local hl = Instance.new("Highlight")
                hl.Name = "MM2_ProHighlight"
                hl.Adornee = p.Character
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.FillTransparency = 0.5
                hl.Parent = p.Character
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("MM2_ProHighlight") then
                p.Character.MM2_ProHighlight:Destroy()
            end
        end
    end
end)

-- Gun Drop ESP & Auto Equip
RunService.RenderStepped:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
            if isGunEspActive and not obj:FindFirstChild("MM2_GunHL") then
                local hl = Instance.new("Highlight")
                hl.Name = "MM2_GunHL"
                hl.Adornee = obj
                hl.FillColor = Color3.fromRGB(255, 215, 0)
                hl.Parent = obj
            elseif not isGunEspActive and obj:FindFirstChild("MM2_GunHL") then
                obj.MM2_GunHL:Destroy()
            end

            if isAutoEquipActive then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - obj.Position).Magnitude < 15 then
                    hrp.CFrame = obj.CFrame + Vector3.new(0, 1, 0)
                end
            end
        end
    end
end)

-- Coin Farm Loop
task.spawn(function()
    while true do
        task.wait(0.5)
        if isCoinFarming then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if not isCoinFarming then break end
                    if obj.Name == "Coin" or obj.Name == "CoinVisual" or (obj:IsA("BasePart") and obj.Parent and obj.Parent.Name == "CoinContainer") then
                        local target = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart", true)
                        if target then
                            hrp.CFrame = target.CFrame + Vector3.new(0, 2, 0)
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
    end
end)

-- Settings / Unlock GUI Controls
local isHubOpen = false
local isUnlocked = false
local isHolding = false

SettingsBtn.MouseButton1Click:Connect(function()
    if isUnlocked then
        isHubOpen = not isHubOpen
        if isHubOpen then
            HubFrame.Visible = true
            HubFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(HubFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 520, 0, 320)
            }):Play()
        else
            TweenService:Create(HubFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.2)
            HubFrame.Visible = false
        end
    else
        IntroFrame.Visible = true
        TweenService:Create(IntroFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 100)
        }):Play()
    end
end)

HoldButton.MouseButton1Down:Connect(function()
    isHolding = true
    local holdDuration = 1.2
    TweenService:Create(HoldBar, TweenInfo.new(holdDuration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
    
    task.spawn(function()
        local elapsed = 0
        while isHolding and elapsed < holdDuration do
            elapsed = elapsed + 0.05
            task.wait(0.05)
        end
        if isHolding then
            isUnlocked = true
            isHolding = false
            TweenService:Create(IntroFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.25)
            IntroFrame.Visible = false
            HoldBar.Size = UDim2.new(0, 0, 1, 0)
            
            HubFrame.Size = UDim2.new(0, 0, 0, 0)
            HubFrame.Visible = true
            isHubOpen = true
            TweenService:Create(HubFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 520, 0, 320)
            }):Play()
        end
    end)
end)

local function cancelHold()
    if not isUnlocked and isHolding then
        isHolding = false
        TweenService:Create(HoldBar, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 1, 0)}):Play()
    end
end

HoldButton.MouseButton1Up:Connect(cancelHold)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then cancelHold() end
end)
