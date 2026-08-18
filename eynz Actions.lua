-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- // Queue On Teleport Handler
local queueTeleport = (syn and syn.queue_on_teleport) 
    or queue_on_teleport 
    or (fluxus and fluxus.queue_on_teleport) 
    or (queue_teleport)

local function queueScriptExecution()
    local reExecCode
    if getgenv and getgenv().QoL_ScriptUrl then
        reExecCode = string.format("loadstring(game:HttpGet(%q))()", getgenv().QoL_ScriptUrl)
    elseif getgenv and getgenv().QoL_ScriptSource then
        reExecCode = getgenv().QoL_ScriptSource
    end

    if queueTeleport and reExecCode then
        pcall(function()
            queueTeleport(reExecCode)
        end)
    end
end

-- Hook into OnTeleport as a secondary safeguard
pcall(function()
    LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Started then
            queueScriptExecution()
        end
    end)
end)

-- Safe UI Container
local ParentGui
if gethui then
    ParentGui = gethui()
elseif game:GetService("CoreGui") then
    ParentGui = game:GetService("CoreGui")
else
    ParentGui = LocalPlayer:WaitForChild("PlayerGui")
end

-- Cleanup existing instances
if ParentGui:FindFirstChild("MobileQoL_UI") then
    ParentGui.MobileQoL_UI:Destroy()
end

-- // ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileQoL_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentGui

-- // TWEEN PRESETS
local fastTween = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local slideTween = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

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
LauncherText.Text = "eynz Actions"
LauncherText.Rotation = 90
LauncherText.ZIndex = 11
LauncherText.Parent = Launcher

---------------------------------------------------------------------
-- 2. MAIN MENU PANEL (Slide-Out Container)
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

-- Top Tab Navigation Bar
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

-- Tab Viewport / Pages Container
local PagesHolder = Instance.new("Frame")
PagesHolder.Name = "PagesHolder"
PagesHolder.Size = UDim2.new(1, -12, 1, -40)
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
-- 3. VISUAL HUD ELEMENTS (Crosshair & Shiftlock Indicator)
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
-- 4. UI BUILDERS (Buttons & Toggles)
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
-- 5. TAB SWITCHING SYSTEM
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

ActionsTabBtn.MouseButton1Click:Connect(function()
    switchTab("Actions")
end)

SettingsTabBtn.MouseButton1Click:Connect(function()
    switchTab("Settings")
end)

---------------------------------------------------------------------
-- 6. FEATURE LOGIC & IMPLEMENTATIONS
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

local charAddedConn
charAddedConn = LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 6)
    if hum then
        hum.AutoJumpEnabled = autoJumpEnabled
    end
end)

-- [B] Shift Lock
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

RunService:BindToRenderStep("SmoothShiftLockStep", Enum.RenderPriority.Character.Value + 1, function()
    if isShiftLock then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if root and hum and hum.Health > 0 then
            hum.AutoRotate = false
            local _, y = Camera.CFrame.Rotation:ToEulerAnglesYXZ()
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, y, 0)
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

-- [D] Quick Leaderboard Toggle (Fixed)
local leaderboardOpenFallback = false
local function toggleLeaderboard()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
    end)
    
    local success, currentStatus = pcall(function()
        return StarterGui:GetCore("PlayerListIsOpen")
    end)
    
    if success and typeof(currentStatus) == "boolean" then
        pcall(function()
            StarterGui:SetCore("PlayerListIsOpen", not currentStatus)
        end)
    else
        leaderboardOpenFallback = not leaderboardOpenFallback
        pcall(function()
            StarterGui:SetCore("PlayerListIsOpen", leaderboardOpenFallback)
        end)
    end
end

-- [E] Performance Stats
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

-- [F] Quick Reset
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

-- [G] Rejoin (With Auto-Queue Script Execution)
local function rejoinGame()
    queueScriptExecution()
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\n[eynz Actions] Rejoining...")
            task.wait(0.5)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end

-- [H] Server Hop (With Auto-Queue Script Execution)
local function serverHop()
    queueScriptExecution()
    pcall(function()
        local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
        if req then
            local serversApi = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local res = req({Url = serversApi, Method = "GET"})
            local data = HttpService:JSONDecode(res.Body)
            
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return
                    end
                end
            end
        else
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end

-- [I] Mute Game (Settings)
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

-- [J] Destroy Everything (Settings)
local function destroyEverything()
    pcall(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.CameraOffset = defaultOffset
            hum.AutoRotate = true
        end
    end)

    pcall(function() RunService:UnbindFromRenderStep("SmoothShiftLockStep") end)
    pcall(function() RunService:UnbindFromRenderStep("PCCameraToggleStep") end)

    if charAddedConn then
        charAddedConn:Disconnect()
    end

    if ScreenGui then
        ScreenGui:Destroy()
    end
end

---------------------------------------------------------------------
-- 7. POPULATE BUTTONS
---------------------------------------------------------------------

-- Actions Tab
createToggle(ActionsContent, "AutoJumpToggle", "Auto Jump", true, setAutoJump, 1)
createToggle(ActionsContent, "ShiftLockToggle", "Shift Lock", false, toggleShiftLock, 2)
createToggle(ActionsContent, "CamToggle", "Camera Toggle", false, toggleCameraMode, 3)
createButton(ActionsContent, "LeaderboardBtn", "Quick Leaderboard", Color3.fromRGB(48, 62, 80), toggleLeaderboard, 4)
createButton(ActionsContent, "PerfStatsBtn", "Toggle Perf Stats", Color3.fromRGB(48, 62, 80), togglePerfStats, 5)
createButton(ActionsContent, "ResetBtn", "Reset", Color3.fromRGB(110, 45, 45), quickReset, 6)
createButton(ActionsContent, "RejoinBtn", "Rejoin", Color3.fromRGB(48, 62, 80), rejoinGame, 7)
createButton(ActionsContent, "HopBtn", "Server Hop", Color3.fromRGB(48, 62, 80), serverHop, 8)

-- Settings Tab
createToggle(SettingsContent, "MuteGameToggle", "Mute Game", false, toggleMuteGame, 1)
createButton(SettingsContent, "DestroyBtn", "Destroy Everything", Color3.fromRGB(130, 35, 35), destroyEverything, 2)

---------------------------------------------------------------------
-- 8. SLIDE ANIMATION LOGIC
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
