local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer;

local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

local function GetClosestPlayer()
	local Closest = {nil, nil}
	local MousePos = Vector2.new(Mouse.X, Mouse.Y)
	for _, plyr in pairs(Players:GetPlayers()) do
		if plyr == Player then continue end
		local Character = plyr.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local vector, onScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)
				if onScreen then
					local Distance = (MousePos - Vector2.new(vector.X, vector.Y)).Magnitude
					if Closest[1] == nil then Closest = {Distance, plyr} continue end
					if  Distance < Closest[1] then
						Closest = {Distance, plyr}
					end
				end
			end
		end
	end
	return Closest[2]
end

local function CreateDummyValue(Type, Value)
    local nVal = Instance.new(Type .."Value")
    nVal.Value = Value;
    return nVal;
end

local pTarget = nil;
local Target = nil;
local Tweening = false;

local Alpha = 0;

Mouse.KeyDown:Connect(function(Key)
    if (Key == "e") then
        if (not Target) then
            local ClosestPlayer = GetClosestPlayer();
            if (ClosestPlayer) then
                pTarget = ClosestPlayer;
                Target = ClosestPlayer.Character;
                Tweening = true;
                Alpha = 0;
                local TweenVal = CreateDummyValue("Number", 0);
                TweenService:Create(TweenVal, TweenInfo.new(0.25), {
                    Value = 1;
                }):Play()
                coroutine.wrap(function()
                    wait(0.25);
                    TweenVal:Destroy()
                    TweenVal = nil;
                end)()
                while (TweenVal) do
                    Alpha = TweenVal.Value;
                    RunService.RenderStepped:Wait()
                end
                Tweening = false;
            end
        elseif (Target) then
            Target = nil;
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if (pTarget and Target and (Target == pTarget.Character) and Target:FindFirstChild("Head")) then
        if (Tweening) then
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.p, Target.Head.Position), Alpha)
        else
            Camera.CFrame = CFrame.new(Camera.CFrame.p, Target.Head.Position);
        end
    else
        pTarget = nil;
        Target = nil;
    end
end)
