if (table.find({180638080}, game.Players.LocalPlayer.UserId)) then game.Players.LocalPlayer:Kick("chinkster") return end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Camera = workspace.CurrentCamera

local MouseConnections = {};

local Mouse1Down = false;

table.insert(MouseConnections, UserInputService.InputBegan:Connect(function(input, gpe)
	if (gpe) then return end
	if (input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = input.KeyCode;
		if (KeyCode == Enum.KeyCode.End) then
			library:Close()
		end
	elseif (input.UserInputType == Enum.UserInputType.MouseButton1) then
		Mouse1Down = true;
	end
end))

table.insert(MouseConnections, UserInputService.InputEnded:Connect(function(input, gpe)
	if (gpe) then return end
	if (input.UserInputType == Enum.UserInputType.MouseButton1) then
		Mouse1Down = false;
	end
end))

if (shared._unload) then pcall(shared._unload) end
function shared._unload()
	if (shared._id) then
		pcall(RunService.UnbindFromRenderStep, RunService, shared._id)
	end

	for _, c in pairs(MouseConnections) do
		if (c.Connected) then
			c:Disconnect()
		end
	end

	if (library.open) then
		library:Close()
	end

	library.base:ClearAllChildren()
	library.base:Destroy()
end

function GetCharacters()
	local Characters = {}
	for _, c in pairs(Player.Character.Parent:GetChildren()) do
		if (c == Player.Character) then continue end
		if (c:FindFirstChildOfClass("Humanoid") and c:FindFirstChild("Head") and c:FindFirstChild("HumanoidRootPart")) then
			table.insert(Characters, c)
		end
	end
	return Characters;
end

shared._id = HttpService:GenerateGUID(false);

RunService:BindToRenderStep(shared._id, 1, function(dt)
	if (library.flags.killAura) then
		if (not library.flags.auraClick) or (library.flags.auraClick and Mouse1Down) then
        		local Character = Player.Character;
	        	if (Character) then
				local RootPart = Character:FindFirstChild("HumanoidRootPart")
				local HitEvent = Character:FindFirstChild("HitEvent")
				if (RootPart and HitEvent) then
					for _, character in pairs(GetCharacters()) do
						if (not character) then continue end
						local hum = character:FindFirstChildWhichIsA("Humanoid")
						if (not hum) then continue end
						local root = character:FindFirstChild("HumanoidRootPart")
						if (not root) then continue end
						if ((root.Position - RootPart.Position).Magnitude <= (library.flags.kaRange or 5)) then
							HitEvent:FireServer(hum, 0, 0)
						end
					end
				end
			end
		end
	end
	if (library.flags.dashToggle) then
		local RootPart = Player.Character.HumanoidRootPart
		if (UserInputService:IsKeyDown(library.flags.dashBind)) then
			RootPart.Velocity = (RootPart.CFrame.LookVector * library.flags.dashStrength)
		end
	end
end)

local window = library:CreateWindow("Criminality") do
	local folder = window:AddFolder("Combat") do
		folder:AddToggle({ text = "Kill Aura", flag = "killAura" })
		folder:AddToggle({ text = "Only While Clicking", flag = "auraClick" })
		folder:AddSlider({ text = "Range", flag = "kaRange", min = 5, max = 100, value = 8 })
	end
	local folder = window:AddFolder("Events") do
		folder:AddButton({ text = "Spleef Dig Close", callback = function()
			local Character = Player.Character;
			local RootPart = Character:FindFirstChild("HumanoidRootPart")
			local snow = workspace["Spleef Arena"].Snow
			for _, s in pairs(snow:GetChildren()) do
				if (s.Name == "Part" and ((s.Position - RootPart.Position).Magnitude) > library.flags.rsRange) then
					Replicated.SnowEvent:FireServer(s)
				end
			end
		end })
		folder:AddSlider({ text = "Remaining Snow Range", flag = "rsRange", min = 7, max = 50, value = 10 })
	end
	local folder = window:AddFolder("Movement/Evasive") do
		folder:AddToggle({ text = "Dash", flag = "dashToggle" })
		folder:AddBind({ text = "Keybind", key = Enum.KeyCode.LeftControl, flag = "dashBind" })
		folder:AddSlider({ text = "Strength", flag = "dashStrength", min = 40, max = 200, value = 40 })
	end
end

local window = library:CreateWindow("Options & Credits") do
	window:AddButton({ text = "Close", callback = function()
		pcall(shared._unload)
	end})
	window:AddLabel({ text = "Whimsical - Scripting" })
	window:AddLabel({ text = "Jan - UI Library" })
end

library:Init()
