local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Replicated = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Camera = workspace.CurrentCamera

local LOCKING = false;

local FOVcircle = Drawing.new("Circle")
FOVcircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
FOVcircle.Color = Color3.new(1, 1, 1)
FOVcircle.Thickness = 0.1
FOVcircle.NumSides = 50
FOVcircle.Radius = 90
FOVcircle.Visible = true
FOVcircle.Filled = false

local MouseConnections = {};
local ActiveConnections = {};

table.insert(MouseConnections, UserInputService.InputBegan:Connect(function(input, gpe)
	if (gpe) then return end
	if (input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = input.KeyCode;
		if (KeyCode == Enum.KeyCode.End) then
			library:Close()
		end
	end
	if (input.UserInputType == Enum.UserInputType.MouseButton2) then
		LOCKING = true
	end
end))

table.insert(MouseConnections, UserInputService.InputEnded:Connect(function(input, gpe)
	if (gpe) then return end
	if (input.UserInputType == Enum.UserInputType.MouseButton2) then
		LOCKING = false
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

	for _, c in pairs(ActiveConnections) do
		if (c.Connected) then
			c:Disconnect()
		end
	end
	
	FOVcircle:Remove()

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

local HUE = 0;

RunService:BindToRenderStep(shared._id, 1, function()
	if (library.flags.aimLock and LOCKING) then
		local closest, closestmag = nil, nil;
		for _, char in pairs(GetCharacters()) do
			local head = char:FindFirstChild("Head")
			if (head) then
				local worldPoint = head.Position;
				local vector, onScreen = Camera:WorldToScreenPoint(worldPoint)
				local screenPoint = Vector2.new(vector.X, vector.Y)

				if (not onScreen) then continue end

				local magn = (screenPoint - Vector2.new(Mouse.X, Mouse.Y)).Magnitude

				if (magn < library.flags.fovSize) then
					if (library.flags.wallCheck) then
						local rayOrigin = Camera.CFrame.Position
						local rayDirection = (head.Position - Camera.CFrame.Position).Magnitude * (head.Position - Camera.CFrame.Position).Unit

						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = {Player.Character, char}
						raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
						raycastParams.IgnoreWater = true
						local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

						if (raycastResult) then continue end
					end

					if (not closest) or (closest and (magn < closestmag)) then
						closest = char;
						closestmag = magn;
					end
				end
			end
		end
		if (closest and Player.Character) then
			local head = closest:FindFirstChild("Head")
			local hrp = closest:FindFirstChild("HumanoidRootPart")

			local RootPart = Player.Character:FindFirstChild("HumanoidRootPart")
			if (head and hrp) then
				local magn = (RootPart.Position - hrp.Position).Magnitude;
				local distanceMultiplier = (magn / 100);
				Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position + ((hrp.Velocity/15) * distanceMultiplier))
			end
		end
	end
	
	if (library.flags.sprintWalk) then
		local Sprinting = Replicated.CharStats[Player.Name].Sprinting;
		if (not ActiveConnections.sprintWalk or not ActiveConnections.sprintWalk.Connected) then
			ActiveConnections.sprintWalk = Sprinting.Changed:Connect(function()
				Sprinting.Value = false
			end)
		end
	else
		if (ActiveConnections.sprintWalk and ActiveConnections.sprintWalk.Connected) then
			ActiveConnections.sprintWalk:Disconnect()
		end
	end

	FOVcircle.Visible = library.flags.fovCircle;
	FOVcircle.Color = (library.flags.fovJeb_ and Color3.fromHSV(HUE/360, 1, 1) or Color3.new(1, 1, 1))
	FOVcircle.Position = Vector2.new(Mouse.X, Mouse.Y + 40)
	if (typeof(library.flags.fovSize) == "number") then
		FOVcircle.Radius = library.flags.fovSize;
	end
	if (typeof(library.flags.fovSides) == "number") then
		FOVcircle.NumSides = library.flags.fovSides;
	end

	HUE += (2/3);
	if (HUE > 360) then HUE = 0; end
end)

local window = library:CreateWindow('Criminality') do
	local folder = window:AddFolder('Aimlock') do
		folder:AddToggle({ text = 'Enabled', flag = 'aimLock' })
		folder:AddToggle({ text = 'Wall Check', flag = 'wallCheck' })

		folder:AddToggle({ text = 'FOV Circle', flag = 'fovCircle' })
		folder:AddSlider({ text = 'FOV Circle Sides', flag = 'fovSides', min = 10, max = 100, value = 50 })
		folder:AddSlider({ text = 'FOV', flag = 'fovSize', min = 10, max = 180, value = 90 })
		folder:AddToggle({ text = 'Rainbow FOV', flag = 'fovJeb_' })
	end
	local folder = window:AddFolder('Misc') do
		folder:AddToggle({ text = 'Sprint Walk', flag = 'sprintWalk' })
		folder:AddToggle({ text = 'Mouse Icon Enabled', flag = 'mouseIconEnabled', callback = function()
			UserInputService.MouseIconEnabled = library.flags.mouseIconEnabled;
		end})
	end
end

local window = library:CreateWindow('Options & Credits') do
	window:AddButton({ text = "Close", callback = function()
		pcall(shared._unload)
	end})
	window:AddLabel({ text = 'Whimsical - Scripting' })
	window:AddLabel({ text = 'Jan - UI Library' })
end

library:Init()
