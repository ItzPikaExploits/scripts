local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer;
local Character = Player.Character;

local Mouse = Player:GetMouse();
local Humanoid = Character.Humanoid;

local Hue = 0;

local BarrageAnim = Humanoid:LoadAnimation(Character.HumanoidRootPart.DefLoop)
local StrongPunchAnim = Humanoid:LoadAnimation(Character.HumanoidRootPart.Lunge)

local Attack = false;
local Died = false;

Humanoid.Died:Connect(function()
	Died = true;
end)
Player.CharacterAdded:Connect(function()
	Died = true;
end)

local CanGodMode = false;

function DoChargeAttack(HitPart, KeyCode, Animation, Wait)
	Attack = true;
	Animation:Play(0.1, 1, 0)
	local released = false;
	local connection = Mouse.KeyUp:Connect(function(Key)
		if (Key == KeyCode) then
			released = true;
		end
	end)
	repeat
		wait() 
		Replicated.Damage:FireServer(unpack({
			Humanoid,
			HitPart.CFrame * CFrame.new(0, 1, 0),
			0,
			0,
			Vector3.new(0, 0, 0),
			"rbxassetid://3909691881",
			0,
			Color3.fromHSV(Hue/360, 1, 1),
			"rbxassetid://5599573239",
			1,
			2
		}))
	until released;
	connection:Disconnect();
	Animation:AdjustSpeed(1)
	wait(Wait)
	for i = 0, 0.5, 0.03 do
		Replicated.Damage:FireServer(unpack({
			Humanoid,
			HitPart.CFrame * CFrame.new(0, 1, 0),
			0,
			0,
			Vector3.new(0, 0, 0),
			"rbxassetid://3909691881",
			0,
			Color3.fromHSV(Hue/360, 1, 1),
			"rbxassetid://5599573239",
			1,
			2
		}))
		for i, v in pairs(workspace.Entities:GetChildren()) do
			if (v ~= Character) and (v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid")) then
				if ((v.HumanoidRootPart.Position - HitPart.Position).Magnitude < 20) then
					Replicated.Damage:FireServer(unpack({
						v.Humanoid,
						HitPart.CFrame * CFrame.new(0, 1, 0),
						80,
						0.25,
						Vector3.new(0, 5, 0),
						"rbxassetid://3909691881",
						0.1,
						Color3.fromHSV(Hue/360, 1, 1),
						"rbxassetid://260430079",
						1,
						10
					}))
				end
			end
		end
		wait()
	end
	Attack = false;
end

Mouse.KeyDown:Connect(function(Key)
	if (Key == "l") then
		CanGodMode = not CanGodMode;
	end
	if (not CanGodMode) then return; end
	if (Attack) then return; end
	if (Died) then return; end
	if (Key == "x") then
		Attack = true;
		local released = false;
		local holdingw = false;
		local connection0 = Mouse.KeyUp:Connect(function(Key)
			if (Key == "x") then
				released = true;
			elseif (Key == "w") then
				holdingw = false;
			end
		end)
		local connection1 = Mouse.KeyDown:Connect(function(Key)
			if (Key == "w") then
				holdingw = true;
			end
		end)
		repeat
			wait() 
			Replicated.Damage:FireServer(unpack({
				Humanoid,
				Character["Right Leg"].CFrame * CFrame.new(0, -1, 0),
				0,
				0.1,
				(not holdingw and Vector3.new() or (Character.HumanoidRootPart.CFrame.lookVector * 100)) + Vector3.new(0, 25, 0),
				"rbxassetid://3909691881",
				0,
				Color3.fromHSV(Hue/360, 1, 1),
				"rbxassetid://5599573239",
				1,
				1
			}))
			Replicated.Damage:FireServer(unpack({
				Humanoid,
				Character["Left Leg"].CFrame * CFrame.new(0, -1, 0),
				0,
				0.1,
				(not holdingw and Vector3.new() or (Character.HumanoidRootPart.CFrame.lookVector * 100)) + Vector3.new(0, 25, 0),
				"rbxassetid://3909691881",
				0,
				Color3.fromHSV(Hue/360, 1, 1),
				"rbxassetid://5599573239",
				1,
				1
			}))
		until released;
		connection0:Disconnect();
		connection1:Disconnect();
		Attack = false;
	end
	if (Key == "e") then
		Attack = true;
		local Speed = 5;
		BarrageAnim:Play(0.1, 1, Speed)
		local released = false;
		local connection = Mouse.KeyUp:Connect(function(Key)
			if (Key == "e") then
				released = true;
			end
		end)
		repeat
			wait()
			Replicated.Damage:FireServer(unpack({
				Humanoid,
				Character.Stand["Blade"].CFrame * CFrame.new(0, 1, 0),
				0,
				0,
				Vector3.new(0, 0, 0),
				"rbxassetid://3909691881",
				0,
				Color3.fromHSV(Hue/360, 1, 1),
				"rbxassetid://6986412512",
				1,
				2
			}))
			hito(Character.Stand["Blade"], 45, 7, "rbxassetid://5256332728")
		until released;
		connection:Disconnect();
		BarrageAnim:Stop()
		Attack = false;
	end
	if (Key == "v") then
		DoChargeAttack(Character.Stand["Blade"], "v", StrongPunchAnim, 0.5)
	end
end)

function hito(HitPart, Damage, Mag, SoundId)
	coroutine.resume(coroutine.create(function()
		for i, v in pairs(workspace.Entities:GetChildren()) do
			if (v ~= Character) and (v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid")) then
				if ((v.HumanoidRootPart.Position - HitPart.Position).Magnitude < Mag) then
					Replicated.Damage:FireServer(unpack({
						v.Humanoid,
						HitPart.CFrame * CFrame.new(0, 1, 0),
						Damage,
						0.25,
						Vector3.new(0, 5, 0),
						"rbxassetid://3909691881",
						0.1,
						Color3.fromHSV(Hue/360, 1, 1),
						SoundId,
						1,
						10
					}))
				end
			end
		end
	end))
end

local r = 5; --radius is commonly represented as a lowercase r in geometrical calculation
local rps = math.pi; --abbreviation for radians per second. note that pi radians equals 180 degrees

local angle = 0;

game:GetService("RunService").RenderStepped:Connect(function(dt)
	if (Hue >= 360) then
		Hue = 0;
	else
		Hue = Hue +  1;
	end
	if (not Died) and (not Attack) then
		angle = (angle + dt * rps) % (2 * math.pi);
		if (CanGodMode) then
			Replicated.Damage:FireServer(unpack({
				Humanoid,
				CFrame.new(Character.HumanoidRootPart.Position) * CFrame.new(math.cos(angle) * r, 0, math.sin(angle) * r),
				0,
				0,
				Vector3.new(0, 0, 0),
				"rbxassetid://3909691881",
				0,
				Color3.fromHSV(Hue/360, 1, 1),
				"rbxassetid://5599573239",
				1,
				0
			}))
		end
	end
end)
