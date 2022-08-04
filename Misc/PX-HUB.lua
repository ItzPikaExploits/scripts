--[[
	PX-HUB
	made by whimsical
--]]
-- Services --
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");

-- Constants --
local selected = "";
local synapsis = syn;
local scripts = {
	["Aimbot (CS Prison Life)"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/PLRemastered_Aimbot.lua",
		[2] = "An aimbot script designed for CS Prison Life.",
	},
	["Aimbot (Counter Blox: Remastered)"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Counter%20Blox/aimbot.lua",
		[2] = "An aimbot script designed for Counter Blox: Remastered",
	},
	["Funky Friday"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Funky%20Friday/main.lua",
		[2] = "A script that prioritizes functions, like autoplayer, for Funky Friday.",
	},
	["Rush Point"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/RushPoint.lua",
		[2] = "A script that prioritizes functions, like aimbot and skeleton ESP, for Rush Point.",
	},
	["Unnamed ESP"] = {
		[1] = "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua",
		[2] = "A popular, and powerful, GUI that prioritizes ESP.\n\nic3w0lf22",
	},
	["Criminality"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/Criminality.lua",
		[2] = "A script that contains strong aimbot functionality, with movement prediction for Criminality.",
	},
	["Elemental Awakening"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/ElementalAwakening.lua",
		[2] = "A script that contains great functions, such as autofarm and auto element rolling in Elemental Awakening.",
	},
	["px-commandline"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/px-commandline.lua",
		[2] = "A admin/command line that was created completely out of boredom and need for certain functionality.",
	},
	["Ability Wars"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/AbilityWars.lua",
		[2] = "A script that contains functions like attack aura and quicker movement for Ability Wars.",
	},
	["Nightmare's UI (Outlaster)"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Outlaster/Nightmare's%20UI.lua",
		[2] = "A script that contains helpful functions like searching for advantage hints in Outlaster.",
	},
	["Item ESP (Roblox Is Unbreakable"] = {
		[1] = "https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/Misc/RIU_ItemESP.lua",
		[2] = "An script that contains ESP for items in Roblox is Unbreakable.",
	},
};

-- Variables --
local Player = Players.LocalPlayer;
local Parent = Player.PlayerGui;

-- Objects --
if (synapsis) then Parent = game:GetService("CoreGui") end
if (Parent:FindFirstChild("px-hub_instance")) then Parent["px-hub_instance"]:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "px-hub_instance"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "mainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 3
mainFrame.Position = UDim2.fromScale(0.5, 0.5)
mainFrame.Size = UDim2.fromOffset(450, 350)

local topbar = Instance.new("Frame")
topbar.Name = "topbar"
topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topbar.BorderSizePixel = 0
topbar.Size = UDim2.fromScale(1, 0.1)

local title = Instance.new("TextLabel")
title.Name = "title"
title.Font = Enum.Font.GothamBold
title.Text = "PX-HUB"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextScaled = true
title.TextSize = 14
title.TextWrapped = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Position = UDim2.fromScale(0.1, 0.05)
title.Size = UDim2.fromScale(0.4, 0.8)
title.Parent = topbar

local logo = Instance.new("ImageLabel")
logo.Name = "logo"
logo.Image = "rbxassetid://447358027"
logo.ScaleType = Enum.ScaleType.Fit
logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo.BackgroundTransparency = 1
logo.Position = UDim2.fromScale(0.015, 0)
logo.Size = UDim2.fromScale(0.07, 0.9)
logo.Parent = topbar

local close = Instance.new("TextButton")
close.Name = "close"
close.Font = Enum.Font.SourceSans
close.Text = ""
close.TextColor3 = Color3.fromRGB(0, 0, 0)
close.TextSize = 40
close.TextWrapped = true
close.AnchorPoint = Vector2.new(1, 0)
close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 1
close.Position = UDim2.fromScale(1, 0)
close.Size = UDim2.fromScale(0.11, 1)
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local closeLabel = Instance.new("TextLabel")
closeLabel.Name = "closeLabel"
closeLabel.Font = Enum.Font.GothamBlack
closeLabel.Text = "x"
closeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
closeLabel.TextScaled = true
closeLabel.TextSize = 14
closeLabel.TextWrapped = true
closeLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closeLabel.BackgroundTransparency = 1
closeLabel.Position = UDim2.fromScale(0, -0.1)
closeLabel.Size = UDim2.fromScale(1, 1)
closeLabel.Parent = close

close.Parent = topbar

topbar.Parent = mainFrame

local container = Instance.new("Frame")
container.Name = "container"
container.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
container.BorderColor3 = Color3.fromRGB(27, 42, 53)
container.BorderSizePixel = 0
container.Position = UDim2.fromScale(0, 0.1)
container.Size = UDim2.fromScale(1, 0.9)

local list = Instance.new("ScrollingFrame")
list.Name = "list"
list.BottomImage = "rbxassetid://226025278"
list.MidImage = "rbxassetid://226025278"
list.TopImage = "rbxassetid://226025278"
list.Active = true
list.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
list.BorderColor3 = Color3.fromRGB(255, 255, 255)
list.BorderMode = Enum.BorderMode.Inset
list.Size = UDim2.fromScale(0.7, 1)

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "uIListLayout"
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = list
uIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	list.CanvasSize = UDim2.new(0, 0, 0, uIListLayout.AbsoluteContentSize.Y)
end)

list.Parent = container

local information = Instance.new("Frame")
information.Name = "information"
information.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
information.BorderColor3 = Color3.fromRGB(27, 42, 53)
information.BorderSizePixel = 0
information.Position = UDim2.fromScale(0.7, 0)
information.Size = UDim2.fromScale(0.3, 1)

local infoName = Instance.new("TextLabel")
infoName.Name = "infoName"
infoName.Font = Enum.Font.Gotham
infoName.Text = "..."
infoName.TextColor3 = Color3.fromRGB(255, 255, 255)
infoName.TextSize = 20
infoName.TextWrapped = true
infoName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
infoName.BackgroundTransparency = 1
infoName.Position = UDim2.fromScale(0.05, 0.1)
infoName.Size = UDim2.fromScale(0.9, 0.2)
infoName.Parent = information

local infoDescription = Instance.new("TextLabel")
infoDescription.Name = "infoDescription"
infoDescription.Font = Enum.Font.Gotham
infoDescription.Text = "?"
infoDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
infoDescription.TextSize = 15
infoDescription.TextWrapped = true
infoDescription.TextYAlignment = Enum.TextYAlignment.Top
infoDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
infoDescription.BackgroundTransparency = 1
infoDescription.Position = UDim2.fromScale(0.05, 0.3)
infoDescription.Size = UDim2.fromScale(0.9, 0.5)
infoDescription.Parent = information

local use = Instance.new("TextButton")
use.Name = "use"
use.Font = Enum.Font.GothamBold
use.Text = "Execute"
use.TextColor3 = Color3.fromRGB(0, 0, 0)
use.TextSize = 20
use.AnchorPoint = Vector2.new(0.5, 0)
use.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
use.BorderSizePixel = 0
use.Position = UDim2.fromScale(0.5, 0.8)
use.Size = UDim2.fromScale(0.9, 0.15)

local uICorner = Instance.new("UICorner")
uICorner.Name = "uICorner"
uICorner.CornerRadius = UDim.new(0.5, 0)
uICorner.Parent = use

use.Parent = information

information.Parent = container
container.Parent = mainFrame
mainFrame.Parent = gui

if (synapsis) then synapsis.protect_gui(gui); end

gui.Parent = Parent;

-- Functions --
--<> GUI Drag <>--
local object = mainFrame;
local dragInput = nil;
local dragStart = nil;
local startPos = nil;
local preparingToDrag = false;
local Dragging = false;

local function update(input)
	local delta = input.Position - dragStart;
	local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
	object.Position = newPosition;
	return newPosition;
end

object.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1) then
		preparingToDrag = true;
		local connection; connection = input.Changed:Connect(function()
			if (input.UserInputState == Enum.UserInputState.End) and (Dragging or preparingToDrag) then
				Dragging = false;
				connection:Disconnect();
				preparingToDrag = false;
			end
		end)
	end
end)

object.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement) then
		dragInput = input;
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if (preparingToDrag) then
		preparingToDrag = false;
		Dragging = true;
		dragStart = input.Position;
		startPos = object.Position;
	end
	if (input == dragInput) and (Dragging) then
		update(input);
	end
end)

--<> Miscellaneous <>--
for name, info in pairs(scripts) do
	local template = Instance.new("TextButton");
	template.Name = name;
	template.Font = Enum.Font.Roboto;
	template.Text = name;
	template.TextColor3 = Color3.fromRGB(255, 255, 255);
	template.TextSize = 20;
	template.BackgroundColor3 = Color3.fromRGB(19, 30, 38);
	template.BorderColor3 = Color3.fromRGB(255, 255, 255);
	template.Size = UDim2.new(1, 0, 0, 30);
	template.Parent = list;
	template.MouseButton1Click:Connect(function()
		selected = name;
		infoName.Text = name;
		infoDescription.Text = (info[2] or "No description provided.");
	end)
end

use.MouseButton1Click:Connect(function()
	local info = scripts[selected];
	if (info) then
		loadstring(game:HttpGet(info[1], true))();
	end
end)
