local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- =========================
-- TOGGLE ANTI-COLLISIONS
-- =========================
if _G.NO_COLLISIONS then
    -- 🔴 Restaurar colisiones
    _G.NO_COLLISIONS = false
    print("COLLISIONS RESTORED")

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
    return
end

-- 🟢 Desactivar colisiones
_G.NO_COLLISIONS = true
print("COLLISIONS DISABLED")

local function disableCollisions(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- Aplicar a todos los jugadores existentes
for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        disableCollisions(player.Character)
    end
end

-- Detectar nuevos personajes
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if _G.NO_COLLISIONS then
            disableCollisions(char)
        end
    end)
end)

-- Detectar cuando los personajes existentes cambian
for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(char)
        if _G.NO_COLLISIONS then
            disableCollisions(char)
        end
    end)
end

-- Mantenerlo activo cada frame
RunService.RenderStepped:Connect(function()
    if not _G.NO_COLLISIONS then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            disableCollisions(player.Character)
        end
    end
end)
