local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer;
local Mouse = Player:GetMouse()

local Camera = workspace.CurrentCamera;

local id = HttpService:GenerateGUID(false)

local function DrawLine()
	local l = Drawing.new("Line")
	l.Visible = false
	l.From = Vector2.new(0, 0)
	l.To = Vector2.new(1, 1)
	l.Color = Color3.fromRGB(255, 0, 0)
	l.Thickness = 0.5
	l.Transparency = 1
	return l
end

function getCharFromName(name)
	return workspace.MapFolder.Players:FindFirstChild(name);
end
function getPlayerFromChar(char)
	return Players:FindFirstChild(char.Name);
end

local function DrawESP(char)
	local name = char.Name;
	local limbs = {
		-- Spine
		Head_UpperTorso = DrawLine(),
		UpperTorso_LowerTorso = DrawLine(),
		-- Left Arm
		UpperTorso_LeftUpperArm = DrawLine(),
		LeftUpperArm_LeftLowerArm = DrawLine(),
		LeftLowerArm_LeftHand = DrawLine(),
		-- Right Arm
		UpperTorso_RightUpperArm = DrawLine(),
		RightUpperArm_RightLowerArm = DrawLine(),
		RightLowerArm_RightHand = DrawLine(),
		-- Left Leg
		LowerTorso_LeftUpperLeg = DrawLine(),
		LeftUpperLeg_LeftLowerLeg = DrawLine(),
		LeftLowerLeg_LeftFoot = DrawLine(),
		-- Right Leg
		LowerTorso_RightUpperLeg = DrawLine(),
		RightUpperLeg_RightLowerLeg = DrawLine(),
		RightLowerLeg_RightFoot = DrawLine(),
	}
	local function Visibility(state)
		for i, v in pairs(limbs) do
			v.Visible = state
		end
	end

	local function Colorize(color)
		for i, v in pairs(limbs) do
			v.Color = color
		end
	end

	local function UpdaterR15()
		local connection
		connection = RunService.RenderStepped:Connect(function()
			local MapFolder = workspace:FindFirstChild("MapFolder");
			if (not MapFolder) then return; end
			local plr = getPlayerFromChar(char)
			if (plr) then
				Colorize((plr.SelectedTeam.Value == Player.SelectedTeam.Value) and Color3.new(0, 0.733333, 1) or Color3.new(1, 0.294118, 0.294118))
			end
			if shared[id] and char ~= nil and char.Parent == MapFolder.Players and char:FindFirstChild("Humanoid") ~= nil and char:FindFirstChild("HumanoidRootPart") ~= nil and char.Humanoid.Health > 0 then
				local HUM, vis = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
				if vis then
					-- Head
					local H = Camera:WorldToViewportPoint(char.Head.Position)
					if limbs.Head_UpperTorso.From ~= Vector2.new(H.X, H.Y) then
						--Spine
						local UT = Camera:WorldToViewportPoint(char.UpperTorso.Position)
						local LT = Camera:WorldToViewportPoint(char.LowerTorso.Position)
						-- Left Arm
						local LUA = Camera:WorldToViewportPoint(char.LeftUpperArm.Position)
						local LLA = Camera:WorldToViewportPoint(char.LeftLowerArm.Position)
						local LH = Camera:WorldToViewportPoint(char.LeftHand.Position)
						-- Right Arm
						local RUA = Camera:WorldToViewportPoint(char.RightUpperArm.Position)
						local RLA = Camera:WorldToViewportPoint(char.RightLowerArm.Position)
						local RH = Camera:WorldToViewportPoint(char.RightHand.Position)
						-- Left leg
						local LUL = Camera:WorldToViewportPoint(char.LeftUpperLeg.Position)
						local LLL = Camera:WorldToViewportPoint(char.LeftLowerLeg.Position)
						local LF = Camera:WorldToViewportPoint(char.LeftFoot.Position)
						-- Right leg
						local RUL = Camera:WorldToViewportPoint(char.RightUpperLeg.Position)
						local RLL = Camera:WorldToViewportPoint(char.RightLowerLeg.Position)
						local RF = Camera:WorldToViewportPoint(char.RightFoot.Position)

						--Head
						limbs.Head_UpperTorso.From = Vector2.new(H.X, H.Y)
						limbs.Head_UpperTorso.To = Vector2.new(UT.X, UT.Y)

						--Spine
						limbs.UpperTorso_LowerTorso.From = Vector2.new(UT.X, UT.Y)
						limbs.UpperTorso_LowerTorso.To = Vector2.new(LT.X, LT.Y)

						-- Left Arm
						limbs.UpperTorso_LeftUpperArm.From = Vector2.new(UT.X, UT.Y)
						limbs.UpperTorso_LeftUpperArm.To = Vector2.new(LUA.X, LUA.Y)

						limbs.LeftUpperArm_LeftLowerArm.From = Vector2.new(LUA.X, LUA.Y)
						limbs.LeftUpperArm_LeftLowerArm.To = Vector2.new(LLA.X, LLA.Y)

						limbs.LeftLowerArm_LeftHand.From = Vector2.new(LLA.X, LLA.Y)
						limbs.LeftLowerArm_LeftHand.To = Vector2.new(LH.X, LH.Y)

						-- Right Arm
						limbs.UpperTorso_RightUpperArm.From = Vector2.new(UT.X, UT.Y)
						limbs.UpperTorso_RightUpperArm.To = Vector2.new(RUA.X, RUA.Y)

						limbs.RightUpperArm_RightLowerArm.From = Vector2.new(RUA.X, RUA.Y)
						limbs.RightUpperArm_RightLowerArm.To = Vector2.new(RLA.X, RLA.Y)

						limbs.RightLowerArm_RightHand.From = Vector2.new(RLA.X, RLA.Y)
						limbs.RightLowerArm_RightHand.To = Vector2.new(RH.X, RH.Y)

						-- Left Leg
						limbs.LowerTorso_LeftUpperLeg.From = Vector2.new(LT.X, LT.Y)
						limbs.LowerTorso_LeftUpperLeg.To = Vector2.new(LUL.X, LUL.Y)

						limbs.LeftUpperLeg_LeftLowerLeg.From = Vector2.new(LUL.X, LUL.Y)
						limbs.LeftUpperLeg_LeftLowerLeg.To = Vector2.new(LLL.X, LLL.Y)

						limbs.LeftLowerLeg_LeftFoot.From = Vector2.new(LLL.X, LLL.Y)
						limbs.LeftLowerLeg_LeftFoot.To = Vector2.new(LF.X, LF.Y)

						-- Right Leg
						limbs.LowerTorso_RightUpperLeg.From = Vector2.new(LT.X, LT.Y)
						limbs.LowerTorso_RightUpperLeg.To = Vector2.new(RUL.X, RUL.Y)

						limbs.RightUpperLeg_RightLowerLeg.From = Vector2.new(RUL.X, RUL.Y)
						limbs.RightUpperLeg_RightLowerLeg.To = Vector2.new(RLL.X, RLL.Y)

						limbs.RightLowerLeg_RightFoot.From = Vector2.new(RLL.X, RLL.Y)
						limbs.RightLowerLeg_RightFoot.To = Vector2.new(RF.X, RF.Y)
					end

					if limbs.Head_UpperTorso.Visible ~= true then
						Visibility(true)
					end
				else 
					if limbs.Head_UpperTorso.Visible ~= false then
						Visibility(false)
					end
				end
			else 
				if limbs.Head_UpperTorso.Visible ~= false then
					Visibility(false)
				end
				for i, v in pairs(limbs) do
					v:Remove()
				end
				connection:Disconnect()
			end
		end)
	end

	coroutine.wrap(UpdaterR15)()
end

local function check(i)
	if (i:IsA("Model") and Players:FindFirstChild(i.Name)) then
		DrawESP(i)
	end
end

if (shared._unload and typeof(shared._unload) == "function") then
	shared._unload()
end

for _, c in pairs(workspace.MapFolder.Players:GetChildren()) do
	check(c)
end
local conn = workspace.MapFolder.Players.ChildAdded:Connect(check)

local toAIM = nil;

function AimAt(PART)
	Camera.CFrame = Camera.CFrame:lerp(CFrame.new(Camera.CFrame.p, PART.CFrame.p), 0.3)
end
function getFOVXYZ(P0, P1, DEGREE)
	local X1, Y1, Z1 = P0:ToOrientation()
	local cf = CFrame.new(P0.p, P1.p)
	local X2, Y2, Z2 = cf:ToOrientation()
	if DEGREE then
	else
		return Vector3.new((X1 - X2), (Y1 - Y2), (Z1 - Z2))
	end
end
function checkFOV(PART)
	local FOV = getFOVXYZ(Camera.CFrame, PART.CFrame)
	local ANGLE = math.abs(FOV.X) + math.abs(FOV.Y)
	return ANGLE;
end
function easeOutQuad(x: number)
	return 1 - (1 - x) * (1 - x);
end

local msconn = Mouse.KeyDown:Connect(function(KEY)
	KEY = KEY:lower()
	if (KEY == "e") then
		if not toAIM then
			local MAXANGLE = math.rad(20)
			for _, char in pairs(workspace.MapFolder.Players:GetChildren()) do
				local PLAYER = getPlayerFromChar(char);
				if (PLAYER and char.Name == Player.Name) then continue; end
				if (PLAYER.SelectedTeam.Value == Player.SelectedTeam.Value) then continue; end
				local AN = checkFOV(char.Head)
				if AN < MAXANGLE then
					MAXANGLE = AN
					toAIM = char.Head
				end
			end
		else
			toAIM = nil
		end
	end
end)

local rsconn = RunService.RenderStepped:Connect(function()
	if (toAIM) then
		AimAt(toAIM)
		if (toAIM:IsDescendantOf(getCharFromName(Player.Name))) then
			toAIM = nil
		end
	end
end)

shared[id] = true;
shared._unload = function()
	shared[id] = nil;
	conn:Disconnect();
	rsconn:Disconnect();
	msconn:Disconnect();
end
