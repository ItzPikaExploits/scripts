-- counter blox remastered: aimbot
-- Valerie!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer;
local Mouse = Player:GetMouse();

local Camera = workspace.CurrentCamera;

local lock = false;
local timetaken = 0;

local TeamIgnore = {
	["Counter-Terrorists"] = {"TTT", "Counter-Terrorists"},
	["Terrorists"] = {"TTT", "Terrorists"},
	["TTT"] = {"TTT", "Counter-Terrorists", "Terrorists"},
};

function getPlayerFromChar(char)
	return Players:GetPlayerFromCharacter(char);
end

function easeOutQuad(x)
	return 1 - (1 - x) * (1 - x);
end

function AimAt(pos)
	Camera.CFrame = Camera.CFrame:lerp(CFrame.new(Camera.CFrame.p, pos), easeOutQuad(timetaken))
end

function checkFOV(worldPoint)
	local vector, onScreen = Camera:WorldToScreenPoint(worldPoint);
	local screenPoint = Vector2.new(vector.X, vector.Y);
	local magn = (screenPoint - Vector2.new(Mouse.X, Mouse.Y)).Magnitude;
	return magn, onScreen;
end

UserInputService.InputBegan:Connect(function(Input)
	if (Input.UserInputType == Enum.UserInputType.MouseButton2) then
		lock = true
		timetaken = 0;
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if (Input.UserInputType == Enum.UserInputType.MouseButton2) then
		lock = false
	end
end)

if (_G.whim_aimlock) then _G.whim_aimlock:Disconnect() end

_G.whim_aimlock = RunService.RenderStepped:Connect(function(dt)
	if (lock) then
		local MAXANGLE = 90;
		local toAIM = nil;
		timetaken = math.clamp(timetaken + (dt/1), 0, 1)
		for _, char in pairs(Player.Character.Parent:GetChildren()) do
			if (not char:FindFirstChild("Head")) then continue; end
			if (not char:FindFirstChild("HumanoidRootPart")) then continue; end
			local head = char.Head;
			local hrp = char.HumanoidRootPart;
			local plr = getPlayerFromChar(char);
			if (not plr) or (plr.Name == Player.Name) then continue; end
			if (plr.Team == Player.Team) then continue; end
			if (table.find(TeamIgnore[Player.Team.Name], plr.Team.Name)) then continue; end
			local pos = head.Position;
			local AN, onScreen = checkFOV(pos);
			if onScreen and (AN < MAXANGLE) then
				MAXANGLE = AN;
				toAIM = pos;
			end
		end
		if (toAIM) then
			AimAt(toAIM)
		else
			timetaken = 0
		end
	end
end)