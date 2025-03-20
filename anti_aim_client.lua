local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local runService = game:GetService("RunService")

local SAFE_DISTANCE = 30  -- Мінімальна дистанція для ТП
local MAX_RANDOM_OFFSET = 30  -- Макс. відстань, куди може ТП-нути

local function getRandomOffset()
    local angle = math.rad(math.random(0, 360))  -- Випадковий напрям
    local distance = math.random(10, MAX_RANDOM_OFFSET)  -- Випадкова дистанція (щоб не ТП-шило в одну точку)
    local offset = Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
    return offset
end

local function onUpdate()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherHRP then
                local distance = (hrp.Position - otherHRP.Position).magnitude
                
                if distance < SAFE_DISTANCE then
                    local newPosition = hrp.Position + getRandomOffset()
                    hrp.CFrame = CFrame.new(newPosition)  -- Телепорт
                    break  -- Досить одного ТП за цикл
                end
            end
        end
    end
end

runService.Heartbeat:Connect(onUpdate)
