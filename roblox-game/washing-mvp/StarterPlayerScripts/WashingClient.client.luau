-- Washing MVP | LocalScript in StarterPlayer > StarterPlayerScripts
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local spray = ReplicatedStorage:WaitForChild("WashingMVP_Remotes"):WaitForChild("Spray")
local firing = false
local equipped = false
local lastSent = 0

local gui = Instance.new("ScreenGui")
gui.Name = "WashingMVP_HUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local status = Instance.new("TextLabel")
status.Name = "Water"
status.Size = UDim2.fromOffset(265, 60)
status.Position = UDim2.new(0.5, -132, 1, -80)
status.BackgroundColor3 = Color3.fromRGB(20, 44, 65)
status.BackgroundTransparency = 0.08
status.TextColor3 = Color3.new(1, 1, 1)
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = status

local tip = Instance.new("TextLabel")
tip.Size = UDim2.fromOffset(340, 36)
tip.Position = UDim2.new(0.5, -170, 1, -122)
tip.BackgroundTransparency = 1
tip.TextColor3 = Color3.new(1, 1, 1)
tip.TextScaled = true
tip.TextStrokeTransparency = 0.3
tip.Text = "Equip Demo Water Gun • Hold to wash"
tip.Parent = gui

local mobileButton = Instance.new("TextButton")
mobileButton.Size = UDim2.fromOffset(100, 100)
mobileButton.Position = UDim2.new(1, -120, 1, -200)
mobileButton.BackgroundColor3 = Color3.fromRGB(50, 159, 253)
mobileButton.Text = "WASH"
mobileButton.TextScaled = true
mobileButton.Font = Enum.Font.GothamBold
mobileButton.TextColor3 = Color3.new(1, 1, 1)
mobileButton.Visible = UserInputService.TouchEnabled
mobileButton.Parent = gui
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = mobileButton

local function updateWater()
    local amount = player:GetAttribute("WashWater") or 0
    local maxWater = player:GetAttribute("WashWaterMax") or 30
    status.Text = string.format("💧 WATER  %.2f / %.0f", amount, maxWater)
    if amount < 0.12 then
        tip.Text = "EMPTY! Go to the blue Water Station and press E"
    elseif equipped then
        tip.Text = "Hold to wash • Coins awarded per dirt removed"
    else
        tip.Text = "Equip Demo Water Gun to wash"
    end
end

local function refreshEquipment()
    local character = player.Character
    local tool = character and character:FindFirstChild("Demo Water Gun")
    equipped = tool ~= nil and tool:IsA("Tool")
    if not equipped then firing = false end
    updateWater()
end

local function watchCharacter(character)
    firing = false
    refreshEquipment()
    character.ChildAdded:Connect(refreshEquipment)
    character.ChildRemoved:Connect(refreshEquipment)
end
player.CharacterAdded:Connect(watchCharacter)
if player.Character then watchCharacter(player.Character) end
player:GetAttributeChangedSignal("WashWater"):Connect(updateWater)
updateWater()

UserInputService.InputBegan:Connect(function(input, consumed)
    if consumed or UserInputService.TouchEnabled then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then firing = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then firing = false end
end)
mobileButton.MouseButton1Down:Connect(function() firing = true end)
mobileButton.MouseButton1Up:Connect(function() firing = false end)
mobileButton.MouseLeave:Connect(function() firing = false end)

RunService.Heartbeat:Connect(function()
    if not firing or not equipped or os.clock() - lastSent < 0.12 then return end
    local camera = Workspace.CurrentCamera
    if not camera then return end
    local ray
    if UserInputService.TouchEnabled then
        local center = camera.ViewportSize / 2
        ray = camera:ViewportPointToRay(center.X, center.Y)
    else
        local pos = UserInputService:GetMouseLocation()
        ray = camera:ViewportPointToRay(pos.X, pos.Y)
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local character = player.Character
    if character then params.FilterDescendantsInstances = {character} end
    local result = Workspace:Raycast(ray.Origin, ray.Direction * 80, params)
    if result and result.Instance.Name == "DirtShell"
        and result.Instance:IsDescendantOf(Workspace:WaitForChild("WashingMVP_Demo"):WaitForChild("Washables")) then
        lastSent = os.clock()
        spray:FireServer(result.Instance, result.Position)
    end
end)
