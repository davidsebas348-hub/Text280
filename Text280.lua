local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- =========================
-- TOGGLE REAL
-- =========================
if _G.NoCollisionConnection then
	_G.NoCollisionConnection:Disconnect()
	_G.NoCollisionConnection = nil
	
	-- Restaurar colisiones
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			for _, part in ipairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
	
	return
end

-- =========================
-- ACTIVAR
-- =========================

local function removeCollisionFromOthers()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			for _, part in ipairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end
end

_G.NoCollisionConnection = RunService.RenderStepped:Connect(removeCollisionFromOthers)
