local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()
local notiflib = loadstring(game:HttpGet("https://raw.githubusercontent.com/OpenGamerTips/BaconLib/master/lib.lua"))()
local Players = game:GetService("Players");
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer;

local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

local IgnoreTeam = false;
local pTarget, Target = nil, nil;
local Tweening = false;
local Aimlock = false;

local Alpha = 0;

function Notify(Text)
    notiflib:CreateNotification("Nightmare's UI", Text)
end

local window = lib:CreateWindow("Nightmare's UI")

local al_folder = window:AddFolder("Aimlock");
local al_toggle = al_folder:AddToggle({
    text = "Aimlock",
    state = false,
    callback = function()
        Aimlock = lib.flags.Aimlock;
    end,
});
local it_toggle = al_folder:AddToggle({
    text = "Ignore Team",
    state = false,
    callback = function()
        IgnoreTeam = lib.flags["Ignore Team"];
    end,
});

local kill_folder = window:AddFolder("Kill");
local kill_box = kill_folder:AddBox({ text = "Victim", value = "all", flag = "kill_victim" });
local kill_victim = kill_folder:AddButton({ 
    text = "Kill",
    callback = function()
        local plyrs = GetPlayers(lib.flags.kill_victim);
        for _, p in pairs(plyrs) do
            pcall(function()
                Kill(p)
            end)
        end
    end,
});
local loopkill;
local kl_toggle = kill_folder:AddToggle({
    text = "Loop-Kill",
    state = false,
    callback = function()
        if (not lib.flags["Loop-Kill"]) then
            loopkill:Disconnect();
        else
            loopkill = RunService.RenderStepped:Connect(function()
                local plyrs = GetPlayers(lib.flags.kill_victim);
                for _, p in pairs(plyrs) do
                    pcall(function()
                        Kill(p)
                    end)
                end
            end)
        end
    end,
})

function GetPlayers(Name)
    local plyrs = {};
    if (Name == "all") then
        plyrs = Players:GetPlayers();
    elseif (Name == "others") then
        plyrs = Players:GetPlayers();
        local p = table.find(plyrs, Player);
        if (p) then
            table.remove(plyrs, p)
        end
    elseif (Name == "me") then
        table.insert(plyrs, Player);
    else
        for _, p in pairs(Players:GetPlayers()) do
            if (string.lower(p.Name:sub(1, #Name)) == string.lower(Name)) then
                table.insert(plyrs, p)
            end
        end
    end
    return plyrs;
end

function Kill(Victim)
    if (Victim.Team ~= Player.Team) then
        local Char = Victim.Character;
        if (Char and Char:FindFirstChild("Head") and Player.Character and Player.Character:FindFirstChild("EquippedTool")) then
            if (Char:FindFirstChild("Humanoid") and Char.Humanoid.Health > 0) then
                local args = {
                    [1] = Char.Head,
                    [2] = Char.Head.Position,
                    [3] = Player.Character.EquippedTool.Value,
                    [4] = 16000,
                    [5] = Player.Character.Gun,
                    [8] = 2,
                    [9] = false,
                    [10] = true,
                    [11] = Vector3.new(),
                    [12] = 16000,
                    [13] = Vector3.new()
                };
                Replicated.Events.HitPart:FireServer(unpack(args));
            end
        end
    end
end

local function GetClosestPlayer()
	local Closest = {nil, nil}
	local MousePos = Vector2.new(Mouse.X, Mouse.Y)
	for _, plyr in pairs(Players:GetPlayers()) do
		if plyr == Player then continue end
        if (IgnoreTeam and plyr.Team == Player.Team) then continue; end
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

UserInputService.InputBegan:Connect(function(Input)
    if (UserInputService:GetFocusedTextBox()) then return; end
    if (Input.UserInputType == Enum.UserInputType.Keyboard) then
        local KeyCode = Input.KeyCode;
        if (KeyCode == Enum.KeyCode.RightAlt) then
            lib:Close()
        elseif (KeyCode == Enum.KeyCode.E) then
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
    end
end)

lib:Init()

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
