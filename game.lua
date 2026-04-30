-- =========================
-- getNil function
-- =========================
function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end

-- =========================
-- Services
-- =========================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local requestEquip = ReplicatedStorage.Remotes.RequestEquip
local useTool = ReplicatedStorage.Remotes.UseTool

-- =========================
-- Tool spam loop (Food only)
-- =========================
task.spawn(function()
    while true do
        useTool:FireServer("Food")
        task.wait(0.01)
    end
end)

-- =========================
-- Food equip cycle
-- =========================
task.spawn(function()
    while true do
        requestEquip:FireServer("Food", 50)
        task.wait(10)
        requestEquip:FireServer("Food", 51)
        task.wait(900) -- 15 minutes
    end
end)

-- =========================
-- Anti AFK
-- =========================
-- Method 1: Disable idle connections
local GC = getconnections or get_signal_cons
if GC then
    for _, v in pairs(GC(LocalPlayer.Idled)) do
        if v.Disable then
            v.Disable(v)
        elseif v.Disconnect then
            v.Disconnect(v)
        end
    end
else
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- Method 2: Simulate input when idle
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- =========================
-- Auto Rejoin System (Improved)
-- =========================
local MAX_RETRIES = 5
local RETRY_DELAY = 3               -- Retry every 3 seconds
local RECONNECT_COOLDOWN = 60       -- 1 minute cooldown after 5 failures

local retryCount = 0
local lastReconnectTime = 0

local function safeRejoin()
    local currentTime = os.time()

    -- Cooldown check
    if currentTime - lastReconnectTime < RECONNECT_COOLDOWN then
        return
    end

    -- Prevent overlapping rejoin loops
    if retryCount > 0 then
        return
    end

    lastReconnectTime = currentTime
    retryCount = 0

    -- First attempt is immediate, then retries every RETRY_DELAY seconds
    while retryCount < MAX_RETRIES do
        retryCount += 1
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        task.wait(RETRY_DELAY)
    end

    retryCount = 0
end

-- Trigger on teleport failure (immediate rejoin)
LocalPlayer.OnTeleport:Connect(function(teleportState)
    if teleportState == Enum.TeleportState.Failed then
        safeRejoin()
    end
end)

-- Backup trigger for error prompts
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        safeRejoin()
    end
end)
