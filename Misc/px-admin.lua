--[[
	px-admin
	made by whimsical
--]]
-- Services --
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");

-- Constants --
local Open = false;
local Hidden = false;
local synapsis = syn;

-- Variables --
local Player = Players.LocalPlayer;
local Parent = Player.PlayerGui;

-- Objects --
if (synapsis) then Parent = game:GetService("CoreGui") end
if (Parent:FindFirstChild("px-admin_instance")) then Parent["px-admin_instance"]:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "px-admin_instance"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "mainFrame"
mainFrame.AnchorPoint = Vector2.new(1, 1)
mainFrame.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderMode = Enum.BorderMode.Inset
mainFrame.BorderSizePixel = 3
mainFrame.Position = UDim2.new(1, -10, 1, 3)
mainFrame.Size = UDim2.fromOffset(230, 288)

local topbar = Instance.new("Frame")
topbar.Name = "topbar"
topbar.AnchorPoint = Vector2.new(0, 1)
topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topbar.BorderSizePixel = 0
topbar.Position = UDim2.fromOffset(-3, -3)
topbar.Size = UDim2.new(1, 6, 0, 25)

local title = Instance.new("TextLabel")
title.Name = "title"
title.Font = Enum.Font.Gotham
title.Text = "px-admin"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Position = UDim2.fromScale(0.5, 0.55)
title.Size = UDim2.fromScale(0.8, 0.8)
title.Parent = topbar

topbar.Parent = mainFrame

local container = Instance.new("ScrollingFrame")
container.Name = "container"
container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 0
container.Position = UDim2.fromScale(0, 0.08)
container.Size = UDim2.fromScale(1, 0.92)
container.Parent = mainFrame

local command = Instance.new("TextBox")
command.Name = "command"
command.Font = Enum.Font.Roboto
command.PlaceholderText = "Click here or press [ ; ] to open the menu."
command.Text = ""
command.TextColor3 = Color3.fromRGB(0, 0, 0)
command.TextSize = 13
command.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
command.BorderSizePixel = 0
command.ClipsDescendants = true
command.Size = UDim2.fromScale(1, 0.08)
command.Parent = mainFrame

local uiListLayout = Instance.new("UIListLayout", container)
uiListLayout.Padding = UDim.new(0, 5)

local notifications = Instance.new("Frame")
notifications.Name = "notifications"
notifications.AnchorPoint = Vector2.new(0, 1)
notifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notifications.BackgroundTransparency = 1
notifications.Position = UDim2.fromScale(0, 1)
notifications.Size = UDim2.new(1, -250, 0, 120)

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "uIListLayout"
uIListLayout.Padding = UDim.new(0, 10)
uIListLayout.FillDirection = Enum.FillDirection.Horizontal
uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uIListLayout.Parent = notifications

notifications.Parent = gui
mainFrame.Parent = gui

if (synapsis) then synapsis.protect_gui(gui); end

gui.Parent = Parent;

-- Functions --
--<> Player Stuff <>--
local function GetPlayers(name: string)
	local players = {};
	if (typeof(name) == "string") then
		for _, player in pairs(Players:GetPlayers()) do
			if ((player == Player) and (name == "me")) or 
				((player ~= Player) and (name == "others")) or
				(name == "all") or
				(string.lower(string.sub(player.Name, 1, string.len(name))) == string.lower(name)) or
				(string.lower(string.sub(player.DisplayName, 1, string.len(name))) == string.lower(name)) then

				table.insert(players, player)
			end
		end
	end
	return players;
end

local function GetDisplayName(player: Player): string
	return player.DisplayName .." (@".. player.Name ..")"
end

--<> Data <>--
local Table = {};

function Table.Arrayify(t)
	local n = {};
	for _, v in pairs(t) do
		table.insert(n, v)
	end
	return n;
end

function stringCombineAfterIndex(a, combiner: string)
	local n = "";
	local combiner = (combiner or "");
	for i, v in pairs(a) do
		n = n .. tostring(v) .. combiner;
	end
	return n:sub(1, -1 - (string.len(combiner)))
end

--<> Commands <>--
local cmds = {commands={}};

function cmds.addCommand(name: string, description: string, arguments, commandFunction: any, aliases)
	cmds.commands[name] = {
		description = description,
		arguments = arguments,
		aliases = (aliases or {}),
		Function = commandFunction,
	};
end

function cmds.getCommand(name: string)
	local cmd = cmds.commands[name]
	if (not cmd) then
		for i, info in pairs(cmds.commands) do
			for _, alias in pairs(info.aliases) do
				if (alias == name) then
					cmd = info;
					break;
				end
			end
			if (cmd) then break; end
		end
	end
	return cmd;
end

cmds.addCommand("getinventory", "Gets the items in a player's inventory.", {"<player>"}, function(args)
	for _, player in pairs(GetPlayers(args[1])) do
		local backpack = player:FindFirstChild("Backpack");
		if (backpack) then
			local base = GetDisplayName(player) .."'s Backpack\n";
			local message = "";
			for _, tool in pairs(backpack:GetChildren()) do
				if (tool:IsA("Tool")) then
					message = message .. tool.Name ..", "
				end
			end
			if (player.Character) then
				for _, tool in pairs(player.Character:GetChildren()) do
					if (tool:IsA("Tool")) then
						message = message .. tool.Name ..", "
					end
				end
			end
			if (message ~= "") then
				Notify(base .. string.sub(message, 1, -3))
			else
				Notify(GetDisplayName(player) .."'s backpack is empty.")
			end
		else
			Notify(GetDisplayName(player) .." does not have an backpack.")
		end
	end
end, {"getinv", "viewinv", "viewbackpack"})

cmds.addCommand("suicide", "Kill yourself.", nil, function(args)
	Player.Character:FindFirstChildWhichIsA("Humanoid").Health = 0;
end, {"killme", "selfdie", "sewerslide"})

cmds.addCommand("hidepx", "Hides the px-admin ui.", nil, (function(args) Hidden = true; end), {"hidegui", "hideui"})
cmds.addCommand("showpx", "Shows the px-admin ui.", nil, (function(args) Hidden = false; end), {"showgui", "showui"})

local storedlabels = {};

for name, info in pairs(cmds.commands) do
	local commandLabel = Instance.new("TextLabel")
	commandLabel.Name = "commandLabel"
	commandLabel.Font = Enum.Font.Gotham
	commandLabel.Text = name .."\n("
	local AliasLabelDisplay = "";
	for _, alias in pairs(info.aliases) do
		AliasLabelDisplay = AliasLabelDisplay ..", ".. alias;
	end
	commandLabel.Text = commandLabel.Text .. string.sub(AliasLabelDisplay, 3, -1) ..")\n".. (info.description or "No description provided.")
	commandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	commandLabel.TextSize = 12
	commandLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	commandLabel.BackgroundTransparency = 1
	commandLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
	commandLabel.Size = UDim2.new(1, 0, 0, 36)
	commandLabel.TextWrapped = true
	commandLabel.LayoutOrder = (#storedlabels + 1)
	commandLabel.Parent = container;
	table.insert(storedlabels, commandLabel)
end

--<> Miscellaneous <>--
function Notify(text: string)
	local notification = Instance.new("Frame")
	notification.Name = "notification"
	notification.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
	notification.BackgroundTransparency = 1
	notification.BorderColor3 = Color3.fromRGB(255, 255, 255)
	notification.BorderSizePixel = 5
	notification.Size = UDim2.new(0, 220, 1, 0)

	local container = Instance.new("Frame")
	container.Name = "container"
	container.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
	container.BorderColor3 = Color3.fromRGB(255, 255, 255)
	container.BorderSizePixel = 3
	container.Position = UDim2.fromScale(0, 2)
	container.Size = UDim2.fromScale(1, 1)

	local message = Instance.new("TextLabel")
	message.Name = "message"
	message.Font = Enum.Font.Gotham
	message.Text = text
	message.TextColor3 = Color3.fromRGB(255, 255, 255)
	message.TextSize = 15
	message.TextYAlignment = Enum.TextYAlignment.Top
	message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	message.BackgroundTransparency = 1
	message.Position = UDim2.fromScale(0, 0.2)
	message.Size = UDim2.fromScale(1, 0.8)
	message.TextWrapped = true
	message.Parent = container

	local topbar = Instance.new("Frame")
	topbar.Name = "topbar"
	topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	topbar.BorderSizePixel = 0
	topbar.Position = UDim2.fromOffset(0, -2)
	topbar.Size = UDim2.fromScale(1, 0.15)

	local close = Instance.new("TextButton")
	close.Name = "close"
	close.Font = Enum.Font.Gotham
	close.Text = "X"
	close.TextColor3 = Color3.fromRGB(0, 0, 0)
	close.TextSize = 16
	close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	close.BackgroundTransparency = 1
	close.Position = UDim2.new(0.85, 0, 0, -1)
	close.Size = UDim2.fromScale(0.1, 1)
	close.Parent = topbar

	close.MouseButton1Click:Connect(function()
		notification:Destroy()
	end)

	topbar.Parent = container
	container.Parent = notification
	notification.Parent = notifications

	container:TweenPosition(UDim2.fromScale(0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
end

function ToggleUI(status: boolean, force: boolean)
	if (Open == status) and (not force) then return end
	Open = status;
	TweenService:Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		AnchorPoint = Vector2.new(1, (status and 1 or 0)),
		Position = UDim2.new(1, -10, (Hidden and (status and 1 or 1.1) or 1), (status and 3 or 0)),
	}):Play()
end

coroutine.wrap(function()
	repeat RunService.Heartbeat:Wait(); until game:IsLoaded();
	task.wait(1);
	if (not Open) then
		ToggleUI(false, true);
	end
end)()

function Parse(sent: string)
	local args = string.split(sent, " ");
	local cmd = args[1];	
	table.remove(args, 1);

	local info = cmds.getCommand(cmd);
	if (typeof(info) ~= "table") then return end

	info.Function(args);
end

UserInputService.InputBegan:Connect(function(Input: InputObject, gpe: boolean)
	if (not gui:IsDescendantOf(Parent)) then return end
	if (gpe) then return end
	if (Input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = Input.KeyCode;
		if (KeyCode == Enum.KeyCode.Semicolon) then
			ToggleUI(true);
			command:CaptureFocus();
			task.wait();
			command.Text = "";
		end
	end
end)

command.FocusLost:Connect(function()
	Parse(command.Text);
	command.Text = "";
	ToggleUI(false);
end)
