local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()
--local notiflib = loadstring(game:HttpGet("https://raw.githubusercontent.com/OpenGamerTips/BaconLib/master/lib.lua"))()
local Players = game:GetService("Players");
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer;

local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

local IgnoreTeam = false;
local IgnoreTeamESP = false;
local pTarget, Target = nil, nil;
local Tweening = false;
local Aimlock = false;
local skeleton_esp = false;

local Alpha = 0;

function Notify(Text)
	--notiflib:CreateNotification("Nightmare's UI", Text)
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

local esp_folder = window:AddFolder("ESP");
local skele_toggle = esp_folder:AddToggle({
	text = "Skeleton",
	state = false,
	callback = function()
		skeleton_esp = lib.flags.Skeleton;
	end,
})
local itesp_toggle = esp_folder:AddToggle({
	text = "Ignore Team",
	state = false,
	flag = "IgnoreTeamESP",
	callback = function()
		IgnoreTeamESP = lib.flags.IgnoreTeamESP;
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

local function NewLine(v)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = v.TeamColor.Color
    line.Thickness = 2
    line.Transparency = (skeleton_esp and 0 or 1)
    return line
end

function S_ESP(v)
    spawn(function()
        local R15
        repeat wait() until v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil
        R15 = (v.Character.Humanoid.RigType == Enum.HumanoidRigType.R15) and true or false

        local Spine = {}
        local SpineNames = {}
        local connecthead = NewLine(v)

        local LLeg = {}
        local LLegNames = {}
        local connectlegleft = NewLine(v)

        local RLeg = {}
        local RLegNames = {}
        local connectlegright = NewLine(v)

        local LArm = {}
        local LArmNames = {}
        local connectarmleft = NewLine(v)

        local RArm = {}
        local RArmNames = {}
        local connectarmright = NewLine(v)
        
        local plr = v;

        for i,v in pairs(plr.Character:GetChildren()) do
            if v:IsA("BasePart") and v.Transparency ~= 1 then
                if v.Name == "UpperTorso" or v.Name == "Torso" or v.Name == "HumanoidRootPart" or v.Name == "LowerTorso" then
                    table.insert(SpineNames, v.Name)
                    Spine[v.Name] = NewLine(plr)
                end
                if v.Name == "LeftLeg" or v.Name == "LeftUpperLeg" or v.Name == "LeftLowerLeg" or v.Name == "LeftFoot" then
                    table.insert(LLegNames, v.Name)
                    LLeg[v.Name] = NewLine(plr)
                end
                if v.Name == "RightLeg" or v.Name == "RightUpperLeg" or v.Name == "RightLowerLeg" or v.Name == "RightFoot" then
                    table.insert(RLegNames, v.Name)
                    RLeg[v.Name] = NewLine(plr)
                end
                if v.Name == "LeftArm" or v.Name == "LeftUpperArm" or v.Name == "LeftLowerArm" or v.Name == "LeftHand" then
                    table.insert(LArmNames, v.Name)
                    LArm[v.Name] = NewLine(plr)
                end
                if v.Name == "RightArm" or v.Name == "RightUpperArm" or v.Name == "RightLowerArm" or v.Name == "RightHand" then
                    table.insert(RArmNames, v.Name)
                    RArm[v.Name] = NewLine(plr)
                end
            end
        end 

        local function ESP()
            local function ConnectLimbs(limb, root, connector)
                if v.Character:FindFirstChild(root) ~= nil and v.Character:FindFirstChild(limb) ~= nil then
                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(root).Position)
                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(limb).Position)
                    connector.From = Vector2.new(pos1.X, pos1.Y)
                    connector.To = Vector2.new(pos2.X, pos2.Y)
                end
            end
            local function Visibility(state)
                connecthead.Visible = state
                connectarmleft.Visible = state
                connectarmright.Visible = state
                connectlegleft.Visible = state
                connectlegright.Visible = state
                for u, x in pairs(Spine) do
                    x.Visible = state
                end
                for u, x in pairs(LLeg) do
                    x.Visible = state
                end
                for u, x in pairs(RLeg) do
                    x.Visible = state
                end
                for u, x in pairs(LArm) do
                    x.Visible = state
                end
                for u, x in pairs(RArm) do
                    x.Visible = state
                end
            end
            local function Thickness(state)
                connecthead.Thickness = state
                connectarmleft.Thickness = state
                connectarmright.Thickness = state
                connectlegleft.Thickness = state
                connectlegright.Thickness = state
                for u, x in pairs(Spine) do
                    x.Thickness = state
                end
                for u, x in pairs(LLeg) do
                    x.Thickness = state
                end
                for u, x in pairs(RLeg) do
                    x.Thickness = state
                end
                for u, x in pairs(LArm) do
                    x.Thickness = state
                end
                for u, x in pairs(RArm) do
                    x.Thickness = state
                end
            end
            local function Color(color)
                connecthead.Color = color
                connectarmleft.Color = color
                connectarmright.Color = color
                connectlegleft.Color = color
                connectlegright.Color = color
                for u, x in pairs(Spine) do
                    x.Color = color
                end
                for u, x in pairs(LLeg) do
                    x.Color = color
                end
                for u, x in pairs(RLeg) do
                    x.Color = color
                end
                for u, x in pairs(LArm) do
                    x.Color = color
                end
                for u, x in pairs(RArm) do
                    x.Color = color
                end
            end

            local connection
            connection = game:GetService("RunService").RenderStepped:Connect(function()
                if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= Player.Name and v.Character.Humanoid.Health > 0 then
                    local pos, vis = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if (vis and skeleton_esp) and (function()
                        if (IgnoreTeamESP) then
                            if (v.Team ~= Player.Team) then
                                return true;
                            else
                                return false;
                            end
                        else return true;
                        end
                    end)() then 
                        if R15 then
                            local a = 0
                            for u, x in pairs(Spine) do
                                a=a+1
                                if SpineNames[a+1] ~= nil and v.Character:FindFirstChild(SpineNames[a+1]) ~= nil and v.Character:FindFirstChild(SpineNames[a+1]).Position ~= nil then
                                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(SpineNames[a]).Position)
                                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(SpineNames[a+1]).Position)
                                    x.From = Vector2.new(pos1.X, pos1.Y)
                                    x.To = Vector2.new(pos2.X, pos2.Y)
                                end
                            end
                            local b = 0
                            for u, x in pairs(LArm) do
                                b=b+1
                                if LArmNames[b+1] ~= nil and v.Character:FindFirstChild(LArmNames[b+1]) ~= nil and v.Character:FindFirstChild(LArmNames[b+1]).Position ~= nil then
                                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(LArmNames[b]).Position)
                                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(LArmNames[b+1]).Position)
                                    x.From = Vector2.new(pos1.X, pos1.Y)
                                    x.To = Vector2.new(pos2.X, pos2.Y)
                                end
                            end
                            local c = 0
                            for u, x in pairs(RArm) do
                                c=c+1
                                if RArmNames[c+1] ~= nil and v.Character:FindFirstChild(RArmNames[c+1]) ~= nil and v.Character:FindFirstChild(RArmNames[c+1]).Position ~= nil then
                                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(RArmNames[c]).Position)
                                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(RArmNames[c+1]).Position)
                                    x.From = Vector2.new(pos1.X, pos1.Y)
                                    x.To = Vector2.new(pos2.X, pos2.Y)
                                end
                            end
                            local d = 0
                            for u, x in pairs(LLeg) do
                                d=d+1
                                if LLegNames[d+1] ~= nil and v.Character:FindFirstChild(LLegNames[d+1]) ~= nil and v.Character:FindFirstChild(LLegNames[d+1]).Position ~= nil then
                                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(LLegNames[d]).Position)
                                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(LLegNames[d+1]).Position)
                                    x.From = Vector2.new(pos1.X, pos1.Y)
                                    x.To = Vector2.new(pos2.X, pos2.Y)
                                end
                            end
                            local e = 0
                            for u, x in pairs(RLeg) do
                                e=e+1
                                if RLegNames[e+1] ~= nil and v.Character:FindFirstChild(RLegNames[e+1]) ~= nil and v.Character:FindFirstChild(RLegNames[e+1]).Position ~= nil then
                                    local pos1 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(RLegNames[e]).Position)
                                    local pos2 = Camera:WorldToViewportPoint(v.Character:FindFirstChild(RLegNames[e+1]).Position)
                                    x.From = Vector2.new(pos1.X, pos1.Y)
                                    x.To = Vector2.new(pos2.X, pos2.Y)
                                end
                            end
                            
                            ConnectLimbs("LeftUpperArm", "UpperTorso", connectarmleft)
                            ConnectLimbs("RightUpperArm", "UpperTorso", connectarmright)
                            ConnectLimbs("LeftUpperLeg", "LowerTorso", connectlegleft)
                            ConnectLimbs("RightUpperLeg", "LowerTorso", connectlegright)
                            ConnectLimbs("UpperTorso", "Head", connecthead)
                        end

                        local distance = (Player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 3) --0.1 is min thickness, 4 is max
                        Thickness(value)
                        Color(v.TeamColor.Color)

                        Visibility(true)
                    else 
                        Visibility(false)
                    end
                else 
                    Visibility(false)
                    if game.Players:FindFirstChild(v.Name) == nil then
                        connection:Disconnect()
                    end
                end
            end)
        end
        coroutine.wrap(ESP)()
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    S_ESP(p)
end
Players.PlayerAdded:Connect(S_ESP)

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
			if (not Target) and (Aimlock) then
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
	if (Aimlock and pTarget and Target and (Target == pTarget.Character) and Target:FindFirstChild("Head")) then
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
