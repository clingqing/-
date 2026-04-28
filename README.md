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
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local useTool = ReplicatedStorage.Remotes.UseTool
local requestEquip = ReplicatedStorage.Remotes.RequestEquip

-- =========================
-- Tool spam loop (0.01s)
-- =========================
task.spawn(function()
    local tools = {"Stomp", "Punch", "Food"}
    while true do
        for _, tool in ipairs(tools) do
            useTool:FireServer(tool)
        end
        task.wait(0.01)
    end
end)

-- =========================
-- Food equip cycle loop
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
-- Auto Kill Boss (Always On)
-- =========================
task.spawn(function()
    while true do
        task.wait(0)

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local bossTorso = workspace:FindFirstChild("BossRing") 
            and workspace.BossRing:FindFirstChild("Boss") 
            and workspace.BossRing.Boss:FindFirstChild("UpperTorso")

        if hrp and bossTorso then
            -- lock position slightly inside boss but offset for hits
            local offset = CFrame.new(0, 0, -1)

            -- face the boss while staying locked
            hrp.CFrame = CFrame.new(
                bossTorso.Position + offset.Position,
                bossTorso.Position
            )
        end
    end
end)
-- =========================
-- Auto Rejoin System
-- =========================
local function tryRejoin()
    while true do
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        task.wait(3)
    end
end

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        tryRejoin()
    end
end)

-- =========================
-- Anti AFK (Method 1)
-- =========================
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

-- =========================
-- Anti AFK (Method 2)
-- =========================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
