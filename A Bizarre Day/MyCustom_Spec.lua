local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local Replicated = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");

local Player = Players.LocalPlayer;
local Character = Player.Character;
local Humanoid = Character.Humanoid;

local Mouse = Player:GetMouse();

local Connections = {};
local ATTACK = false;
local Attacks = {};
local Animations = {
	["Fire"] = "rbxassetid://3906084196";
	["MirrorToss"] = "rbxassetid://3910283013";
	["StrongPunch"] = "rbxassetid://3445806846";
	["Barrage"] = "rbxassetid://3445788051";
	["Shove"] = "rbxassetid://4646232248";

};
local AnimationData = {
	["Fire"] = {
		Start = 0.5;
		End = 1;
	};
	["MirrorToss"] = {
		Start = 0.75;
		End = 1.25;
	};
	["StrongPunch"] = {
		Start = 0.5;
		EndDamage = 0.75;
		End = 1;
	};
	["Shove"] = {
		Start = 0.5;
		EndDamage = 0.75;
		End = 1;
	};
};

local function IdToAnim(Id)
	local anim = Instance.new("Animation", Character.HumanoidRootPart)
	anim.AnimationId = Id;
	return Humanoid:LoadAnimation(anim);
end

for i, v in pairs(Animations) do
	pcall(function()
		Animations[i] = IdToAnim(v);
	end)
end

function Fwait(t)
	if (typeof(t) ~= "number") or (t <= 0) then
		RunService.RenderStepped:Wait();
	else
		local now = os.clock();
		while (os.clock() - now) < t do
			RunService.RenderStepped:Wait();
		end
	end
end

function GetHumanoidForEffect()
	local toReturn = nil;
	for _, e in pairs(workspace.Entities:GetChildren()) do
		if (Players:GetPlayerFromCharacter(e)) then -- Normal dummies cannot be used for effects.
			if (e == Character) then
				if (not toReturn) then
					toReturn = e.Humanoid;
				end
			else
				toReturn = e.Humanoid;
				return;
			end
		end
	end
	return toReturn;
end

function Sound(id, pitch, volume, atpos)
	local Args = {
		[1] = GetHumanoidForEffect(),
		[2] = (atpos or Character.HumanoidRootPart.CFrame),
		[3] = 0,
		[4] = 0,
		[5] = Vector3.new(),
		[6] = 9e999,
		[7] = "rbxassetid://".. tostring(id), 
		[8] = (pitch or 1), 
		[9] = (volume or 0.3)
	};
	Replicated.Damage12:FireServer(unpack(Args))
end

Attacks["r"] = function()
	ATTACK = true;
	Animations.StrongPunch:Play();
	Fwait(AnimationData.StrongPunch.Start)
	Sound(4255432837, math.random(75, 125)/100, 2)
	local aStart = os.clock();
	coroutine.wrap(function()
		while (os.clock() - aStart) < AnimationData.StrongPunch.EndDamage do
			hito(Character["Right Arm"], 2, Replicated.Damage12, {
				[1] = Character["Right Arm"].CFrame * CFrame.new(0, -1, 0),
				[2] = 80,
				[3] = 0.2,
				[4] = (Character.HumanoidRootPart.CFrame.LookVector * 50) + Vector3.new(0, 10, 0),
				[5] = 0.05,
				[6] = "rbxassetid://3041190784",
				[7] = math.random(75, 125)/100,
				[8] = math.random(200, 400)/100
			}, 0.5, true, true);
			Fwait();
		end
	end)()
	while (os.clock() - aStart) < AnimationData.StrongPunch.End do
		Fwait();
	end
	ATTACK = false;
end 

Attacks["v"] = function()
	ATTACK = true;
	Animations.StrongPunch:Play();
	Fwait(AnimationData.StrongPunch.Start)
	Sound(4255432837, math.random(75, 125)/100, 2)
	local aStart = os.clock();
	coroutine.wrap(function()
		while (os.clock() - aStart) < AnimationData.StrongPunch.EndDamage do
			hito(Character["Right Arm"], 2, Replicated.Damage12, {
				[1] = Character["Right Arm"].CFrame * CFrame.new(0, -1, 0),
				[2] = 80,
				[3] = 0.2,
				[4] = (Character.HumanoidRootPart.CFrame.LookVector * 200) + Vector3.new(0, 10, 0),
				[5] = 0.05,
				[6] = "rbxassetid://3041190784",
				[7] = math.random(75, 125)/100,
				[8] = math.random(200, 400)/100
			}, 0.5, true, true);
			hito(Character["Left Arm"], 2, Replicated.Damage12, {
				[1] = Character["Right Arm"].CFrame * CFrame.new(0, -1, 0),
				[2] = 80,
				[3] = 0.2,
				[4] = (Character.HumanoidRootPart.CFrame.LookVector * 20) + Vector3.new(0, 10, 0),
				[5] = 0.05,
				[6] = "rbxassetid://3041190784",
				[7] = math.random(75, 125)/100,
				[8] = math.random(200, 400)/100
			}, 0.5, true, true);
			Fwait();
		end
	end)()
	while (os.clock() - aStart) < AnimationData.StrongPunch.End do
		Fwait();
	end
	ATTACK = false;
end 

Attacks["e"] = function()
	ATTACK = true;
	Animations.Barrage:Play();
	Fwait(AnimationData.StrongPunch.Start)
	while (UserInputService:IsKeyDown(Enum.KeyCode.E)) do
		Sound(4255432837, math.random(75, 125)/100, 2)
		hito(Character["Right Arm"], 2, Replicated.Damage12, {
			[1] = Character["Right Arm"].CFrame * CFrame.new(0, -1, 0),
			[2] = 80,
			[3] = 0.2,
			[4] = (Character.HumanoidRootPart.CFrame.LookVector * 50) + Vector3.new(0, 10, 0),
			[5] = 0.05,
			[6] = "rbxassetid://3041190784",
			[7] = math.random(75, 125)/100,
			[8] = math.random(200, 400)/100
		}, 0.05, true, false);
		hito(Character["Left Arm"], 2, Replicated.Damage12, {
			[1] = Character["Left Arm"].CFrame * CFrame.new(0, -1, 0),
			[2] = 80,
			[3] = 0.2,
			[4] = (Character.HumanoidRootPart.CFrame.LookVector * 50) + Vector3.new(0, 10, 0),
			[5] = 0.05,
			[6] = "rbxassetid://3041190784",
			[7] = math.random(75, 125)/100,
			[8] = math.random(200, 400)/100
		}, 0.05, true, false);
		Fwait();
	end
	Animations.Barrage:Stop();
	ATTACK = false;
end 

table.insert(Connections, UserInputService.InputBegan:Connect(function(Input)
	if (UserInputService:GetFocusedTextBox()) then return; end
	if (Input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = Input.KeyCode;
		local Key = string.lower(KeyCode.Name);
		local Attack = Attacks[Key];
		if (not ATTACK and Attack) then
			Attack();
		end
	end
end))

function hito(part, magn, remote, args, hit_cd, knock, instakill)
	for _, e in pairs(workspace.Entities:GetChildren()) do
		coroutine.resume(coroutine.create(function()
			local RootPart = e:FindFirstChild("HumanoidRootPart");
			local Hum = e:FindFirstChild("Humanoid");
			local underCooldown = e:FindFirstChild("UnderHit_CD")
			if (e ~= Character) and (RootPart and Hum) and (not underCooldown) then
				if (RootPart.Position - part.Position).Magnitude <= magn then
					remote:FireServer(Hum, unpack(args));
					if (knock) then
						Replicated.Knock:FireServer(Hum);
					end
					coroutine.wrap(function()
						if (instakill) then
							for i = 1, 100 do
								local Args = {
									[1] = Hum,
									[2] = (Character.HumanoidRootPart.CFrame),
									[3] = 80,
									[4] = 0,
									[5] = Vector3.new(),
									[6] = 9e999,
									[7] = "rbxassetid://0", 
									[8] = 0, 
									[9] = 0
								};
								Replicated.Damage12:FireServer(unpack(Args))
							end
						end
					end)()
					if (hit_cd) then
						local CD = Instance.new("BoolValue", e);
						CD.Name = "UnderHit_CD";
						Debris:AddItem(CD, hit_cd)
					end
				end
			end
		end))
	end
end

local function Died()
	for _, c in pairs(Connections) do
		pcall(function()
			c:Disconnect()
		end)
	end
end

Humanoid.Died:Connect(Died);
Character.AncestryChanged:Connect(Died);
