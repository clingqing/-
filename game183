if getgenv().AutoGainMuscle ~= nil then
    getgenv().AutoGainMuscle = false
    task.wait(0.2)
end
if getgenv().RPromptConn then getgenv().RPromptConn:Disconnect() end
if getgenv().RAntiAfk then getgenv().RAntiAfk:Disconnect() end

if not game:IsLoaded() then game.Loaded:Wait() end

local P, RS, CG, TS = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("CoreGui"), game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")
local LP = P.LocalPlayer
local RE = RS:WaitForChild("RemoteEvent")

local function getPlayerData()
    for _, v in pairs(getreg()) do
        if type(v) == "table" and rawget(v, "PlayerData") then
            return v.PlayerData
        end
    end
    return nil
end

local waitCounter = 0
repeat
    task.wait(0.5)
    waitCounter += 1
    local d = getPlayerData()
    if waitCounter > 120 then
        return
    end
until d and d.EquipList and d.Cash

local GameData = {
    Weights = {{"Pencil", 0, 10}, {"Stick", 15, 20}, {"Mouse", 45, 30}, {"Water", 90, 50}, {"Soccer Ball", 188, 70}, {"Bottle", 315, 100}, {"Textbook", 600, 160}, {"Bucket", 1.2e3, 240}, {"Wood", 2.15e3, 330}, {"Guitar", 3.475e3, 440}, {"Chair", 5.275e3, 620}, {"Cart", 8.375e3, 850}, {"TV", 12.75e3, 1.1e3}, {"Bicyle", 19.8e3, 1.399e3}, {"Desk", 29.25e3, 1.85e3}, {"Bed", 44.25e3, 2.799e3}, {"Log", 75.5e3, 3.7e3}, {"Canoe", 111e3, 5.55e3}, {"Tyre", 208e3, 7.9e3}, {"Refrigeretor", 355e3, 10.1e3}, {"Drum", 1.212e6, 15.5e3}, {"Hydrant", 2.325e6, 22.39e3}, {"Piano", 4.025e6, 40.9e3}, {"Motorcycle", 9.8e6, 63e3}, {"Safe", 18.9e6, 84.5e3}, {"Flag", 30.25e6, 100e3}, {"ATM", 105e6, 161e3}, {"RX‑7", 193.2e6, 252e3}, {"EVO", 340e6, 363e3}, {"G‑Class", 570e6, 494e3}, {"Van", 887.5e6, 695e3}, {"Tree", 5.35e9, 956e3}, {"Container", 8.175e9, 1.427e6}, {"Sailboat", 13.4e9, 1.918e6}, {"Bus", 19.67e9, 2.609e6}, {"Truck", 29e9, 3.41e6}, {"Windmill", 212.5e9, 4.65e6}, {"Jet", 310e9, 6.23e6}, {"Tank", 442.5e9, 7.94e6}, {"Transport Helicopter", 600e9, 10e6}, {"Battleship", 5.39e12, 13.1e6}, {"Spaceship", 8.24e12, 17e6}, {"Speaker", 12.2e12, 22.1e6}, {"Anchor", 17.9e12, 28.8e6}, {"Old House", 25.8e12, 37.4e6}, {"Building", 222e12, 48.6e6}, {"Toxic Tank", 315e12, 63.2e6}, {"Rocket", 444e12, 82.2e6}, {"Castle", 621e12, 107e6}, {"Torpedo", 925e12, 139e6}, {"Signal Tower", 8.55e15, 180e6}, {"Stone Altar", 12.3e15, 234e6}, {"UFO", 17.6e15, 300e6}, {"Ancient Place", 24.9e15, 400e6}, {"Pyramid", 38.3e15, 515e6}, {"Canyon Mt.", 471e15, 660e6}, {"Mountain", 680e15, 880e6}, {"Volcano", 1e18, 1.1e9}, {"Mt. Fuji", 1.38e18, 1.5e9}, {"Meteorite", 2.06e18, 1.909e9}, {"Moon", 36.9e18, 2.5e9}, {"Mercury", 55.5e18, 3.23e9}, {"Mars", 84.4e18, 4.2e9}, {"Saturn", 125e18, 5.5e9}, {"Jupiter", 199e18, 7.18e9}, {"Super Saturn", 3.7e21, 17.7e9}, {"Sedna Bar", 10.2e21, 41.5e9}, {"Sun", 26.8e21, 99.9e9}, {"Mini Galaxy", 1.42e24, 239e9}, {"Earth Bar", 3.71e24, 570e9}, {"Black Hole", 9.55e24, 1.389e12}, {"Four Dimensions", 626e24, 3.29e12}, {"Sun Bar", 1.59e27, 7.9e12}, {"Holy Star", 4.05e27, 18.9e12}, {"Meteoroids Ring", 311e27, 45.5e12}, {"Meteor Bar", 799e27, 110e12}, {"Water Sphere", 2.02e30, 262e12}, {"Super Meteorite", 179e30, 629e12}, {"Cross Stars", 455e30, 1.5e15}, {"Fiery Star", 1.05e33, 3.62e15}, {"Super Venus", 115e33, 8.55e15}, {"Atomic Suns", 278e33, 20.8e15}, {"Lightning Cube", 705e33, 50e15}, {"Atmosphere", 81.1e36, 120e15}, {"Five Dimensions", 202e36, 288e15}, {"Space Stone", 500e36, 699e15}, {"Universe", 67.4e39, 1.659e18}, {"Mind Stone", 171e39, 3.99e18}, {"Reality Stone", 436e39, 9.55e18}, {"Soul Stone", 57.8e42, 22.89e18}, {"Time Stone", 154e42, 55e18}, {"Power Stone", 407e42, 132e18}, {"Cosmo Bar", 82.2e45, 315e18}, {"Galaxy Bar", 226e45, 755e18}, {"Universe Bar", 1.08e48, 9.99e21}, {"Sharkupiter", 481e48, 25.5e21}, {"Giftune", 1.35e51, 61.5e21}, {"Aurora Way", 3.55e51, 145e21}, {"Eternity", 452e51, 355e21}, {"Cashensione", 1.19e54, 795e21}, {"Past", 2.86e54, 1.99e24}, {"Future", 384e54, 4.55e24}, {"Infection", 934e54, 11.1e24}, {"Mutation", 2.41e57, 29.9e24}, {"Godly 1st Class", 342e57, 66.6e24}, {"Godly 2nd Class", 803e57, 155e24}, {"Godly 3rd Class", 1.96e60, 369e24}, {"Godly 4th Class", 279e60, 899e24}, {"Godly 5th Class", 711e60, 2.32e27}, {"Godly 6th Class", 1.91e63, 5.15e27}, {"Godly 7th Class", 222e63, 12.49e27}, {"Godly 8th Class", 599e63, 29.9e27}, {"Godly 9th Class", 1.55e66, 99.9e27}, {"1ST SUPER CLASS", 3.35e69, 555e27}, {"2ND SUPER CLASS", 21.2e69, 2.999e30}, {"3RD SUPER CLASS", 129e69, 16.6e30}, {"4TH SUPER CLASS", 799e69, 91.5e30}, {"5TH SUPER CLASS", 5.25e72, 500e30}, {"6TH SUPER CLASS", 33.5e72, 2.77e33}, {"7TH SUPER CLASS", 1.15e78, 15.5e33}, {"8TH SUPER CLASS", 7.2e78, 83.3e33}, {"9TH SUPER CLASS", 43e78, 460e33}, {"10TH SUPER CLASS", 265e78, 2.55e36}, {"11TH SUPER CLASS", 1.59e81, 13.9e36}, {"1ST ULTIMATE CLASS", 9.33e81, 76.5e36}, {"2ND ULTIMATE CLASS", 3.65e87, 420e36}, {"3RD ULTIMATE CLASS", 21.6e87, 2.33e39}, {"4TH ULTIMATE CLASS", 129e87, 12.5e39}, {"5TH ULTIMATE CLASS", 733e87, 70e39}, {"6TH ULTIMATE CLASS", 4.33e90, 385e39}, {"7TH ULTIMATE CLASS", 25.5e90, 2.219e42}, {"8TH ULTIMATE CLASS", 76.6e96, 11.5e42}, {"9TH ULTIMATE CLASS", 425e96, 64.19e42}, {"1ST SUPREME CLASS", 2.55e99, 355e42}, {"2ND SUPREME CLASS", 15e99, 1.99e45}, {"3RD SUPREME CLASS", 89.5e99, 11.1e45}, {"4TH SUPREME CLASS", 525e99, 58.79e45}, {"5TH SUPREME CLASS", 16.9e108, 322e45}, {"6TH SUPREME CLASS", 100e108, 1.77e48}, {"7TH SUPREME CLASS", 595e108, 9.75e48}, {"8TH SUPREME CLASS", 3.75e111, 53.5e48}, {"9TH SUPREME CLASS", 23e111, 295e48}, {"ULTIMATE SUPREME CLASS", 155e111, 1.99e51}}
}

local GC = getconnections or get_signal_cons
if GC then
    for _,v in pairs(GC(LP.Idled)) do
        if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end
    end
end
getgenv().RAntiAfk = LP.Idled:Connect(function()
    local VU = game:GetService("VirtualUser")
    VU:CaptureController()
    VU:ClickButton2(Vector2.new())
end)

local isRejoining = false
local function forceRejoin()
    if isRejoining then return end
    isRejoining = true
    local qot = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    if qot then
        local openStr, closeStr = "[=[", "]=]"
        qot("getgenv().CodeBlock = " .. openStr .. getgenv().CodeBlock .. closeStr .. "; loadstring(getgenv().CodeBlock)()")
    end
    task.spawn(function()
        while true do
            pcall(function() TS:Teleport(game.PlaceId, LP) end)
            task.wait(1)
        end
    end)
end

getgenv().RPromptConn = CG.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(0.5)
        local msgLabel = child:FindFirstChild("ErrorMessage", true)
        if msgLabel then
            local text = msgLabel.Text
            if string.find(text, "273") or string.find(text, "276") then
                getgenv().AutoGainMuscle = false
            elseif string.find(text, "267") then
                forceRejoin()
            else
                task.wait(5)
                forceRejoin()
            end
        else
            forceRejoin()
        end
    end
end)

getgenv().AutoGainMuscle = true
local autoClick = false
local autoBuyWeight = false
local cycleStartTime = tick()

local sg
if not CG:FindFirstChild("BuyWeightUI") then
    sg = Instance.new("ScreenGui", CG)
    sg.Name = "BuyWeightUI"
else
    sg = CG.BuyWeightUI
end

local main = sg:FindFirstChild("Frame")
if not main then
    main = Instance.new("Frame", sg)
    main.Name = "Frame"
    main.Size = UDim2.new(0, 200, 0, 245)
    main.Position = UDim2.new(0.05,0,0.05,0)
    main.BackgroundColor3 = Color3.fromRGB(25,25,25)
    main.BorderSizePixel = 0
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,8)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1,0,0,25)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(200,200,200)
    title.Text = "Auto‑Weight Controller"
    title.Font = Enum.Font.GothamBold
    title.TextSize =14
    title.TextXAlignment = Enum.TextXAlignment.Left
    local pad = Instance.new("UIPadding", title)
    pad.PaddingLeft = UDim.new(0,10)

    local targetLbl = Instance.new("TextLabel", main)
    targetLbl.Name = "TargetLabel"
    targetLbl.Size = UDim2.new(1,0,0,25)
    targetLbl.Position = UDim2.new(0,0,0,25)
    targetLbl.BackgroundTransparency = 1
    targetLbl.TextColor3 = Color3.new(1,1,1)
    targetLbl.Font = Enum.Font.GothamMedium
    targetLbl.TextSize =12
    targetLbl.Text = "Target: Loading..."

    local timeLbl = Instance.new("TextLabel", main)
    timeLbl.Name = "TimeLabel"
    timeLbl.Size = UDim2.new(1,0,0,25)
    timeLbl.Position = UDim2.new(0,0,0,50)
    timeLbl.BackgroundTransparency = 1
    timeLbl.TextColor3 = Color3.fromRGB(150,255,150)
    timeLbl.Font = Enum.Font.GothamMedium
    timeLbl.TextSize =12
    timeLbl.Text = "Time: 00:00"

    local gainBtn = Instance.new("TextButton", main)
    gainBtn.Name = "GainBtn"
    gainBtn.Size = UDim2.new(1,-20,0,30)
    gainBtn.Position = UDim2.new(0,10,0,78)
    gainBtn.BackgroundColor3 = Color3.fromRGB(40,80,40)
    gainBtn.TextColor3 = Color3.new(1,1,1)
    gainBtn.Font = Enum.Font.GothamBold
    gainBtn.TextSize =13
    gainBtn.Text = "Auto GainMuscle: ON"
    Instance.new("UICorner", gainBtn).CornerRadius = UDim.new(0,4)

    local clickBtn = Instance.new("TextButton", main)
    clickBtn.Name = "ClickBtn"
    clickBtn.Size = UDim2.new(1,-20,0,30)
    clickBtn.Position = UDim2.new(0,10,0,118)
    clickBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
    clickBtn.TextColor3 = Color3.new(1,1,1)
    clickBtn.Font = Enum.Font.GothamBold
    clickBtn.TextSize =13
    clickBtn.Text = "AutoClick: OFF"
    Instance.new("UICorner", clickBtn).CornerRadius = UDim.new(0,4)

    local buyBtn = Instance.new("TextButton", main)
    buyBtn.Name = "BuyBtn"
    buyBtn.Size = UDim2.new(1,-20,0,30)
    buyBtn.Position = UDim2.new(0,10,0,158)
    buyBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
    buyBtn.TextColor3 = Color3.new(1,1,1)
    buyBtn.Font = Enum.Font.GothamBold
    buyBtn.TextSize =13
    buyBtn.Text = "Auto Buy Weight: OFF"
    Instance.new("UICorner", buyBtn).CornerRadius = UDim.new(0,4)

    local stealthBtn = Instance.new("TextButton", sg)
    stealthBtn.Size = UDim2.new(0, 50, 0, 50)
    stealthBtn.Position = UDim2.new(1, 0, 1, 0)
    stealthBtn.AnchorPoint = Vector2.new(1,1)
    stealthBtn.BackgroundTransparency = 1
    stealthBtn.Text = ""
    stealthBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
    end)

    local dragging, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local gainBtn = main.GainBtn
local clickBtn = main.ClickBtn
local buyBtn = main.BuyBtn
local targetLbl = main.TargetLabel
local timeLbl = main.TimeLabel

gainBtn.MouseButton1Click:Connect(function()
    getgenv().AutoGainMuscle = not getgenv().AutoGainMuscle
    if getgenv().AutoGainMuscle then
        gainBtn.Text = "Auto GainMuscle: ON"
        gainBtn.BackgroundColor3 = Color3.fromRGB(40,80,40)
    else
        gainBtn.Text = "Auto GainMuscle: OFF"
        gainBtn.BackgroundColor3 = Color3.fromRGB(100,30,30)
    end
end)

clickBtn.MouseButton1Click:Connect(function()
    autoClick = not autoClick
    if autoClick then
        clickBtn.Text = "AutoClick: ON"
        clickBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
    else
        clickBtn.Text = "AutoClick: OFF"
        clickBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
    end
end)

buyBtn.MouseButton1Click:Connect(function()
    autoBuyWeight = not autoBuyWeight
    if autoBuyWeight then
        buyBtn.Text = "Auto Buy Weight: ON"
        buyBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
    else
        buyBtn.Text = "Auto Buy Weight: OFF"
        buyBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
    end
end)

task.spawn(function()
	while true do
		task.wait(0.001)
		if autoClick then
			local char = LP.Character
			if char then
				for _, tool in pairs(char:GetChildren()) do
					if tool:IsA("Tool") and tool.Parent == char then
						pcall(function() tool:Activate() end)
						break
					end
				end
			end
		end
	end
end)

local function srvToLuaWeight(idx) return idx >= 11 and idx -1 or idx end
local function luaToSrvWeight(idx) return idx >=11 and idx+1 or idx end

local function getNextWeight(data)
    local curRaw = math.max(1, data.EquipList and data.EquipList.Income or 1)
    local curLua = srvToLuaWeight(curRaw)
    for i = curLua +1, #GameData.Weights do
        local cost = GameData.Weights[i][2]
        if data.Cash >= cost then
            return i
        end
    end
    return nil
end

task.spawn(function()
    while true do
        task.wait(0.12)
        local data = getPlayerData()
        if not data or not data.EquipList then continue end

        local elapsed = math.floor(tick() - cycleStartTime)
        local mins = math.floor(elapsed / 60)
        local secs = elapsed % 60
        timeLbl.Text = string.format("Time: %02d:%02d", mins, secs)

        if getgenv().AutoGainMuscle then
            pcall(function() RE:FireServer({"GainMuscle"}) end)
        end

        if autoBuyWeight then
            local nw = getNextWeight(data)
            if nw then
                local srvW = luaToSrvWeight(nw)
                pcall(function() RE:FireServer({"BuyItem","Income_Item","Weight",srvW}) end)
            end
        end

        local nwDisp = getNextWeight(data)
        if nwDisp then
            targetLbl.Text = "Target: "..GameData.Weights[nwDisp][1]
        else
            targetLbl.Text = "Target: No more / Need Cash"
        end
    end
end)
