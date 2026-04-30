local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")
local virtualUser = game:GetService("VirtualUser")
local runService = game:GetService("RunService")
local useTool = replicatedStorage.Remotes.UseTool
local requestEquip = replicatedStorage.Remotes.RequestEquip

task.spawn(function()
    local tools = {"Stomp", "Punch", "Food"}
    while true do
        for _, tool in ipairs(tools) do
            useTool:FireServer(tool)
        end
        task.wait(0.2)
    end
end)

task.spawn(function()
    while true do
        requestEquip:FireServer("Food", 50)
        task.wait(10)
        requestEquip:FireServer("Food", 51)
        task.wait(900)
    end
end)

runService.Heartbeat:Connect(function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local bossRing = workspace:FindFirstChild("BossRing")
    local bossTorso = bossRing and bossRing:FindFirstChild("Boss") and bossRing.Boss:FindFirstChild("UpperTorso")
    if hrp and bossTorso then
        local offset = CFrame.new(0, 0, -1)
        hrp.CFrame = CFrame.new(bossTorso.Position + offset.Position, bossTorso.Position)
    end
end)

local function tryRejoin()
    while true do
        pcall(function()
            teleportService:Teleport(game.PlaceId, player)
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

local GC = getconnections or get_signal_cons
if GC then
    for _, v in pairs(GC(player.Idled)) do
        if v.Disable then
            v.Disable(v)
        elseif v.Disconnect then
            v.Disconnect(v)
        end
    end
else
    player.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
end

local danceArgs = {"Orange Justice", "Dance"}
local isDancing = false

local function resetDanceState()
    isDancing = false
end

task.spawn(function()
    task.wait(20)
    while true do
        local char = player.Character
        local hum = char and char:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            if isDancing then
                useTool:FireServer(unpack(danceArgs))
                useTool:FireServer(unpack(danceArgs))
            else
                useTool:FireServer(unpack(danceArgs))
                isDancing = true
            end
        end
        task.wait(20)
    end
end)

player.CharacterAdded:Connect(function(character)
    resetDanceState()
end)

if player.Character and player.Character:FindFirstChild("Humanoid") then
    resetDanceState()
end
