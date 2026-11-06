-- Washing MVP | place as a Script in ServerScriptService
-- Server controls dirt, water, coins, refill, and saves. The client can only request a spray.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Workspace = game:GetService("Workspace")

local GUN_NAME = "Demo Water Gun"
local MAX_WATER = 30
local WATER_PER_SHOT = 0.12 -- 1 water per second at one shot every 0.12 s
local SHOT_INTERVAL = 0.12
local DAMAGE_PER_SHOT = 1 -- Gun level 1: Power 1
local MAX_DISTANCE = 55
local RESPAWN_SECONDS = 10
local SAVING_INTERVAL = 60

local coinStore = DataStoreService:GetDataStore("WashingMVP_Coins_v1")
local lastShot = {}
local washable = {}

local remotes = ReplicatedStorage:FindFirstChild("WashingMVP_Remotes")
if not remotes then
    remotes = Instance.new("Folder")
    remotes.Name = "WashingMVP_Remotes"
    remotes.Parent = ReplicatedStorage
end
local sprayRemote = remotes:FindFirstChild("Spray")
if not sprayRemote then
    sprayRemote = Instance.new("RemoteEvent")
    sprayRemote.Name = "Spray"
    sprayRemote.Parent = remotes
end

local demo = Workspace:FindFirstChild("WashingMVP_Demo")
if not demo then
    demo = Instance.new("Folder")
    demo.Name = "WashingMVP_Demo"
    demo.Parent = Workspace
end

local function makePart(name, size, position, color, parent, shape)
    local part = Instance.new("Part")
    part.Name = name
    part.Anchored = true
    part.Size = size
    part.Position = position
    part.Color = color
    part.Material = Enum.Material.SmoothPlastic
    if shape then part.Shape = shape end
    part.Parent = parent
    return part
end

local objects = demo:FindFirstChild("Washables")
if not objects then
    objects = Instance.new("Folder")
    objects.Name = "Washables"
    objects.Parent = demo
end

local function addTarget(name, position, cleanColor, maxDirt)
    local model = Instance.new("Model")
    model.Name = name
    model.Parent = objects

    local clean = makePart("CleanObject", Vector3.new(4, 5, 4), position, cleanColor, model, Enum.PartType.Ball)
    clean.CanCollide = false
    clean.CanQuery = false

    local shell = makePart("DirtShell", Vector3.new(4.45, 5.45, 4.45), position, Color3.fromRGB(112, 78, 53), model, Enum.PartType.Ball)
    shell.CanCollide = false
    shell.CanQuery = true
    shell.Transparency = 0.08
    shell:SetAttribute("DirtRemaining", maxDirt)
    shell:SetAttribute("DirtMaximum", maxDirt)

    local tag = Instance.new("BillboardGui")
    tag.Name = "DirtIndicator"
    tag.Size = UDim2.fromOffset(180, 42)
    tag.StudsOffsetWorldSpace = Vector3.new(0, 4.5, 0)
    tag.AlwaysOnTop = true
    tag.Adornee = shell
    tag.Parent = shell

    local label = Instance.new("TextLabel")
    label.BackgroundColor3 = Color3.fromRGB(25, 42, 58)
    label.BackgroundTransparency = 0.15
    label.Size = UDim2.fromScale(1, 1)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = tag

    local info = {hp = maxDirt, maximum = maxDirt, shell = shell, label = label, respawning = false}
    washable[shell] = info

    local function updateVisual()
        local ratio = math.clamp(info.hp / info.maximum, 0, 1)
        shell.Transparency = 0.08 + (1 - ratio) * 0.92
        shell:SetAttribute("DirtRemaining", info.hp)
        label.Text = name .. ": " .. math.ceil(ratio * 100) .. "% dirty"
        shell.CanQuery = info.hp > 0
    end
    info.updateVisual = updateVisual
    updateVisual()
end

-- Never replace an existing map. Add an isolated demo only when there are no demo targets.
if #objects:GetChildren() == 0 then
    local ground = makePart("DemoGrass", Vector3.new(92, 2, 67), Vector3.new(0, -0.5, -40), Color3.fromRGB(102, 201, 85), demo)
    ground.Material = Enum.Material.Grass
    makePart("DemoPath", Vector3.new(12, 0.15, 58), Vector3.new(0, 0.58, -32), Color3.fromRGB(194, 167, 117), demo)

    addTarget("Blue Egg", Vector3.new(-21, 3.4, -49), Color3.fromRGB(87, 175, 255), 50)
    addTarget("Pink Egg", Vector3.new(0, 3.4, -55), Color3.fromRGB(252, 132, 187), 75)
    addTarget("Golden Egg", Vector3.new(21, 3.4, -49), Color3.fromRGB(255, 210, 63), 100)

    local refill = makePart("Water Station", Vector3.new(6, 6, 6), Vector3.new(-28, 3.5, -22), Color3.fromRGB(67, 173, 254), demo)
    local prompt = Instance.new("ProximityPrompt")
    prompt.ActionText = "Refill tank"
    prompt.ObjectText = "Water Station"
    prompt.HoldDuration = 0.3
    prompt.MaxActivationDistance = 10
    prompt.RequiresLineOfSight = false
    prompt.Parent = refill
    prompt.Triggered:Connect(function(player)
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root and (root.Position - refill.Position).Magnitude <= 13 then
            player:SetAttribute("WashWater", MAX_WATER)
        end
    end)

    -- Only create a demo spawn if this place has no spawn already.
    if not Workspace:FindFirstChildWhichIsA("SpawnLocation", true) then
        local spawn = Instance.new("SpawnLocation")
        spawn.Name = "WashingMVP_Spawn"
        spawn.Anchored = true
        spawn.Neutral = true
        spawn.Size = Vector3.new(8, 1, 8)
        spawn.Position = Vector3.new(0, 1.1, -15)
        spawn.Color = Color3.fromRGB(255, 255, 255)
        spawn.Parent = demo
    end
else
    warn("[WashingMVP] Existing demo targets found; do not duplicate them. Restart server to reset.")
end

local function createGun(player)
    if not player.Parent then return end
    local character = player.Character
    if not character then return end
    local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 5)
    if not backpack then return end
    if character:FindFirstChild(GUN_NAME) or backpack:FindFirstChild(GUN_NAME) then return end

    local gun = Instance.new("Tool")
    gun.Name = GUN_NAME
    gun.RequiresHandle = false
    gun.CanBeDropped = false
    gun.ToolTip = "Hold to wash dirty eggs"
    gun:SetAttribute("WashingMVPTool", true)
    gun.Parent = backpack
end

local function saveCoins(player)
    local stats = player:FindFirstChild("leaderstats")
    local coins = stats and stats:FindFirstChild("Coins")
    if not coins then return end
    local value = math.max(0, math.floor(coins.Value))
    local ok, err = pcall(function()
        coinStore:SetAsync("coins_" .. player.UserId, value)
    end)
    if not ok then warn("[WashingMVP] Coin save failed for " .. player.Name .. ": " .. tostring(err)) end
end

local function onPlayerAdded(player)
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player

    local coins = Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = 0
    coins.Parent = stats
    player:SetAttribute("WashWater", MAX_WATER)
    player:SetAttribute("WashWaterMax", MAX_WATER)

    local ok, saved = pcall(function()
        return coinStore:GetAsync("coins_" .. player.UserId)
    end)
    if ok and type(saved) == "number" then
        coins.Value = math.clamp(math.floor(saved), 0, 2000000000)
    elseif not ok then
        warn("[WashingMVP] Coin load unavailable (Studio API Services?): " .. tostring(saved))
    end
    if not player.Parent then return end

    player.CharacterAdded:Connect(function()
        task.wait(0.3)
        createGun(player)
    end)
    if player.Character then task.defer(createGun, player) end
end

sprayRemote.OnServerEvent:Connect(function(player, shell, aimPosition)
    -- Security: never trust target, range, tool, timing, water, or rewards from client.
    if typeof(shell) ~= "Instance" or typeof(aimPosition) ~= "Vector3" then return end
    local info = washable[shell]
    if not info or info.hp <= 0 then return end
    if not shell:IsDescendantOf(objects) then return end

    local now = os.clock()
    if now - (lastShot[player] or -math.huge) < SHOT_INTERVAL * 0.92 then return end

    local character = player.Character
    local head = character and character:FindFirstChild("Head")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local equipped = character and character:FindFirstChild(GUN_NAME)
    if not head or not humanoid or humanoid.Health <= 0
        or not equipped or not equipped:IsA("Tool") or not equipped:GetAttribute("WashingMVPTool") then
        return
    end

    local water = player:GetAttribute("WashWater")
    if type(water) ~= "number" or water + 0.0001 < WATER_PER_SHOT then return end

    local toAim = aimPosition - head.Position
    if toAim.Magnitude < 0.1 or toAim.Magnitude > MAX_DISTANCE then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character}
    local hit = Workspace:Raycast(head.Position, toAim.Unit * (toAim.Magnitude + 2), params)
    if not hit or hit.Instance ~= shell then return end

    lastShot[player] = now
    player:SetAttribute("WashWater", math.max(0, math.round((water - WATER_PER_SHOT) * 100) / 100))

    local removed = math.min(DAMAGE_PER_SHOT, info.hp)
    info.hp -= removed
    info.updateVisual()

    local stats = player:FindFirstChild("leaderstats")
    local coins = stats and stats:FindFirstChild("Coins")
    -- Coins per unit of dirt actually removed. No object-completion bonus.
    if coins then coins.Value += removed end

    if info.hp <= 0 and not info.respawning then
        info.respawning = true
        info.label.Text = "CLEAN! Respawning..."
        task.delay(RESPAWN_SECONDS, function()
            if info.shell.Parent then
                info.hp = info.maximum
                info.updateVisual()
            end
            info.respawning = false
        end)
    end
end)

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do task.spawn(onPlayerAdded, player) end

Players.PlayerRemoving:Connect(function(player)
    saveCoins(player)
    lastShot[player] = nil
end)

task.spawn(function()
    while true do
        task.wait(SAVING_INTERVAL)
        for _, player in ipairs(Players:GetPlayers()) do
            task.spawn(saveCoins, player)
        end
    end
end)

game:BindToClose(function()
    local pending = 0
    for _, player in ipairs(Players:GetPlayers()) do
        pending += 1
        task.spawn(function()
            saveCoins(player)
            pending -= 1
        end)
    end
    local deadline = os.clock() + 25
    while pending > 0 and os.clock() < deadline do task.wait(0.1) end
end)
