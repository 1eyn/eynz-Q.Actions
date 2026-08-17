-- // Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Parent GUI safely
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
ScreenGui.IgnoreGuiInset = true -- Ensures crosshairs align perfectly with simulated mouse
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentGui

-- // TWEEN SETTINGS
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

---------------------------------------------------------------------
-- 1. LAUNCHER (Moved Up & Made Shorter)
---------------------------------------------------------------------
local Launcher = Instance.new("TextButton")
Launcher.Name = "Launcher"
Launcher.AnchorPoint = Vector2.new(1, 0.5)
Launcher.Position = UDim2.new(1, 0, 0.4, 0) -- Moved higher up
Launcher.Size = UDim2.new(0, 26, 0.45, 0) -- Made the length significantly shorter
Launcher.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Launcher.BackgroundTransparency = 0.35
Launcher.BorderSizePixel = 0
Launcher.Text = ""
Launcher.AutoButtonColor = false
Launcher.Parent = ScreenGui

local LauncherCorner = Instance.new("UICorner")
LauncherCorner.CornerRadius = UDim.new(0, 10)
LauncherCorner.Parent = Launcher

local LauncherStroke = Instance.new("UIStroke")
LauncherStroke.Color = Color3.fromRGB(255, 255, 255)
LauncherStroke.Transparency = 0.8
LauncherStroke.Thickness = 1
LauncherStroke.Parent = Launcher

-- Vertical "QUICK ACTIONS" Text
local LauncherText = Instance.new("TextLabel")
LauncherText.Name = "VerticalText"
LauncherText.Size = UDim2.new(1, 0, 1, 0)
LauncherText.BackgroundTransparency = 1
LauncherText.Font = Enum.Font.GothamBold
LauncherText.TextColor3 = Color3.fromRGB(255, 255, 255)
LauncherText.TextSize = 10
LauncherText.TextWrapped = true
LauncherText.Text = "Q\nU\nI\nC\nK\n\nA\nC\nT\nI\nO\nN\nS"
LauncherText.Parent = Launcher

---------------------------------------------------------------------
-- 2. MAIN MENU PANEL
---------------------------------------------------------------------
local MenuPanel = Instance.new("Frame")
MenuPanel.Name = "MenuPanel"
MenuPanel.AnchorPoint = Vector2.new(1, 0.5)
MenuPanel.Position = UDim2.new(1, 0, 0.4, 0) -- Matches Launcher position
MenuPanel.Size = UDim2.new(0, 0, 0.5, 0) -- Matches shorter height visually
MenuPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MenuPanel.BackgroundTransparency = 0.35
MenuPanel.BorderSizePixel = 0
MenuPanel.ClipsDescendants = true
MenuPanel.Parent = ScreenGui

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 14)
MenuCorner.Parent = MenuPanel

local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(255, 255, 255)
MenuStroke.Transparency = 0.85
MenuStroke.Thickness = 1
MenuStroke.Parent = MenuPanel

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Name = "Content"
ContentContainer.Size = UDim2.new(1, -12, 1, -16)
ContentContainer.Position = UDim2.new(0, 8, 0, 8)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.ScrollBarThickness = 2
ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ContentContainer.ScrollBarImageTransparency = 0.5
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentContainer.Parent = MenuPanel

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 7)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentContainer

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 24)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "QUICK ACTIONS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.LayoutOrder = 0
Title.Parent = ContentContainer

---------------------------------------------------------------------
-- 3. CROSSHAIR & POINTER ELEMENTS (Moved slightly up)
---------------------------------------------------------------------
-- Camera Toggle Crosshair
local Crosshair = Instance.new("Frame")
Crosshair.Name = "Crosshair"
Crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
Crosshair.Position = UDim2.new(0.5, 0, 0.42, 0) -- Moved up from 0.5
Crosshair.Size = UDim2.new(0, 16, 0, 16)
Crosshair.BackgroundTransparency = 1
Crosshair.Visible = false
Crosshair.Parent = ScreenGui

local CrossH = Instance.new("Frame")
CrossH.AnchorPoint = Vector2.new(0.5, 0.5)
CrossH.Position = UDim2.new(0.5, 0, 0.5, 0)
CrossH.Size = UDim2.new(0, 16, 0, 2)
CrossH.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CrossH.BackgroundTransparency = 0.35
CrossH.BorderSizePixel = 0
CrossH.Parent = Crosshair

local CrossV = Instance.new("Frame")
CrossV.AnchorPoint = Vector2.new(0.5, 0.5)
CrossV.Position = UDim2.new(0.5, 0, 0.5, 0)
CrossV.Size = UDim2.new(0, 2, 0, 16)
CrossV.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CrossV.BackgroundTransparency = 0.35
CrossV.BorderSizePixel = 0
CrossV.Parent = Crosshair

-- Touch Pointer Dot
local TouchPointer = Instance.new("Frame")
TouchPointer.Name = "TouchPointer"
TouchPointer.AnchorPoint = Vector2.new(0.5, 0.5)
TouchPointer.Position = UDim2.new(0.5, 0, 0.42, 0) -- Moved up from 0.5
TouchPointer.Size = UDim2.new(0, 6, 0, 6)
TouchPointer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TouchPointer.BorderSizePixel = 0
TouchPointer.Visible = false
TouchPointer.Parent = ScreenGui

local PointerCorner = Instance.new("UICorner")
PointerCorner.CornerRadius = UDim.new(1, 0)
PointerCorner.Parent = TouchPointer

---------------------------------------------------------------------
-- 4. FLOATING SHIFT LOCK BUTTON (Original Icon)
---------------------------------------------------------------------
local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Name = "FloatingShiftLock"
ShiftLockButton.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftLockButton.Size = UDim2.new(0, 45, 0, 45)
ShiftLockButton.Position = UDim2.new(1, -120, 1, -120) -- Standard mobile offset
ShiftLockButton.BackgroundTransparency = 1
ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off.png" -- Original off icon
ShiftLockButton.Parent = ScreenGui

---------------------------------------------------------------------
-- 5. BUTTON CREATION HELPERS
---------------------------------------------------------------------
local function createButton(name, text, color, callback, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    btn.AutoButtonColor = true
    btn.LayoutOrder = order or 1
    btn.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(name, text, defaultState, callback, order)
    local state = defaultState or false
    
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = state and Color3.fromRGB(35, 90, 45) or Color3.fromRGB(45, 45, 45)
    btn.BackgroundTransparency = 0.4
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text .. ": " .. (state and "ON" or "OFF")
    btn.TextColor3 = state and Color3.fromRGB(160, 255, 160) or Color3.fromRGB(220, 220, 220)
    btn.TextSize = 11
    btn.AutoButtonColor = true
    btn.LayoutOrder = order or 1
    btn.Parent = ContentContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = btn

    local function updateVisuals()
        btn.Text = text .. ": " .. (state and "ON" or "OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(35, 90, 45) or Color3.fromRGB(45, 45, 45)
        btn.TextColor3 = state and Color3.fromRGB(160, 255, 160) or Color3.fromRGB(220, 220, 220)
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
-- 6. FEATURE LOGIC
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

LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid", 6)
    if hum then
        hum.AutoJumpEnabled = autoJumpEnabled
    end
end)

-- [B] Shift Lock Logic
local isShiftLock = false
local shiftLockOffset = Vector3.new(1.75, 0.3, 0)
local defaultOffset = Vector3.new(0, 0, 0)
local shiftLockToggleRef = nil

local function toggleShiftLock(state)
    isShiftLock = state
    ShiftLockButton.Image = state and "rbxasset://textures/ui/mouseLock_on.png" or "rbxasset://textures/ui/mouseLock_off.png"
    
    if shiftLockToggleRef then
        shiftLockToggleRef.SetStateQuietly(state)
    end

    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.CameraOffset = state and shiftLockOffset or defaultOffset
        hum.AutoRotate = not state
    end
end

ShiftLockButton.MouseButton1Click:Connect(function()
    toggleShiftLock(not isShiftLock)
end)

RunService.RenderStepped:Connect(function()
    if isShiftLock then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local _, y = Camera.CFrame.Rotation:ToEulerAnglesYXZ()
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, y, 0)
        end
    end
end)

-- [C] Camera Toggle Logic (Moves Right but preserves 3rd Person rotation)
local isCameraToggle = false
local cameraTween = nil

local function toggleCameraMode(state)
    isCameraToggle = state
    Crosshair.Visible = state

    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if cameraTween then cameraTween:Cancel() end
        -- Offset to right like shift lock, but without turning off AutoRotate
        local targetOffset = state and Vector3.new(1.75, 0.3, 0) or Vector3.new(0, 0, 0)
        cameraTween = TweenService:Create(hum, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CameraOffset = targetOffset
        })
        cameraTween:Play()
    end
end

-- [D] Touch Pointer (Virtual Hover Simulator)
local isTouchPointer = false
local function toggleTouchPointer(state)
    isTouchPointer = state
    TouchPointer.Visible = state
end

-- Force virtual pointer to perfectly follow the visual touch pointer dot!
RunService.RenderStepped:Connect(function()
    if isTouchPointer then
        local pointerPos = TouchPointer.AbsolutePosition + (TouchPointer.AbsoluteSize / 2)
        pcall(function()
            VirtualInputManager:SendMouseMoveEvent(pointerPos.X, pointerPos.Y, workspace)
        end)
    end
end)

-- [E] Performance Stats
local function togglePerfStats()
    pcall(function()
        local gs = settings():GetService("GameSettings")
        gs.PerformanceStatsVisible = not gs.PerformanceStatsVisible
    end)
end

-- [F] Reset
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

-- [G] Rejoin
local function rejoinGame()
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            LocalPlayer:Kick("\n[QoL] Rejoining...")
            task.wait(0.5)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)
end

-- [H] Server Hop
local function serverHop()
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

---------------------------------------------------------------------
-- 7. POPULATE UI BUTTONS
---------------------------------------------------------------------
createToggle("AutoJumpToggle", "Auto Jump", true, setAutoJump, 1)

-- Sync the menu shiftlock toggle visually with the floating button
shiftLockToggleRef = createToggle("ShiftLockToggle", "Shift Lock", false, toggleShiftLock, 2)

createToggle("CamToggle", "Camera Toggle", false, toggleCameraMode, 3)
createToggle("TouchPointerToggle", "Touch Pointer", false, toggleTouchPointer, 4)
createButton("PerfStatsBtn", "Toggle Perf Stats", Color3.fromRGB(45, 45, 45), togglePerfStats, 5)
createButton("ResetBtn", "Reset", Color3.fromRGB(95, 35, 35), quickReset, 6)
createButton("RejoinBtn", "Rejoin", Color3.fromRGB(45, 45, 45), rejoinGame, 7)
createButton("HopBtn", "Server Hop", Color3.fromRGB(45, 45, 45), serverHop, 8)

---------------------------------------------------------------------
-- 8. MENU EXPAND / COLLAPSE ANIMATION
---------------------------------------------------------------------
local isMenuOpen = false
local panelWidth = 180 -- Optimal width for mobile thumb access

Launcher.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    
    if isMenuOpen then
        -- Expand from right to left (respects the new 0.4 y-position and 0.5 height)
        local targetSize = UDim2.new(0, panelWidth, 0.5, 0)
        local targetPos = UDim2.new(1, -28, 0.4, 0)
        
        TweenService:Create(MenuPanel, tweenInfo, {Size = targetSize, Position = targetPos}):Play()
        TweenService:Create(Launcher, tweenInfo, {BackgroundTransparency = 0.15}):Play()
    else
        -- Collapse back into the right edge
        local targetSize = UDim2.new(0, 0, 0.5, 0)
        local targetPos = UDim2.new(1, 0, 0.4, 0)
        
        TweenService:Create(MenuPanel, tweenInfo, {Size = targetSize, Position = targetPos}):Play()
        TweenService:Create(Launcher, tweenInfo, {BackgroundTransparency = 0.35}):Play()
    end
end)
