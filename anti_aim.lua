local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")

local MIN_DISTANCE = 30  
local MAX_DISTANCE = 40  
local BASE_FORCE = 100    
local MAX_FORCE = 250    

local function onUpdate()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                local distance = (hrp.Position - otherHRP.Position).magnitude
                
                if distance < MAX_DISTANCE then
                    local forceMultiplier = math.clamp((MAX_DISTANCE - distance) / (MAX_DISTANCE - MIN_DISTANCE), 0, 1)
                    local pushForce = BASE_FORCE + (MAX_FORCE - BASE_FORCE) * forceMultiplier
                    local direction = (hrp.Position - otherHRP.Position).unit
                    hrp.Velocity = direction * pushForce  
                end
            end
        end
    end
end

runService.Heartbeat:Connect(onUpdate)
