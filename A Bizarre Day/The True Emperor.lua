local Players = game:GetService("Players")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer;
local Character = Player.Character;

local Mouse = Player:GetMouse();
local Humanoid = Character.Humanoid;

local Hue = 0;

local StrongPunchAnim = Humanoid:LoadAnimation(Character.HumanoidRootPart.Headshot)

function GetBarrel()
    local Part = nil;
    for _, c in pairs(Character.Stand:GetChildren()) do
        if (c.Name == "MeshPart" and c.BrickColor == BrickColor.new("Really black")) then
            Part = c;
            break;
        end
    end
    return Part;
end

local Attack = false;
local Died = false;

Humanoid.Died:Connect(function()
	Died = true;
end)
Player.CharacterAdded:Connect(function()
	Died = true;
end)

local CanGodMode = false;
local SilentBullets = false;

local function CreateSilentBall(CF)
    local Part = Instance.new("Part", workspace.Effects)
    Part.Color = Color3.fromHSV(Hue/360, 1, 1)
    Part.CanCollide = false;
    Part.Anchored = true;
    Part.Material = "Neon";
    Part.CFrame = CF;
    Part.Size = Vector3.new(1.5, 1.5, 1.5)
    Instance.new("SpecialMesh", Part).MeshType = "Sphere"
    game.TweenService:Create(Part, TweenInfo.new(0.5), {
        Size = Vector3.new(0, 0, 0);
    }):Play()
    game.Debris:AddItem(Part, 0.5)
end

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
			HitPart.CFrame,
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
	for i = 0, 100 do
		Replicated.Damage:FireServer(unpack({
			Humanoid,
			HitPart.CFrame,
			0,
			0,
			Vector3.new(0, 0, 0),
			"rbxassetid://3909691881",
			0,
			BrickColor.Random().Color,
			"rbxassetid://5599573239",
			1,
			2
		}))
		hito(HitPart, 80, 5, "rbxassetid://5256332728")
	end
	Attack = false;
end

Mouse.KeyDown:Connect(function(Key)
	if (Key == "l") then
		CanGodMode = not CanGodMode;
	elseif (Key == "k") then
	    SilentBullets = not SilentBullets
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
		local released = false;
		local connection = Mouse.KeyUp:Connect(function(Key)
			if (Key == "e") then
				released = true;
			end
		end)
		StrongPunchAnim:Play(0.1, 1, 0)
		repeat
		    if (not SilentBullets) then
    			Replicated.Damage:FireServer(unpack({
    				Humanoid,
    				GetBarrel().CFrame,
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
    		elseif (SilentBullets) then
    		    CreateSilentBall(GetBarrel().CFrame)
    		end
		    wait()
		until released;
		connection:Disconnect();
		StrongPunchAnim:AdjustSpeed(1)
		wait(0.5);
		Attack = false;
		local oPos = CFrame.new(GetBarrel().Position, Mouse.Hit.p);
		for i = 1, 50 do
		    local nPos = oPos * CFrame.new(0, 0, -(i * 10))
		    if (not SilentBullets) then
    			Replicated.Damage:FireServer(unpack({
    				Humanoid,
    				nPos,
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
    		elseif (SilentBullets) then
    		    CreateSilentBall(nPos)
    		end
			hito({
			    Position = nPos.p;
			    CFrame = nPos;
			}, 80, 10, "rbxassetid://5256332728")
		    wait()
		end
	end
	if (Key == "v") then
		Attack = true;
		local released = false;
		local connection = Mouse.KeyUp:Connect(function(Key)
			if (Key == "v") then
				released = true;
			end
		end)
		StrongPunchAnim:Play(0.1, 1, 0)
		repeat
		    if (not SilentBullets) then
    			Replicated.Damage:FireServer(unpack({
    				Humanoid,
    				GetBarrel().CFrame,
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
    		elseif (SilentBullets) then
    		    CreateSilentBall(GetBarrel().CFrame)
    		end
		    wait()
		until released;
		connection:Disconnect();
		StrongPunchAnim:AdjustSpeed(1)
		wait(0.5);
		Attack = false;
		local oPos = CFrame.new(GetBarrel().Position, Mouse.Hit.p);
		for i = 1, 25 do
		    local nPos = oPos * CFrame.new(0, 0, -(i * 5))
		    if (not SilentBullets) then
    			Replicated.Damage:FireServer(unpack({
    				Humanoid,
    				nPos,
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
    		elseif (SilentBullets) then
    		    CreateSilentBall(nPos)
    		end
			hito({
			    Position = nPos.p;
			    CFrame = nPos;
			}, 80, 20, "rbxassetid://5256332728", 100)
		    wait()
		end
	end
end)

function hito(HitPart, Damage, Mag, SoundId, DamageMultiplier)
	coroutine.resume(coroutine.create(function()
		for i, v in pairs(workspace.Entities:GetChildren()) do
			if (v ~= Character) and (v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid")) then
				if ((v.HumanoidRootPart.Position - HitPart.Position).Magnitude < Mag) then
					for i = 1, (DamageMultiplier or 1) do
    					Replicated.Damage:FireServer(unpack({
    						v.Humanoid,
    						HitPart.CFrame,
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
		end
	end))
end

local r = 5; --radius is commonly represented as a lowercase r in geometrical calculation
local rps = math.pi * 2; --abbreviation for radians per second. note that pi radians equals 180 degrees

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
		    local CF = CFrame.new(Character.HumanoidRootPart.Position) * CFrame.new(math.cos(angle) * r, 0, math.sin(angle) * r)
		    if (not SilentBullets) then
    			Replicated.Damage:FireServer(unpack({
    				Humanoid,
    				CF,
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
    		elseif (SilentBullets) then
    		    CreateSilentBall(CF)
    		end
		end
	end
end)
