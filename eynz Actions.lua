-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local StatsService = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

---------------------------------------------------------------------
-- SAFE UI CONTAINER
---------------------------------------------------------------------
local ParentGui
if gethui then
    ParentGui = gethui()
elseif CoreGui then
    ParentGui = CoreGui
else
    ParentGui = LocalPlayer:WaitForChild("PlayerGui")
end

if ParentGui:FindFirstChild("MobileQoL_UI") then
    ParentGui.MobileQoL_UI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileQoL_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentGui

-- // TWEEN PRESETS
local fastTween = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local slideTween = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local wheelOpenTween = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local wheelCloseTween = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

---------------------------------------------------------------------
-- 1. LAUNCHER BUTTON
---------------------------------------------------------------------
local Launcher = Instance.new("TextButton")
Launcher.Name = "Launcher"
Launcher.AnchorPoint = Vector2.new(1, 0.5)
Launcher.Position = UDim2.new(1, 0, 0.4, 0)
Launcher.Size = UDim2.new(0, 26, 0.45, 0)
Launcher.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Launcher.BackgroundTransparency = 0.35
Launcher.BorderSizePixel = 0
Launcher.Text = ""
Launcher.AutoButtonColor = false
Launcher.ClipsDescendants = false
Launcher.ZIndex = 10
Launcher.Parent = ScreenGui

local LauncherCorner = Instance.new("UICorner")
LauncherCorner.CornerRadius = UDim.new(0, 10)
LauncherCorner.Parent = Launcher

local LauncherStroke = Instance.new("UIStroke")
LauncherStroke.Color = Color3.fromRGB(255, 255, 255)
LauncherStroke.Transparency = 0.8
LauncherStroke.Thickness = 1
LauncherStroke.Parent = Launcher

local LauncherText = Instance.new("TextLabel")
LauncherText.Name = "RotatedText"
LauncherText.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherText.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherText.Size = UDim2.new(0, 200, 0, 26)
LauncherText.BackgroundTransparency = 1
LauncherText.Font = Enum.Font.GothamBold
LauncherText.TextColor3 = Color3.fromRGB(255, 255, 255)
LauncherText.TextSize = 11
LauncherText.Text = "eynz    Actions"
LauncherText.Rotation = 90
LauncherText.ZIndex = 11
LauncherText.Parent = Launcher

---------------------------------------------------------------------
-- 2. MAIN MENU PANEL
---------------------------------------------------------------------
local PANEL_WIDTH = 185
local PANEL_HEIGHT_SCALE = 0.5

local MenuPanel = Instance.new("Frame")
MenuPanel.Name = "MenuPanel"
MenuPanel.AnchorPoint = Vector2.new(1, 0.5)
MenuPanel.Position = UDim2.new(1, PANEL_WIDTH + 40, 0.4, 0)
MenuPanel.Size = UDim2.new(0, PANEL_WIDTH, PANEL_HEIGHT_SCALE, 0)
MenuPanel.BackgroundColor3 = Color3.fromRGB(32, 43, 56)
MenuPanel.BackgroundTransparency = 0.25
MenuPanel.BorderSizePixel = 0
MenuPanel.ClipsDescendants = true
MenuPanel.Visible = false
MenuPanel.ZIndex = 5
MenuPanel.Parent = ScreenGui

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(180, 205, 230)
MenuStroke.Transparency = 0.8
MenuStroke.Thickness = 1
MenuStroke.Parent = MenuPanel

local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, -12, 0, 26)
TabBar.Position = UDim2.new(0, 6, 0, 6)
TabBar.BackgroundTransparency = 1
TabBar.ZIndex = 6
TabBar.Parent = MenuPanel

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabBar

local ActionsTabBtn = Instance.new("TextButton")
ActionsTabBtn.Name = "ActionsTab"
ActionsTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
ActionsTabBtn.BackgroundColor3 = Color3.fromRGB(48, 62, 80)
ActionsTabBtn.BackgroundTransparency = 0.2
ActionsTabBtn.BorderSizePixel = 0
ActionsTabBtn.Font = Enum.Font.GothamBold
ActionsTabBtn.Text = "ACTIONS"
ActionsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionsTabBtn.TextSize = 10
ActionsTabBtn.ZIndex = 7
ActionsTabBtn.Parent = TabBar

local SettingsTabBtn = Instance.new("TextButton")
SettingsTabBtn.Name = "SettingsTab"
SettingsTabBtn.Size = UDim2.new(0.48, 0, 1, 0)
SettingsTabBtn.BackgroundColor3 = Color3.fromRGB(24, 32, 42)
SettingsTabBtn.BackgroundTransparency = 0.5
SettingsTabBtn.BorderSizePixel = 0
SettingsTabBtn.Font = Enum.Font.GothamBold
SettingsTabBtn.Text = "SETTINGS"
SettingsTabBtn.TextColor3 = Color3.fromRGB(170, 180, 195)
SettingsTabBtn.TextSize = 10
SettingsTabBtn.ZIndex = 7
SettingsTabBtn.Parent = TabBar

local ActionsCorner = Instance.new("UICorner")
ActionsCorner.CornerRadius = UDim.new(0, 4)
ActionsCorner.Parent = ActionsTabBtn

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 4)
SettingsCorner.Parent = SettingsTabBtn

-- Pages Holder
local PagesHolder = Instance.new("Frame")
PagesHolder.Name = "PagesHolder"
PagesHolder.Size = UDim2.new(1, -12, 1, -64)
PagesHolder.Position = UDim2.new(0, 6, 0, 36)
PagesHolder.BackgroundTransparency = 1
PagesHolder.ClipsDescendants = true
PagesHolder.ZIndex = 6
PagesHolder.Parent = MenuPanel

local function createScrollContainer(name)
    local container = Instance.new("ScrollingFrame")
    container.Name = name
    container.Size = UDim2.new(1, 0, 1, 0)
    container.Position = UDim2.new(0, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 2
    container.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    container.ScrollBarImageTransparency = 0.5
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.ClipsDescendants = true
    container.ZIndex = 7
    container.Parent = PagesHolder

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = container

    return container
end

local ActionsContent = createScrollContainer("ActionsContent")
local SettingsContent = createScrollContainer("SettingsContent")
SettingsContent.Visible = false

---------------------------------------------------------------------
-- 3. FIXED BOTTOM STATUS BAR (FPS, PING & CREDITS)
---------------------------------------------------------------------
local BottomBar = Instance.new("Frame")
BottomBar.Name = "BottomStatusBar"
BottomBar.Position = UDim2.new(0, 6, 1, -24)
BottomBar.Size = UDim2.new(1, -12, 0, 18)
BottomBar.BackgroundColor3 = Color3.fromRGB(24, 34, 46)
BottomBar.BackgroundTransparency = 0.35
BottomBar.BorderSizePixel = 0
BottomBar.ZIndex = 7
BottomBar.Parent = MenuPanel

local BottomBarCorner = Instance.new("UICorner")
BottomBarCorner.CornerRadius = UDim.new(0, 4)
BottomBarCorner.Parent = BottomBar

local BottomBarStroke = Instance.new("UIStroke")
BottomBarStroke.Color = Color3.fromRGB(180, 205, 230)
BottomBarStroke.Transparency = 0.85
BottomBarStroke.Thickness = 1
BottomBarStroke.Parent = BottomBar

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Name = "StatsLabel"
StatsLabel.Position = UDim2.new(0, 5, 0, 0)
StatsLabel.Size = UDim2.new(0.6, 0, 1, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Font = Enum.Font.GothamMedium
StatsLabel.TextSize = 9
StatsLabel.TextColor3 = Color3.fromRGB(185, 205, 225)
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.Text = "FPS: -- | Ping: --ms"
StatsLabel.ZIndex = 8
StatsLabel.Parent = BottomBar

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Name = "CreditLabel"
CreditLabel.Position = UDim2.new(0.6, 0, 0, 0)
CreditLabel.Size = UDim2.new(0.4, -5, 1, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.TextSize = 9
CreditLabel.TextColor3 = Color3.fromRGB(130, 155, 175)
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.Text = "by 1eyn"
CreditLabel.ZIndex = 8
CreditLabel.Parent = BottomBar

local frameCount = 0
local fpsTimer = 0

local perfConnection
perfConnection = RunService.RenderStepped:Connect(function(dt)
    frameCount = frameCount + 1
    fpsTimer = fpsTimer + dt

    if fpsTimer >= 0.5 then
        local currentFPS = math.round(frameCount / fpsTimer)
        local currentPing = 0

        pcall(function()
            if LocalPlayer and LocalPlayer.GetNetworkPing then
                currentPing = math.round(LocalPlayer:GetNetworkPing() * 1000)
            end
        end)

        if currentPing <= 0 then
            pcall(function()
                local item = StatsService.Network.ServerStatsItem:FindFirstChild("Data Ping")
                if item then
                    currentPing = math.round(item:GetValue())
                end
            end)
        end

        StatsLabel.Text = string.format("FPS: %d | Ping: %dms", currentFPS, currentPing)
        
        frameCount = 0
        fpsTimer = 0
    end
end)

---------------------------------------------------------------------
-- 4. HUD ELEMENTS
---------------------------------------------------------------------
local CROSSHAIR_Y = 0.45

local Crosshair = Instance.new("Frame")
Crosshair.Name = "Crosshair"
Crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
Crosshair.Position = UDim2.new(0.5, 0, CROSSHAIR_Y, 0)
Crosshair.Size = UDim2.new(0, 16, 0, 16)
Crosshair.BackgroundTransparency = 1
Crosshair.Visible = false
Crosshair.Parent = ScreenGui

local CrossH = Instance.new("Frame")
CrossH.AnchorPoint = Vector2.new(0.5, 0.5)
CrossH.Position = UDim2.new(0.5, 0, 0.5, 0)
CrossH.Size = UDim2.new(0, 16, 0, 2)
CrossH.BackgroundColor3 = Color3.fromRGB(220, 230, 240)
CrossH.BackgroundTransparency = 0.2
CrossH.BorderSizePixel = 0
CrossH.Parent = Crosshair

local CrossV = Instance.new("Frame")
CrossV.AnchorPoint = Vector2.new(0.5, 0.5)
CrossV.Position = UDim2.new(0.5, 0, 0.5, 0)
CrossV.Size = UDim2.new(0, 2, 0, 16)
CrossV.BackgroundColor3 = Color3.fromRGB(220, 230, 240)
CrossV.BackgroundTransparency = 0.2
CrossV.BorderSizePixel = 0
CrossV.Parent = Crosshair

local ShiftLockCenterIcon = Instance.new("ImageLabel")
ShiftLockCenterIcon.Name = "ShiftLockCenterIcon"
ShiftLockCenterIcon.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftLockCenterIcon.Position = UDim2.new(0.5, 0, CROSSHAIR_Y, 0)
ShiftLockCenterIcon.Size = UDim2.new(0, 32, 0, 32)
ShiftLockCenterIcon.BackgroundTransparency = 1
ShiftLockCenterIcon.Image = "rbxasset://textures/MouseLockedCursor.png"
ShiftLockCenterIcon.Visible = false
ShiftLockCenterIcon.Parent = ScreenGui

---------------------------------------------------------------------
-- 5. EMOTE WHEEL SYSTEM (R6 & R15 COMPATIBLE)
---------------------------------------------------------------------
local EMOTE_DATA = {
    { name = "Dance 1", key = "dance1", icon = "🕺", r6 = "rbxassetid://182435998", r15 = "rbxassetid://507771019", loop = true },
    { name = "Dance 2", key = "dance2", icon = "💃", r6 = "rbxassetid://182436842", r15 = "rbxassetid://507776043", loop = true },
    { name = "Dance 3", key = "dance3", icon = "✨", r6 = "rbxassetid://182436935", r15 = "rbxassetid://507777268", loop = true },
    { name = "Point",   key = "point",  icon = "👉", r6 = "rbxassetid://128853357", r15 = "rbxassetid://507770453", loop = false },
    { name = "Sit",     key = "sit",    icon = "🪑", r6 = nil,                   r15 = nil,                   loop = false },
    { name = "Laugh",   key = "laugh",  icon = "😂", r6 = "rbxassetid://129423131", r15 = "rbxassetid://507770818", loop = false },
    { name = "Cheer",   key = "cheer",  icon = "🎉", r6 = "rbxassetid://180611870", r15 = "rbxassetid://507770677", loop = false },
    { name = "Wave",    key = "wave",   icon = "👋", r6 = "rbxassetid://128777973", r15 = "rbxassetid://507770239", loop = false },
}

local currentEmoteTrack = nil
local emoteMoveConn = nil

local function stopCurrentEmote()
    if emoteMoveConn then
        emoteMoveConn:Disconnect()
        emoteMoveConn = nil
    end
    if currentEmoteTrack then
        pcall(function()
            currentEmoteTrack:Stop(0.18)
            currentEmoteTrack:Destroy()
        end)
        currentEmoteTrack = nil
    end
end

local function executeEmote(data)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end

    stopCurrentEmote()

    -- Custom Sit Action
    if data.key == "sit" then
        hum.Sit = true
        return
    end

    local isR15 = (hum.RigType == Enum.RigType.R15)
    local animId = isR15 and data.r15 or data.r6

    if animId then
        local animObj = Instance.new("Animation")
        animObj.AnimationId = animId

        local animator = hum:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = hum
        end

        local track = animator:LoadAnimation(animObj)
        track.Priority = Enum.AnimationPriority.Action
        track.Looped = data.loop
        track:Play(0.15)
        currentEmoteTrack = track

        -- Cancel emote on walk/jump
        emoteMoveConn = hum.Running:Connect(function(speed)
            if speed > 0.5 then
                stopCurrentEmote()
            end
        end)
    end
end

-- Emote Wheel UI Elements
local EmoteWheelGui = Instance.new("Frame")
EmoteWheelGui.Name = "EmoteWheel"
EmoteWheelGui.AnchorPoint = Vector2.new(0.5, 0.5)
EmoteWheelGui.Position = UDim2.new(0.5, 0, 0.5, 0)
EmoteWheelGui.Size = UDim2.new(0, 260, 0, 260)
EmoteWheelGui.BackgroundTransparency = 1
EmoteWheelGui.Visible = false
EmoteWheelGui.ZIndex = 20
EmoteWheelGui.Parent = ScreenGui

local WheelBackground = Instance.new("Frame")
WheelBackground.Name = "WheelBackground"
WheelBackground.AnchorPoint = Vector2.new(0.5, 0.5)
WheelBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
WheelBackground.Size = UDim2.new(0, 250, 0, 250)
WheelBackground.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
WheelBackground.BackgroundTransparency = 0.35
WheelBackground.BorderSizePixel = 0
WheelBackground.ZIndex = 20
WheelBackground.Parent = EmoteWheelGui

local WheelBgCorner = Instance.new("UICorner")
WheelBgCorner.CornerRadius = UDim.new(1, 0)
WheelBgCorner.Parent = WheelBackground

local WheelBgStroke = Instance.new("UIStroke")
WheelBgStroke.Color = Color3.fromRGB(180, 205, 230)
WheelBgStroke.Transparency = 0.75
WheelBgStroke.Thickness = 1.5
WheelBgStroke.Parent = WheelBackground

-- Wheel Center Close / Title Button
local WheelCenterBtn = Instance.new("TextButton")
WheelCenterBtn.Name = "CenterClose"
WheelCenterBtn.AnchorPoint = Vector2.new(0.5, 0.5)
WheelCenterBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
WheelCenterBtn.Size = UDim2.new(0, 56, 0, 56)
WheelCenterBtn.BackgroundColor3 = Color3.fromRGB(38, 52, 68)
WheelCenterBtn.BackgroundTransparency = 0.2
WheelCenterBtn.BorderSizePixel = 0
WheelCenterBtn.Font = Enum.Font.GothamBold
WheelCenterBtn.Text = "EMOTES\n(CLOSE)"
WheelCenterBtn.TextColor3 = Color3.fromRGB(220, 235, 250)
WheelCenterBtn.TextSize = 8
WheelCenterBtn.AutoButtonColor = true
WheelCenterBtn.ZIndex = 25
WheelCenterBtn.Parent = EmoteWheelGui

local CenterCorner = Instance.new("UICorner")
CenterCorner.CornerRadius = UDim.new(1, 0)
CenterCorner.Parent = WheelCenterBtn

local CenterStroke = Instance.new("UIStroke")
CenterStroke.Color = Color3.fromRGB(180, 205, 230)
CenterStroke.Transparency = 0.7
CenterStroke.Thickness = 1
CenterStroke.Parent = WheelCenterBtn

local isWheelOpen = false
local function toggleEmoteWheel(forcedState)
    if forcedState ~= nil then
        isWheelOpen = forcedState
    else
        isWheelOpen = not isWheelOpen
    end

    if isWheelOpen then
        EmoteWheelGui.Size = UDim2.new(0, 180, 0, 180)
        EmoteWheelGui.Visible = true
        TweenService:Create(EmoteWheelGui, wheelOpenTween, {Size = UDim2.new(0, 260, 0, 260)}):Play()
    else
        local closeTw = TweenService:Create(EmoteWheelGui, wheelCloseTween, {Size = UDim2.new(0, 180, 0, 180)})
        closeTw:Play()
        closeTw.Completed:Connect(function()
            if not isWheelOpen then
                EmoteWheelGui.Visible = false
            end
        end)
    end
end

WheelCenterBtn.MouseButton1Click:Connect(function()
    toggleEmoteWheel(false)
end)

-- Distribute Emote Buttons in Circle
local RADIUS = 92
local totalEmotes = #EMOTE_DATA

for index, emoteInfo in ipairs(EMOTE_DATA) do
    local angle = ((index - 1) / totalEmotes) * (2 * math.pi) - (math.pi / 2)
    local xOffset = math.cos(angle) * RADIUS
    local yOffset = math.sin(angle) * RADIUS

    local nodeBtn = Instance.new("TextButton")
    nodeBtn.Name = "EmoteNode_" .. emoteInfo.key
    nodeBtn.AnchorPoint = Vector2.new(0.5, 0.5)
    nodeBtn.Position = UDim2.new(0.5, xOffset, 0.5, yOffset)
    nodeBtn.Size = UDim2.new(0, 48, 0, 48)
    nodeBtn.BackgroundColor3 = Color3.fromRGB(34, 46, 62)
    nodeBtn.BackgroundTransparency = 0.25
    nodeBtn.BorderSizePixel = 0
    nodeBtn.Text = emoteInfo.icon .. "\n" .. emoteInfo.name
    nodeBtn.Font = Enum.Font.GothamMedium
    nodeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    nodeBtn.TextSize = 8
    nodeBtn.AutoButtonColor = true
    nodeBtn.ZIndex = 23
    nodeBtn.Parent = EmoteWheelGui

    local nodeCorner = Instance.new("UICorner")
    nodeCorner.CornerRadius = UDim.new(1, 0)
    nodeCorner.Parent = nodeBtn

    local nodeStroke = Instance.new("UIStroke")
    nodeStroke.Color = Color3.fromRGB(180, 205, 230)
    nodeStroke.Transparency = 0.8
    nodeStroke.Thickness = 1
    nodeStroke.Parent = nodeBtn

    nodeBtn.MouseButton1Click:Connect(function()
        executeEmote(emoteInfo)
        toggleEmoteWheel(false)
    end)
end

---------------------------------------------------------------------
-- 6. UI BUILDERS
---------------------------------------------------------------------
local function createButton(parent, name, text, color, callback, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = color or Color3.fromRGB(48, 62, 80)
    btn.BackgroundTransparency = 0.35
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.AutoButtonColor = true
    btn.LayoutOrder = order or 1
    btn.ZIndex = 8
    btn.Parent = parent

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(parent, name, text, defaultState, callback, order)
    local state = defaultState or false
    
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = state and Color3.fromRGB(38, 92, 90) or Color3.fromRGB(48, 62, 80)
    btn.BackgroundTransparency = 0.35
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text .. ": " .. (state and "ON" or "OFF")
    btn.TextColor3 = state and Color3.fromRGB(170, 255, 220) or Color3.fromRGB(220, 225, 230)
    btn.TextSize = 11
    btn.AutoButtonColor = true
    btn.LayoutOrder = order or 1
    btn.ZIndex = 8
    btn.Parent = parent

    local function updateVisuals()
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(38, 92, 90) or Color3.fromRGB(48, 62, 80)
        btn.TextColor3 = state and Color3.fromRGB(170, 255, 220) or Color3.fromRGB(220, 225, 230)
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateVisuals()
        callback(state)
    end)
    
    return {
        SetStateQuietly = function(newState)
            state = newState
            updateVisuals()
        end
    }
end

---------------------------------------------------------------------
-- 7. TAB SWITCHING
---------------------------------------------------------------------
local currentTab = "Actions"

local function switchTab(tabName)
    if currentTab == tabName then return end
    currentTab = tabName

    if tabName == "Actions" then
        TweenService:Create(ActionsTabBtn, fastTween, {BackgroundColor3 = Color3.fromRGB(48, 62, 80), BackgroundTransparency = 0.2}):Play()
        ActionsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        TweenService:Create(SettingsTabBtn, fastTween, {BackgroundColor3 = Color3.fromRGB(24, 32, 42), BackgroundTransparency = 0.5}):Play()
        SettingsTabBtn.TextColor3 = Color3.fromRGB(170, 180, 195)

        SettingsContent.Visible = false
        ActionsContent.Visible = true
    else
        TweenService:Create(SettingsTabBtn, fastTween, {BackgroundColor3 = Color3.fromRGB(48, 62, 80), BackgroundTransparency = 0.2}):Play()
        SettingsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        TweenService:Create(ActionsTabBtn, fastTween, {BackgroundColor3 = Color3.fromRGB(24, 32, 42), BackgroundTransparency = 0.5}):Play()
        ActionsTabBtn.TextColor3 = Color3.fromRGB(170, 180, 195)

        ActionsContent.Visible = false
        SettingsContent.Visible = true
    end
end

ActionsTabBtn.MouseButton1Click:Connect(function() switchTab("Actions") end)
SettingsTabBtn.MouseButton1Click:Connect(function() switchTab("Settings") end)

---------------------------------------------------------------------
-- 8. FEATURE LOGIC & IMPLEMENTATIONS
---------------------------------------------------------------------

-- [A] Auto Jump Logic
local autoJumpEnabled = true
local function setAutoJump(val)
    autoJumpEnabled = val
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").AutoJumpEnabled = val
    end
end

-- [B] Zero-Latency Smooth Shift Lock
local isShiftLock = false
local shiftLockOffset = Vector3.new(1.75, 0.25, 0)
local defaultOffset = Vector3.new(0, 0, 0)

local function toggleShiftLock(state)
    isShiftLock = state
    ShiftLockCenterIcon.Visible = state

    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.CameraOffset = state and shiftLockOffset or defaultOffset
        hum.AutoRotate = not state
    end
end

RunService:BindToRenderStep("StableShiftLock", Enum.RenderPriority.Character.Value, function()
    if isShiftLock then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if root and hum and hum.Health > 0 then
            hum.AutoRotate = false
            
            local look = Camera.CFrame.LookVector
            local flatLook = Vector3.new(look.X, 0, look.Z)
            
            if flatLook.Magnitude > 0.001 then
                root.CFrame = CFrame.lookAt(root.Position, root.Position + flatLook.Unit)
            end
        end
    end
end)

local charAddedConn
charAddedConn = LocalPlayer.CharacterAdded:Connect(function(char)
    stopCurrentEmote()
    local hum = char:WaitForChild("Humanoid", 6)
    if hum then
        hum.AutoJumpEnabled = autoJumpEnabled
        if isShiftLock then
            hum.CameraOffset = shiftLockOffset
            hum.AutoRotate = false
        end
    end
end)

-- [C] Camera Toggle Logic
local isCameraToggle = false
local camOffsetLerp = 0
local TARGET_CAM_OFFSET = Vector3.new(1.75, 0.25, 0)

local function toggleCameraMode(state)
    isCameraToggle = state
    Crosshair.Visible = state
    
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum and not isShiftLock then
        hum.CameraOffset = defaultOffset
        hum.AutoRotate = true
    end
end

RunService:BindToRenderStep("PCCameraToggleStep", Enum.RenderPriority.Camera.Value + 1, function(dt)
    local targetVal = isCameraToggle and 1 or 0
    camOffsetLerp = camOffsetLerp + (targetVal - camOffsetLerp) * math.clamp(dt * 14, 0, 1)

    if camOffsetLerp > 0.001 and not isShiftLock then
        local offset = TARGET_CAM_OFFSET * camOffsetLerp
        Camera.CFrame = Camera.CFrame * CFrame.new(offset)
    end
end)

-- [D] Performance Stats
local function togglePerfStats()
    local success = pcall(function()
        local ugs = UserSettings():GetService("UserGameSettings")
        ugs.PerformanceStatsVisible = not ugs.PerformanceStatsVisible
    end)
    if not success then
        pcall(function()
            local gs = settings():GetService("GameSettings")
            gs.PerformanceStatsVisible = not gs.PerformanceStatsVisible
        end)
    end
end

-- [E] Quick Reset
local function quickReset()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Health = 0
        else
            char:BreakJoints()
        end
    end
end

-- [F] Rejoin
local function rejoinGame()
    task.wait(0.1)
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end

-- [G] Server Hop
local function serverHop()
    task.wait(0.1)
    pcall(function()
        local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
        if req then
            local serversApi = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
            local res = req({Url = serversApi, Method = "GET"})
            local data = HttpService:JSONDecode(res.Body)
            
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if typeof(server) == "table" and server.playing and server.maxPlayers and server.id then
                        if server.playing < server.maxPlayers and tostring(server.id) ~= tostring(game.JobId) then
                            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                            return
                        end
                    end
                end
            end
        end
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

-- [H] Mute Game
local isMuted = false
local function toggleMuteGame(state)
    isMuted = state
    pcall(function()
        local ugs = UserSettings():GetService("UserGameSettings")
        ugs.MasterVolume = isMuted and 0 or 1
    end)
    pcall(function()
        local gs = settings():GetService("GameSettings")
        gs.MasterVolume = isMuted and 0 or 1
    end)
    pcall(function()
        SoundService.Volume = isMuted and 0 or 1
    end)
end

-- [I] Destroy Everything
local function destroyEverything()
    stopCurrentEmote()

    pcall(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.CameraOffset = defaultOffset
            hum.AutoRotate = true
        end
    end)

    pcall(function() RunService:UnbindFromRenderStep("StableShiftLock") end)
    pcall(function() RunService:UnbindFromRenderStep("PCCameraToggleStep") end)

    if perfConnection then
        perfConnection:Disconnect()
    end

    if charAddedConn then
        charAddedConn:Disconnect()
    end

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

---------------------------------------------------------------------
-- 9. POPULATE BUTTONS
---------------------------------------------------------------------

-- Actions Tab
createToggle(ActionsContent, "AutoJumpToggle", "Auto Jump", true, setAutoJump, 1)
createToggle(ActionsContent, "ShiftLockToggle", "Shift Lock", false, toggleShiftLock, 2)
createToggle(ActionsContent, "CamToggle", "Camera Toggle", false, toggleCameraMode, 3)
createButton(ActionsContent, "EmoteWheelBtn", "Emote Wheel", Color3.fromRGB(48, 62, 80), function()
    toggleEmoteWheel()
end, 4)
createButton(ActionsContent, "PerfStatsBtn", "Toggle Perf Stats", Color3.fromRGB(48, 62, 80), togglePerfStats, 5)
createButton(ActionsContent, "ResetBtn", "Reset", Color3.fromRGB(110, 45, 45), quickReset, 6)
createButton(ActionsContent, "RejoinBtn", "Rejoin", Color3.fromRGB(48, 62, 80), rejoinGame, 7)
createButton(ActionsContent, "HopBtn", "Server Hop", Color3.fromRGB(48, 62, 80), serverHop, 8)

-- Settings Tab
createToggle(SettingsContent, "MuteGameToggle", "Mute Game", false, toggleMuteGame, 1)
createButton(SettingsContent, "DestroyBtn", "Destroy Everything", Color3.fromRGB(130, 35, 35), destroyEverything, 2)

---------------------------------------------------------------------
-- 10. SLIDE ANIMATION LOGIC
---------------------------------------------------------------------
local isMenuOpen = false
local slideTweenObj

Launcher.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    
    if slideTweenObj then
        slideTweenObj:Cancel()
    end

    if isMenuOpen then
        MenuPanel.Visible = true
        local targetPos = UDim2.new(1, -28, 0.4, 0)
        slideTweenObj = TweenService:Create(MenuPanel, slideTween, {Position = targetPos})
        slideTweenObj:Play()
        TweenService:Create(Launcher, slideTween, {BackgroundTransparency = 0.15}):Play()
    else
        local targetPos = UDim2.new(1, PANEL_WIDTH + 40, 0.4, 0)
        slideTweenObj = TweenService:Create(MenuPanel, slideTween, {Position = targetPos})
        slideTweenObj:Play()
        TweenService:Create(Launcher, slideTween, {BackgroundTransparency = 0.35}):Play()
        
        slideTweenObj.Completed:Connect(function()
            if not isMenuOpen then
                MenuPanel.Visible = false
            end
        end)
    end
end)
