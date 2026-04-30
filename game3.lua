function getNil(name, class)
    for _, v in pairs(getnilinstances()) do
        if v.ClassName == class and v.Name == name then
            return v
        end
    end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local requestEquip = ReplicatedStorage.Remotes.RequestEquip
local useTool = ReplicatedStorage.Remotes.UseTool

task.spawn(function()
    while true do
        useTool:FireServer("Food")
        task.wait(0.01)
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

LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local MAX_RETRIES = 5
local RETRY_DELAY = 3
local COOLDOWN = 30

local isRejoining = false

local function safeRejoin()
    if isRejoining then return end
    isRejoining = true

    while true do
        for attempt = 1, MAX_RETRIES do
            pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
            task.wait(RETRY_DELAY)
        end
        task.wait(COOLDOWN)
    end
end

LocalPlayer.OnTeleport:Connect(function(teleportState)
    if teleportState == Enum.TeleportState.Failed then
        safeRejoin()
    end
end)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(2)
        safeRejoin()
    end
end)
