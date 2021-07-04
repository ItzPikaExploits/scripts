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
local POSING = false;
local Attacks = {};
local Animations = {
	["Fire"] = "rbxassetid://3906084196";
	["MirrorToss"] = "rbxassetid://3910283013";
	["StrongPunch"] = "rbxassetid://3445806846";
	["Barrage"] = "rbxassetid://3445788051";
	["Shove"] = "rbxassetid://4646232248";
	["Yell"] = "rbxassetid://3469508283";
	["Pose1"] = "rbxassetid://5577817478";
	["Pose2"] = "rbxassetid://5577813044";
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
		EndDamage = 0.55;
		End = 1;
	};
	["Shove"] = {
		Start = 0.5;
		EndDamage = 0.6;
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
	--[[
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
	--]]
	toReturn = Character.Humanoid;
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

local lasteffect = 0;
local effectremotes = {
	Replicated.Damage12,
	Replicated.Damage12Sans,
	Replicated.Damage12Enderman,
};

function ballofepic(size, atpos)
	if (lasteffect + 1) > 3 then
		lasteffect = 1;
	else
		lasteffect += 1;
	end
	local Args = {
		[1] = GetHumanoidForEffect(),
		[2] = (atpos or Character.HumanoidRootPart.CFrame),
		[3] = 0,
		[4] = 0,
		[5] = Vector3.new(),
		[6] = size,
		[7] = "rbxassetid://0", 
		[8] = 0, 
		[9] = 0
	};
	effectremotes[lasteffect]:FireServer(unpack(Args))
end

Attacks["r"] = function()
	ATTACK = true;
	Animations.StrongPunch:Play();
	Fwait(AnimationData.StrongPunch.Start)
	Sound(4255432837, math.random(75, 125)/100, 2)
	local aStart = os.clock();
	coroutine.wrap(function()
		while (os.clock() - aStart) < AnimationData.StrongPunch.EndDamage do
			ballofepic(0.01, Character["Right Arm"].CFrame * CFrame.new(0, -1, 0))
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
	Animations.Shove:Play()
	Sound(6938585744, 1, 5)
	local aStart = os.clock();
	Fwait(AnimationData.Shove.Start)
	coroutine.wrap(function()
		while (os.clock() - aStart) < AnimationData.Shove.EndDamage do
			hito(Character["Right Arm"], 2, Replicated.Damage12, {
				[1] = Character["Right Arm"].CFrame * CFrame.new(0, -1, 0),
				[2] = 80,
				[3] = 0.2,
				[4] = (Character.HumanoidRootPart.CFrame.LookVector * 1000) + Vector3.new(0, 500, 0),
				[5] = 0.05,
				[6] = "rbxassetid://3041190784",
				[7] = math.random(75, 125)/100,
				[8] = math.random(200, 400)/100
			}, 0.5, true, true);
			hito(Character["Left Arm"], 2, Replicated.Damage12, {
				[1] = Character["Left Arm"].CFrame * CFrame.new(0, -1, 0),
				[2] = 80,
				[3] = 0.2,
				[4] = (Character.HumanoidRootPart.CFrame.LookVector * 1000) + Vector3.new(0, 500, 0),
				[5] = 0.05,
				[6] = "rbxassetid://3041190784",
				[7] = math.random(75, 125)/100,
				[8] = math.random(200, 400)/100
			}, 0.5, true, true);
			Fwait();
		end
		ballofepic(0.03, Character["Right Arm"].CFrame * CFrame.new(0, -1, 0))
		ballofepic(0.03, Character["Left Arm"].CFrame * CFrame.new(0, -1, 0))
	end)()
	while (os.clock() - aStart) < AnimationData.Shove.End do
		Fwait();
	end
	ATTACK = false;
end 

Attacks["e"] = function()
	ATTACK = true;
	Sound(847061203, 1.1, 5)
	Animations.StrongPunch:Play();
	local now = os.clock()
	while (os.clock() - now) < (AnimationData.StrongPunch.Start) do
		ballofepic(0.01, Character["Right Arm"].CFrame * CFrame.new(0, -1, 0))
		ballofepic(0.01, Character["Left Arm"].CFrame * CFrame.new(0, -1, 0))
		Fwait()
	end
	Animations.StrongPunch:Stop();
	Animations.Barrage:Play(0.1, 1, 3);
	while (UserInputService:IsKeyDown(Enum.KeyCode.E)) do
		ballofepic(0.01, Character["Right Arm"].CFrame * CFrame.new(0, -1, 0))
		ballofepic(0.01, Character["Left Arm"].CFrame * CFrame.new(0, -1, 0))
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

Attacks["b"] = function()
	ATTACK = true;
	Sound(847061203, 1.5, 5)
	Animations.Yell:Play(0.1, 1, 1);
	wait(0.25);
	Animations.Yell:AdjustSpeed(0)
	local now = os.clock();
	local lastbump = os.clock()
	while (os.clock() - now) < 10 do
		ballofepic(0.5)
		if (os.clock() - lastbump) >= 0.5 then
			lastbump = os.clock();
			Sound(847061203, 1, 10);
		end
		Fwait();
	end
	Animations.Yell:AdjustSpeed(1)
	for _, e in pairs(workspace.Entities:GetChildren()) do
		coroutine.resume(coroutine.create(function()
			local RootPart = e:FindFirstChild("HumanoidRootPart");
			local Hum = e:FindFirstChild("Humanoid");
			if (RootPart and Hum) and (e ~= Character) then
				Replicated.SamuraiDamage2:FireServer(unpack({
					Hum,
					100000000000000,
					RootPart
				}));
				Sound(741272936, 0.8, 10);
			end
		end))
	end
	for i = 1, 20 do
		ballofepic(2)
	end
	Sound(741272936, 1, 10);
	Sound(429123896, 1, 10);
	Sound(1208650519, 1, 10);
	ATTACK = false;
end 

Attacks["p"] = function()
	ATTACK = true
	Animations.Yell:Play(0.1, 1, 1);
	wait(0.25)
	for i = 1, 10 do
		ballofepic(0.1)
		Replicated.SamuraiDamage2:FireServer(unpack({
			Humanoid,
			-1000000000000,
			Character.HumanoidRootPart
		}))
	end
	Sound(206082327, 1, 2.5)
	Sound(847061203, 1, 5)
	Sound(239000203, 1, 2.5)
	Sound(579687077, 0.75, 2.5)
	Humanoid.WalkSpeed *= 2
	wait(0.5);
	ATTACK = false
end

function PoseFunc()
	if (ATTACK and not POSING) then return; end
	if (not POSING) then
		ATTACK = true;
		Animations.Pose1:Play()
		Humanoid.WalkSpeed = 0;
		Humanoid.JumpPower = 0;
		spawn(function()
			wait(1.49);
			Animations.Pose2:Play()
		end)
		wait(1.5);
		POSING = true;
		coroutine.wrap(function()
			while (POSING) do
				ballofepic(0.02, Character["Right Arm"].CFrame * CFrame.new(0, -1, 0))
				Fwait()
			end
		end)()
	elseif (POSING) then
		Animations.Pose1:Stop(0.3)
		Animations.Pose2:Stop(0.3)
		Humanoid.WalkSpeed = 18;
		Humanoid.JumpPower = 60;
		ATTACK = false;
		POSING = false;
	end
end

table.insert(Connections, UserInputService.InputBegan:Connect(function(Input)
	if (UserInputService:GetFocusedTextBox()) then return; end
	if (Input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = Input.KeyCode;
		local Key = string.lower(KeyCode.Name);
		local Attack = Attacks[Key];
		if (not ATTACK and Attack) then
			Attack();
		else
			if (Key == "g") then
				PoseFunc()
			end
		end
	end
end))

function nametoplayers(name)
	local plyrs = {};
	for _, name in pairs(name:split(",")) do
		if (name == "all") then
			plyrs = Players:GetPlayers();
		elseif (name == "others") then
			plyrs = Players:GetPlayers();
			local pi = table.find(plyrs, Player);
			if (pi) then
				table.remove(plyrs, pi)
			end
		elseif (name == "me") then
			table.insert(plyrs, Player);
		else
			for _, p in pairs(Players:GetPlayers()) do
				if (p.Name:lower():sub(1, #name) == name:lower()) then
					table.insert(plyrs, p)
				end
			end
		end
	end
	return plyrs;
end

table.insert(Connections, Player.Chatted:Connect(function(msg)
	if (msg:sub(1,3) == "/e ") then
		msg = msg:sub(4)
	end
	if (msg:sub(1,1) == ";") then
		msg = msg:sub(2);
		local args = msg:split(" ");
		if (args[1] == "playsound") then
			Sound(tonumber(args[2]), (tonumber(args[3]) or 1), (tonumber(args[4]) or 10))
		elseif (args[1] == "god") then
			if (not args[2]) then
				args[2] = "me";
			end
			local plyrs = nametoplayers(args[2]);
			for _, p in pairs(plyrs) do
				pcall(function()
					Replicated.SamuraiDamage2:FireServer(unpack({
						p.Character.Humanoid,
						-10000000000000000,
						p.Character.HumanoidRootPart
					}));
				end)
			end
		elseif (args[1] == "kill") then
			if (not args[2]) then
				args[2] = "me";
			end
			local plyrs = nametoplayers(args[2]);
			for _, p in pairs(plyrs) do
				pcall(function()
					Replicated.SamuraiDamage2:FireServer(unpack({
						p.Character.Humanoid,
						10000000000000000,
						p.Character.HumanoidRootPart
					}));
				end)
			end
		elseif (args[1] == "heal") then
			if (not args[2]) then
				args[2] = "me";
			end
			local plyrs = nametoplayers(args[2]);
			for _, p in pairs(plyrs) do
				pcall(function()
					Replicated.SamuraiDamage2:FireServer(unpack({
						p.Character.Humanoid,
						-(p.Character.Humanoid.MaxHealth - p.Character.Humanoid.Health),
						p.Character.HumanoidRootPart
					}));
				end)
			end
		elseif (args[1] == "fling") then
			if (not args[2]) then
				args[2] = "me";
			end
			local plyrs = nametoplayers(args[2]);
			for _, p in pairs(plyrs) do
				pcall(function()
					Replicated.Damage12:FireServer(p.Character.Humanoid, unpack({
						[1] = CFrame.new(),
						[2] = 0,
						[3] = 0.2,
						[4] = (p.Character.HumanoidRootPart.CFrame.LookVector * 10000) + Vector3.new(0, 100000, 0),
						[5] = 9e999,
						[6] = "rbxassetid://0",
						[7] = 0,
						[8] = 0
					}))
				end)
			end
		elseif (args[1] == "to") then
			if (not args[2]) then
				return;
			end
			local p2 = nametoplayers(args[2])[1];
			if (p2) then
			    Character.HumanoidRootPart.CFrame = p2.Character.HumanoidRootPart.CFrame;
			end
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

-- on Start
Animations.Yell:Play(0.1, 1, 1);
wait(0.25)
for i = 1, 10 do
	ballofepic(0.1)
	Replicated.SamuraiDamage2:FireServer(unpack({
		Humanoid,
		-1000000000000,
		Character.HumanoidRootPart
	}))
end
Sound(206082327, 1, 2.5)
Sound(847061203, 1, 5)
Sound(239000203, 1, 2.5)
Sound(579687077, 0.75, 2.5)
Sound(294861193, 1.2, 10)
