-- Gay Shadow Killer Queen Act 4

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StrongPunch__2 = l__ReplicatedStorage__1.StrongPunch;
local l__Velocity__3 = l__ReplicatedStorage__1.Velocity;
local l__Knock__4 = l__ReplicatedStorage__1.Knock;
local l__LocalPlayer__5 = game:GetService("Players").LocalPlayer;
while true do
	wait();
	if l__LocalPlayer__5.Character and l__LocalPlayer__5.Character.Humanoid then
		break;
	end;
end;
local l__Character__6 = l__LocalPlayer__5.Character;
local l__Humanoid__7 = l__Character__6.Humanoid;
mouse = l__LocalPlayer__5:GetMouse();
cam = workspace.CurrentCamera;
local v8 = { "\226\153\136", "\226\153\137", "\226\153\138", "\226\153\139", "\226\153\140", "\226\153\141", "\226\153\142", "\226\153\143", "\226\153\144", "\226\153\145", "\226\153\146", "\226\153\147" };
local l__Stand__9 = l__Character__6:WaitForChild("Stand");
local l__StandHumanoidRootPart__10 = l__Stand__9:WaitForChild("StandHumanoidRootPart");
local l__Stand_Head__11 = l__Stand__9:WaitForChild("Stand Head");
local l__Stand_Torso__12 = l__Stand__9:WaitForChild("Stand Torso");
local l__Stand_Right_Leg__13 = l__Stand__9:WaitForChild("Stand Right Leg");
local l__Stand_Left_Leg__14 = l__Stand__9:WaitForChild("Stand Left Leg");
local u1 = false;
local u2 = false;
local u3 = true;
local u4 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.Nothing);
local u5 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.Idle);
local l__StandAppear__6 = l__StandHumanoidRootPart__10.StandAppear;
local l__Transparency__7 = l__ReplicatedStorage__1.Transparency;
local l__face__8 = l__Stand__9:WaitForChild("OuterHead"):WaitForChild("face");
l__LocalPlayer__5.Backpack.Client["scr-KillerQueen"].Disabled = true;
function standappear(u3)
	if u3 == true then
		u4:Stop();
		--u5:Play(0.2, 1, 1);
		l__StandAppear__6:Play();
        for _, p in pairs(l__Stand__9:GetChildren()) do
            if (p:IsA("BasePart") or p:IsA("Decal")) then
                if (p.Name ~= "StandHumanoidRootPart") then
                    if (p.Name:match("Leg")) then
                        game.ReplicatedStorage.Transparency:FireServer(p, 1)
                    else
                        game.ReplicatedStorage.Transparency:FireServer(p, 0.5)
                    end
                end
            end
        end
	elseif u3 == false then
		u5:Stop();
		u4:Play(0.2, 1, 1);
        for _, p in pairs(l__Stand__9:GetChildren()) do
            if (p:IsA("BasePart") or p:IsA("Decal")) then
                if (p.Name ~= "StandHumanoidRootPart") then
                    game.ReplicatedStorage.Transparency:FireServer(p, 1)
                end
            end
        end
	end;
end;
local u9 = false;
local l__Trail__10 = l__ReplicatedStorage__1.Trail;
local l__Stand_Right_Arm__11 = l__Stand__9:WaitForChild("Stand Right Arm");
local l__Stand_Left_Arm__12 = l__Stand__9:WaitForChild("Stand Left Arm");
local u13 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.PunchBarrage);
local l__Rush__14 = l__StandHumanoidRootPart__10.Rush;
local u15 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.AttackPose);
local l__Rush2__16 = l__StandHumanoidRootPart__10.Rush2;
local u17 = 0;
local l__Disabled__18 = l__Character__6:WaitForChild("Disabled");
print("uwu")
function barrage()
	if u1 == true then
	    print("physically")
		return;
	end;
	if u9 == true then
	    print("cannot")
		return;
	end;
	if u3 == false then
	    print("D:")
		return;
	end;
	u1 = true;
	u9 = true;
	standappear(true)
	local u19 = true;
	local v27 = mouse.KeyUp:connect(function(p2)
		if p2 == "e" then
			u19 = false;
		end;
	end);
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, true);
	l__Trail__10:FireServer(l__Stand_Left_Arm__12.Trail, true);
	u13:Play(0.1, 1, 1.25);
	l__Rush__14:Play();
	coroutine.resume(coroutine.create(function()
		u15:Play();
		l__Humanoid__7.JumpPower = 0;
		l__Rush2__16:Play();
	end));
	repeat
		u17 = u17 + 1;
		hito(l__Stand_Right_Arm__11, l__Stand_Right_Arm__11.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 2, 999999, 0.1, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 2.5, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 50);
		hito(l__Stand_Left_Arm__12, l__Stand_Left_Arm__12.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 2, 999999, 0.1, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 2.5, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 50);
		wait(0.1);
	until (40 <= u17) or not u19
	u17 = 0;
	standappear(false)
	l__Rush__14:Stop();
	l__Rush2__16:Stop();
	u15:Stop();
	l__Humanoid__7.JumpPower = 50;
	u13:Stop(0.1);
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, false);
	l__Trail__10:FireServer(l__Stand_Left_Arm__12.Trail, false);
	u1 = false;
	u9 = false;
end;
local u20 = false;
local u21 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.Block);
local l__Block__22 = l__ReplicatedStorage__1.Block;
local l__Guard__23 = l__StandHumanoidRootPart__10.Guard;
local u24 = 0;
function block()
	if u20 == true then
		return;
	end;
	if u1 == true then
		return;
	end;
	if u3 == false then
		return;
	end;
	u1 = true;
	standappear(true)
	local u25 = true;
	local v28 = mouse.KeyUp:connect(function(p3)
		if p3 == "x" then
			u25 = false;
		end;
	end);
	u21:Play(0.1, 1, 1);
	l__Block__22:FireServer(true);
	u20 = true;
	l__Guard__23:Play();
	l__Humanoid__7.JumpPower = 0;
	while true do
		u24 = u24 + 1;
		wait();
		if u25 ~= false then

		else
			break;
		end;	
	end;
	standappear(false)
	l__Block__22:FireServer(false);
	u21:Stop(0.1);
	l__Humanoid__7.JumpPower = 50;
	u1 = false;
	u20 = false;
end;
local l__Punch__26 = l__StandHumanoidRootPart__10.Punch;
local u27 = false;
local u28 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.RightPunch);
local u29 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.LeftPunch);
function punch()
	if u1 == true then
		return;
	end;
	if u3 == false then
		return;
	end;
	u1 = true;
	l__Punch__26:Play();
	u15:Play();
	standappear(true)
	l__Humanoid__7.JumpPower = 0;
	if u27 == false then
		u27 = true;
		u28:Play(0.1, 1, 1);
		l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, true);
		wait(0.2);
		coroutine.resume(coroutine.create(function()
			local v29 = 1 - 1;
			while true do
				wait();
				hito(l__Stand_Right_Arm__11, l__Stand_Right_Arm__11.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 2.5, 7.5, 0.5, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 10, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 25);
				if 0 <= 1 then
					if v29 < 5 then

					else
						break;
					end;
				elseif 5 < v29 then

				else
					break;
				end;
				v29 = v29 + 1;			
			end;
		end));
	elseif u27 == true then
		u27 = false;
		u29:Play(0.1, 1, 1);
		l__Trail__10:FireServer(l__Stand_Left_Arm__12.Trail, true);
		wait(0.2);
		coroutine.resume(coroutine.create(function()
			local v30 = 1 - 1;
			while true do
				wait();
				hito(l__Stand_Left_Arm__12, l__Stand_Left_Arm__12.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 2.5, 7.5, 0.5, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 10, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 25);
				if 0 <= 1 then
					if v30 < 5 then

					else
						break;
					end;
				elseif 5 < v30 then

				else
					break;
				end;
				v30 = v30 + 1;			
			end;
		end));
	end;
	wait(0.3);
	standappear(false)
	u15:Stop();
	l__Humanoid__7.JumpPower = 50;
	u1 = false;
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, false);
	l__Trail__10:FireServer(l__Stand_Left_Arm__12.Trail, false);
end;
local u30 = false;
local u31 = nil;
local l__HeavyPunch__32 = l__StandHumanoidRootPart__10.HeavyPunch;
local l__PrimaryBomb__33 = l__StandHumanoidRootPart__10.PrimaryBomb;
local u34 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.StrongPunch);
function bomb()
    if l__Character__6.Bomb.Value == true then
		return;
	end;
	u1 = true;
	u31 = true;
	u30 = true;
	l__HeavyPunch__32:Play();
	l__PrimaryBomb__33:Play();
	u15:Play();
	l__Humanoid__7.JumpPower = 0;
	u34:Play(0.1, 1, 1);
	standappear(true)
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, true);
	wait(0.5);
	coroutine.resume(coroutine.create(function()
		local v31 = 1 - 1;
		while true do
			wait();
			hito2(l__Stand_Right_Arm__11, l__Stand_Right_Arm__11.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 3, 2.5, 0.75, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 25, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 10);
			if 0 <= 1 then
				if v31 < 15 then

				else
					break;
				end;
			elseif 15 < v31 then

			else
				break;
			end;
			v31 = v31 + 1;		
		end;
	end));
	wait(0.65);
	standappear(false)
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, false);
	u15:Stop();
	l__Humanoid__7.JumpPower = 50;
	u1 = false;
	u30 = false;
end;
local u35 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.Detonate);
local l__Bomb__36 = l__StandHumanoidRootPart__10.Bomb;
local l__BombDamage__37 = l__ReplicatedStorage__1.BombDamage;
function detonate()
	if l__Character__6.Bomb.Value == false then
		return;
	end;
	u1 = true;
	u35:Play();
	standappear(true)
	wait(0.5);
	standappear(false)
	l__Bomb__36:Play();
	l__BombDamage__37:FireServer(60);
	u1 = false;
end;
local u38 = false;
local u39 = false;
local l__TertiaryBomb__40 = l__StandHumanoidRootPart__10.TertiaryBomb;
local u41 = 0;
function btd()
	if l__Character__6.Bomb.Value == true then
		return;
	end;
	u1 = true;
	u31 = false;
	u38 = true;
	u39 = true;
	l__HeavyPunch__32:Play();
	l__TertiaryBomb__40:Play();
	u15:Play();
	l__Humanoid__7.JumpPower = 0;
	u34:Play(0.1, 1, 1);
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, true);
	standappear(true)
	wait(0.5);
	coroutine.resume(coroutine.create(function()
		local v32 = 1 - 1;
		while true do
			wait();
			hito2(l__Stand_Right_Arm__11, l__Stand_Right_Arm__11.CFrame * CFrame.new(0, -1, 0) * CFrame.new(math.random(-0.25, 0.25), math.random(-0.25, 0.25), math.random(-0.25, 0.25)), 6, 2.5, 0.75, 0.25, l__StandHumanoidRootPart__10.CFrame.lookVector * 25, "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 10);
			if 0 <= 1 then
				if v32 < 15 then

				else
					break;
				end;
			elseif 15 < v32 then

			else
				break;
			end;
			v32 = v32 + 1;		
		end;
		while true do
			wait(0.1);
			u41 = u41 + 0.1;
			if u39 ~= false then

			else
				break;
			end;		
		end;
	end));
	wait(0.65);
	standappear(false)
	l__Trail__10:FireServer(l__Stand_Right_Arm__11.Trail, false);
	u15:Stop();
	l__Humanoid__7.JumpPower = 50;
	u1 = false;
	u38 = false;
end;
local l__BitesZaDusto__42 = l__StandHumanoidRootPart__10.BitesZaDusto;
local l__BTDDamage__43 = l__ReplicatedStorage__1.BTDDamage;
local u44 = nil;
local u45 = nil;
local u46 = nil;
local u47 = nil;
function detonatebtd()
	if l__Character__6.Bomb.Value == false then
		return;
	end;
	u1 = true;
	u35:Play();
	u39 = false;
	standappear(true)
	wait(0.5);
	standappear(false)
	l__BitesZaDusto__42:Play();
	l__Bomb__36:Play();
	game.ReplicatedStorage.DoppioSlam:FireServer()
	hito(l__Stand_Right_Arm__11, CFrame.new(), 70, 999999, 0, 0.25, Vector3.new(0, 100, 0), "rbxassetid://241837157", 0.075, Color3.new(255, 255, 255), "rbxassetid://260430079", math.random(9, 11) / 10, math.random(9, 11) / 50);
	--l__BTDDamage__43:FireServer(65, u44, u45, u46, u47, u41);
	u1 = false;
end;
local u48 = false;
local l__Coin__49 = l__ReplicatedStorage__1.Coin;
function cointhrow()
	if l__Character__6.Bomb.Value == true then
		return;
	end;
	u48 = true;
	u1 = true;
	u34:Play(0.1, 1, 1);
	l__Humanoid__7.JumpPower = 0;
	standappear(true)
	wait(0.5);
	l__Coin__49:FireServer();
	l__Punch__26:Play();
	wait(0.5);
	standappear(false)
	u1 = false;
	u31 = true;
	l__Humanoid__7.JumpPower = 50;
	u48 = false;
end;
local u50 = false;
local u51 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.StandJump);
local l__StandJumpSFX__52 = l__StandHumanoidRootPart__10.StandJumpSFX;
local l__Jump__53 = l__ReplicatedStorage__1.Jump;
local l__HumanoidRootPart__54 = l__Character__6.HumanoidRootPart;
function movement()
	if u1 == true then
		return;
	end;
	if u50 == true then
		return;
	end;
	if u3 == false then
		return;
	end;
	u50 = true;
	u1 = true;
	u51:Play(0.1, 1, 1);
	l__StandJumpSFX__52:Play();
	standappear(true)
	l__Jump__53:FireServer(BrickColor.new("Institutional white"));
	local v33 = Instance.new("BodyPosition", l__HumanoidRootPart__54);
	v33.maxForce = Vector3.new(100000, 100000, 100000);
	v33.Position = l__HumanoidRootPart__54.CFrame * CFrame.new(0, 50, -75).p;
	game.Debris:AddItem(v33, 1);
	wait(1);
	standappear(false)
	u1 = false;
	u50 = false;
end;
local u55 = false;
local u56 = false;
local l__SHA__57 = l__ReplicatedStorage__1.SHA;
function sheerheartattack()
	if u1 == true then
		return;
	end;
	if u55 == true then
		return;
	end;
	if u3 == false then
		return;
	end;
	if u56 == false then
		l__SHA__57:FireServer(true);
		u56 = true;
		return;
	end;
	if u56 == true then
		l__SHA__57:FireServer(false);
		u56 = false;
		u55 = true;
		wait(30);
		u55 = false;
	end;
end;
local u58 = false;

local Pose1 = Instance.new("Animation", l__Humanoid__7)
Pose1.AnimationId = "rbxassetid://5791704895"
local Pose2 = Instance.new("Animation", l__Humanoid__7)
Pose2.AnimationId = "rbxassetid://5791676263"
local CounterPose = Instance.new("Animation", l__Humanoid__7)
CounterPose.AnimationId = "rbxassetid://5791659791"
local cPoseAnim = l__Humanoid__7:LoadAnimation(CounterPose)

local u59 = l__Humanoid__7:LoadAnimation(Pose1);
local u60 = l__Humanoid__7:LoadAnimation(Pose2);

local l__Menacing__61 = l__ReplicatedStorage__1.Menacing;
function posefunc()
	if u1 == false then
		if u58 == false then
			if u3 == false then
				return;
			end;
			if u58 == false then
				u1 = true;
	            standappear(true)
				local v34 = math.random(1, 2);
				u59:Play(0.1, 1, 1);
				l__Humanoid__7.WalkSpeed = 0;
				l__Humanoid__7.JumpPower = 0;
				wait(1.4)
				u60:Play(0.1, 1, 1);
				wait(0.1)
				u58 = true;
				l__Menacing__61:FireServer(true);
				return;
			end;
		elseif u58 == true then
			u59:Stop(0.3);
			u60:Stop(0.3);
	        standappear(false)
			if l__Disabled__18.Value == false then
				l__Humanoid__7.WalkSpeed = 16;
				l__Humanoid__7.JumpPower = 50;
			elseif l__Disabled__18.Value == true then
				l__Humanoid__7.WalkSpeed = 4;
				l__Humanoid__7.JumpPower = 10;
			end;
			u1 = false;
			u58 = false;
			l__Menacing__61:FireServer(false);
		end;
	elseif u58 == true then
		u59:Stop(0.3);
		u60:Stop(0.3);
	        standappear(false)
		if l__Disabled__18.Value == false then
			l__Humanoid__7.WalkSpeed = 16;
			l__Humanoid__7.JumpPower = 50;
		elseif l__Disabled__18.Value == true then
			l__Humanoid__7.WalkSpeed = 4;
			l__Humanoid__7.JumpPower = 10;
		end;
		u1 = false;
		u58 = false;
		l__Menacing__61:FireServer(false);
	end;
end;
dodgecooldown = false;
local u62 = l__Humanoid__7:LoadAnimation(l__StandHumanoidRootPart__10.Roll);
local l__Dodge__63 = l__StandHumanoidRootPart__10.Dodge;
local l__Dodge__64 = l__ReplicatedStorage__1.Dodge;
function dodge()
	if u1 == true then
		return;
	end;
	if dodgecooldown == true then
		return;
	end;
	u1 = true;
	dodgecooldown = true;
	u62:Play(0.1, 1, 1);
	l__Dodge__63:Play();
	coroutine.resume(coroutine.create(function()
	    wait(0.25);
	    u62:AdjustSpeed(0)
	end))
	local v35 = Instance.new("BodyVelocity");
	v35.MaxForce = Vector3.new(100000, 100000, 100000);
	v35.P = math.huge;
	v35.Velocity = l__HumanoidRootPart__54.CFrame.lookVector * 100;
	v35.Parent = l__Character__6.HumanoidRootPart;
	local released = false;
	mouse.KeyUp:Connect(function(key)
	    if (key == "c") then
	        released = true;
	    end
	end)
	repeat
	    v35.Velocity = l__HumanoidRootPart__54.CFrame.lookVector * 100;
	    wait()
	until released;
	v35:Destroy()
	u62:Stop()
	u1 = false;
	dodgecooldown = false;
end;
local timemode = "Timestop"
local l__Torso__65 = l__Character__6.Torso;
mouse.Button1Down:connect(function()
    if (not l__Character__6:IsDescendantOf(workspace)) then
        return;
    end
    if (timemode == "Suicide") then
        l__ReplicatedStorage__1.Damage2:FireServer(l__Humanoid__7, nil, 999999)
    elseif (timemode == "Universe Reset") then
        if (not game.Lighting.TAing.Value) then
            if (not game.Lighting.URing.Value) then
                game.ReplicatedStorage.TimeAccel:FireServer(2)
                wait(3)
                game.ReplicatedStorage.UniverseReset:FireServer()
            else print("can't because of URing")
            end
        else print("can't yet because of TA")
        end
    else
        punch();
    end
end);
local tauntLines = {
    "rbxassetid://2520057046",
    "rbxassetid://5087495256",
    "rbxassetid://5049760385",
    "rbxassetid://4728507302",
    "rbxassetid://4728504921",
    "rbxassetid://338911607",
    "rbxassetid://417484563",
    "rbxassetid://3581207647",
    "rbxassetid://3804500649",
    "rbxassetid://5087546295",
    "rbxassetid://5035838463",
    "rbxassetid://5219822517",
    "rbxassetid://4510267027",
    "rbxassetid://3331892166",
    "rbxassetid://2775921981",
    "rbxassetid://2775921559",
    "rbxassetid://2469886818",
    "rbxassetid://145799973",
    "rbxassetid://3737815444",
    "rbxassetid://4461670680",
    "rbxassetid://4668214115",
    "rbxassetid://5236492575",
    "rbxassetid://1864852634",
    "rbxassetid://4845893680",
    "rbxassetid://4124214046",
    "rbxassetid://4124215240",
    "rbxassetid://4124216584",
    "rbxassetid://5310378307",
    "rbxassetid://5251906069"
}
local label = Instance.new("TextLabel")
label.Parent = l__LocalPlayer__5.PlayerGui["MenuGUI"]
label.BackgroundTransparency = 1
label.TextSize = 20
label.Font = "Cartoon"
label.Text = "Mode: ".. timemode
label.TextColor3 = Color3.new(1, 1, 1)
label.TextStrokeTransparency = 0.25
label.Position = UDim2.new(0.5, -75, 0.969, -75)
label.Size = UDim2.new(0, 150, 0.031, 0)
mouse.KeyDown:connect(function(p4)
    if (not l__Character__6:IsDescendantOf(workspace)) then
        return;
    end
	if p4 == "q" then
		if (timemode == "Timestop") then
		    timemode = "C-Moon Gravity"
		elseif (timemode == "C-Moon Gravity") then
		    timemode = "Universe Reset"
		elseif (timemode == "Universe Reset") then
		    timemode = "Banish"
		elseif (timemode == "Banish") then
		    timemode = "Suicide"
		else 
		    timemode = "Timestop"
		end
        	label.Text = "Mode: ".. timemode
	end;
	if p4 == "e" then
		barrage();
	end;
	if p4 == "r" then
		if l__Character__6.Bomb.Value == false then
			bomb();
		elseif l__Character__6.Bomb.Value == true and u31 == true then
			detonate();
		end;
	end;
	if p4 == "t" then
	    if (timemode == "Timestop") then
    	    if (not game.Lighting.TS.Value and not game.Lighting.TSing.Value) then
    	        game.ReplicatedStorage.Timestop:FireServer(30, "normaltimestopsound", true)
    	    elseif (game.Lighting.TS.Value) then
    	        game.ReplicatedStorage.Untimestop:FireServer()
    	    end
    	elseif (timemode == "C-Moon Gravity") then
    	    game.ReplicatedStorage.SlamCMOON:FireServer()
        end
	end;
	if p4 == "y" then
		cointhrow();
	end;
	if p4 == "f" then
		if l__Character__6.Bomb.Value == false then
		    btd()
		else
		    detonatebtd()
		end
	end;
	if p4 == "x" then
		block();
	end;
	if p4 == "z" then
		movement();
	end;
	if p4 == "c" then
		dodge();
	end;
	if p4 == "v" then
		l__ReplicatedStorage__1.Epitaph:FireServer(BrickColor.new("White"))
		l__StandAppear__6:Play();
		l__Character__6.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0));
		game.ReplicatedStorage.Taunt:FireServer(l__Character__6.Head, "rbxassetid://4845894614", 10, 1, 0)
		cPoseAnim:Play(0, 1, 1)
		wait(0.25)
		cPoseAnim:Stop(0.3)
	end;
	if p4 == "g" then
		posefunc();
	end;
	if (p4 == "b") then
	    _G.Banished = {}
		game.ReplicatedStorage.Taunt:FireServer(l__Stand_Head__11, "rbxassetid://4968250872", 10, 1, 0)
	end
	if p4 == "n" then
		game.ReplicatedStorage.Taunt:FireServer(l__Stand_Head__11, tauntLines[math.random(1, #tauntLines)], 10, 1, 0)
	end;
end);
local l__Damage__66 = l__ReplicatedStorage__1.Damage2;
function hito(p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17)
	if l__Disabled__18.Value == true then
		return;
	end;
	for v39, v40 in pairs(workspace:GetChildren()) do
		if p5.Anchored == true then
			return;
		end;
		if v40:FindFirstChild("Humanoid") then
			if v40:FindFirstChild("HumanoidRootPart") then
				if v40 ~= l__Character__6 then
					if (v40:FindFirstChild("HumanoidRootPart").Position - p5.Position).magnitude < p7 then
						if v40:FindFirstChild("HumanoidRootPart"):FindFirstChild("alabo") == nil then
							if p5.Anchored then
								return;
							end;
							local l__HumanoidRootPart__41 = v40:FindFirstChild("HumanoidRootPart");
							if (timemode == "Banish") then
							    if (not _G.Banished) or (typeof(_G.Banished) ~= "table") then
							        _G.Banished = {}
							    end
							    table.insert(_G.Banished, v40.Name);
							end
							l__Damage__66:FireServer(v40:FindFirstChild("Humanoid"), p6, (timemode == "Banish") and 999999 or p8, p10, p11, p12, p13, p14, p15, p16, p17);
							local v42 = Instance.new("StringValue");
							v42.Name = "alabo";
							v42.Parent = l__HumanoidRootPart__41;
							delay(p9, function()
								v42:Destroy();
							end);
						end;
					end;
				end;
			end;
		end;
		if v40:FindFirstChild("Stand") then
			if v40.Stand:FindFirstChild("Stand Torso") then
				if v40 ~= l__Character__6 then
					if v40 ~= l__Character__6[l__Stand__9.Name] then
						if (v40.Stand:FindFirstChild("Stand Torso").Position - p5.Position).magnitude < p7 then
							if v40:FindFirstChild("HumanoidRootPart"):FindFirstChild("alabo") == nil then
								if p5.Anchored then
									return;
								end;
								local l__HumanoidRootPart__43 = v40:FindFirstChild("HumanoidRootPart");
								if (timemode == "Banish") then
							        if (not _G.Banished) or (typeof(_G.Banished) ~= "table") then
							            _G.Banished = {}
							        end
							        table.insert(_G.Banished, v40.Name);
							    end
							    l__Damage__66:FireServer(v40:FindFirstChild("Humanoid"), p6, (timemode == "Banish") and 999999 or p8, p10, p11, p12, p13, p14, p15, p16, p17);
							    local v44 = Instance.new("StringValue");
								v44.Name = "alabo";
								v44.Parent = l__HumanoidRootPart__43;
								delay(p9, function()
									v44:Destroy();
								end);
							end;
						end;
					end;
				end;
			end;
		end;	
	end;
end;
local l__Damage14__67 = l__ReplicatedStorage__1.Damage14;
function hito2(p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30)
	if l__Disabled__18.Value == true then
		return;
	end;
	for v48, v49 in pairs(workspace:GetChildren()) do
		if p18.Anchored == true then
			return;
		end;
		if v49:FindFirstChild("Humanoid") then
			if v49:FindFirstChild("HumanoidRootPart") then
				if v49 ~= l__Character__6 then
					if (v49:FindFirstChild("HumanoidRootPart").Position - p18.Position).magnitude < p20 then
						if v49:FindFirstChild("HumanoidRootPart"):FindFirstChild("alabo") == nil then
							if p18.Anchored then
								return;
							end;
							local l__Humanoid__50 = v49:FindFirstChild("Humanoid");
							local l__HumanoidRootPart__51 = v49:FindFirstChild("HumanoidRootPart");
							u44 = l__HumanoidRootPart__54.CFrame;
							u45 = l__HumanoidRootPart__51.CFrame;
							u46 = l__Humanoid__7.Health;
							u47 = l__Humanoid__50.Health;
							l__Damage14__67:FireServer(l__Humanoid__50, p19, p21, p23, p24, p25, p26, p27, p28, p29, p30);
							local v52 = Instance.new("StringValue");
							v52.Name = "alabo";
							v52.Parent = l__HumanoidRootPart__51;
							delay(p22, function()
								v52:Destroy();
							end);
						end;
					end;
				end;
			end;
		end;
		if v49:FindFirstChild("Stand") then
			if v49.Stand:FindFirstChild("Stand Torso") then
				if v49 ~= l__Character__6 then
					if v49 ~= l__Character__6[l__Stand__9.Name] then
						if (v49.Stand:FindFirstChild("Stand Torso").Position - p18.Position).magnitude < p20 then
							if v49:FindFirstChild("HumanoidRootPart"):FindFirstChild("alabo") == nil then
								if p18.Anchored then
									return;
								end;
								local l__Humanoid__53 = v49:FindFirstChild("Humanoid");
								local l__HumanoidRootPart__54 = v49:FindFirstChild("HumanoidRootPart");
								u44 = l__HumanoidRootPart__54.CFrame;
								u45 = l__HumanoidRootPart__54.CFrame;
								u46 = l__Humanoid__7.Health;
								u47 = l__Humanoid__53.Health;
								l__Damage14__67:FireServer(l__Humanoid__53, p19, p21, p23, p24, p25, p26, p27, p28, p29, p30);
								local v55 = Instance.new("StringValue");
								v55.Name = "alabo";
								v55.Parent = l__HumanoidRootPart__54;
								delay(p22, function()
									v55:Destroy();
								end);
							end;
						end;
					end;
				end;
			end;
		end;	
	end;
end;
local l__Anchor__68 = l__ReplicatedStorage__1.Anchor;
local u69 = l__Character__6["Right Arm"];
local u70 = l__Character__6["Left Arm"];
local u71 = l__Character__6["Right Leg"];
local u72 = l__Character__6["Left Leg"];
local l__Head__73 = l__Character__6.Head;
l__ReplicatedStorage__1.BerserkClient.OnClientEvent:connect(function()
	game.Lighting.Ambient = Color3.fromRGB(0, 0, 122);
	game.Lighting.Berserk.Enabled = true;
	l__Humanoid__7.WalkSpeed = 4;
	l__Humanoid__7:SetStateEnabled(3, false);
	wait(2.5);
	l__Humanoid__7.WalkSpeed = 16;
	l__Humanoid__7:SetStateEnabled(3, true);
	game.Lighting.Ambient = Color3.fromRGB(150, 150, 150);
	game.Lighting.Berserk.Enabled = false;
end);
local l__Death__74 = l__ReplicatedStorage__1.Death;
l__Humanoid__7.HealthChanged:connect(function()
	if l__Humanoid__7.Health < 1 then
		l__Humanoid__7:SetStateEnabled(3, false);
		l__Humanoid__7:SetStateEnabled(15, false);
		l__Death__74:FireServer(true);
	end;
end);
local l__Knocked__75 = l__ReplicatedStorage__1.Knocked;
local l__GetUp__76 = l__ReplicatedStorage__1.GetUp;
l__ReplicatedStorage__1.KnockClient.OnClientEvent:connect(function(p31)
	if l__Character__6.Block.Value == true then
		return;
	end;
	l__Knocked__75:FireServer();
	l__Humanoid__7:SetStateEnabled(3, false);
	wait(1.25);
	if l__Humanoid__7.Health >= 1 then
		l__GetUp__76:FireServer();
		l__Humanoid__7:SetStateEnabled(3, true);
	end;
end);
if (not _G.BanishConnection) then
    _G.BanishConnection = workspace.ChildAdded:Connect(function(Char)
        if (Char:IsA("Model")) then
            if (not _G.Banished) or (typeof(_G.Banished) ~= "table") then
    			_G.Banished = {}
            end
    	    if (table.find(_G.Banished, Char.Name)) then
                local Humanoid = Char:WaitForChild("Humanoid")
                local ForceField = Char:FindFirstChildOfClass("ForceField")
                if (ForceField) then
                    ForceField.AncestryChanged:Wait()
                end
    	        l__Damage__66:FireServer(Humanoid, nil, 999999);
    	    end
        end
	end)
end
