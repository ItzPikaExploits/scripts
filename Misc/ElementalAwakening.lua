local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer;

local GC = getconnections or get_signal_cons

local MouseConnections = {};

table.insert(MouseConnections, UserInputService.InputBegan:Connect(function(input, gpe)
	if (gpe) then return end
	if (input.UserInputType == Enum.UserInputType.Keyboard) then
		local KeyCode = input.KeyCode;
		if (KeyCode == Enum.KeyCode.End) then
			library:Close()
		end
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

local function GetPlayerData()
    return Replicated.Data[tostring(Player.UserId)];
end

function Notify(text, duration)
    StarterGui:SetCore("SendNotification", {
       Title = "egg, but better",
       Text = text,
       Duration = (tonumber(duration) and tonumber(duration) or 2),
    });
end

shared._id = HttpService:GenerateGUID(false);

local Rarities = {
    [1] = "Heavenly",
    [2] = "Legendary",
    [3] = "Exotic",
    [4] = "Rare",
    [5] = "Uncommon",
    [6] = "Common",
};
local Magics = require(Replicated.Modules.MagicRarities).Magics;

function Roll()
    local Element, Rarity = Replicated.Events.Spin:InvokeServer(false);
    local Tier = table.find(Rarities, Rarity);
    
    return Element, Rarity, Tier;
end

function CheckForSpinsGui()
    if (Player.PlayerGui) then
        for _, sg in pairs(Player.PlayerGui:GetChildren()) do
            if (sg:FindFirstChild("SpinsGUI")) then
                return true;
            end
        end
    end
end

local spindb = false;

local autospin = { text = "Enabled", flag = "autoSpin" };
autospin.callback = function()
    if (library.flags.autoSpin) then
        if (not CheckForSpinsGui()) then
            Notify("\"Change Element\" must be open to spin!", 5)
            autospin:SetState(false)
        end
        if (GetPlayerData().Spins.Value <= 0) then
            Notify("No spins left!", 5)
        end
    end
end

local lastmoveuse = 0;

RunService:BindToRenderStep(shared._id, 1, function(dt)
    local PlayerData = GetPlayerData();
    if (library.flags.autoFarm) then
        local Character, PlayerGui, Backpack = Player.Character, Player.PlayerGui, Player.Backpack;
        if (PlayerGui) then
            for _, ScreenGui in pairs(PlayerGui:GetChildren()) do
                if (ScreenGui.Name == "ScreenGui" and ScreenGui:FindFirstChild("Start")) then
                    local Play = ScreenGui.Start:FindFirstChild("PlayButton")
                    if (Play) then
                        for _, c in pairs(GC(Play.MouseButton1Click)) do
                            c.Function()
                        end
                    end
                end
            end
        end
        if ((tick() - lastmoveuse) >= library.flags.afTimeToWait) and (Character) then
            local Humanoid = Character:FindFirstChild("Humanoid")
            if (Humanoid) then
                local Tool = Character:FindFirstChild(library.flags.afMove);
                if (not Tool) then
                    if (Backpack and Backpack:FindFirstChild(library.flags.afMove)) then
                        Tool = Backpack[library.flags.afMove];
                        Humanoid:EquipTool(Tool);
                        task.wait(library.flags.afHoldTime)
                    end
                end
                if (Tool) then
                    Tool:Activate()
                    task.wait(library.flags.afHoldTime)
                    Tool:Deactivate()
                    lastuse = tick()
                end
            end
        end
    end
	if (library.flags.autoSpin) and (PlayerData.Spins.Value > 0) and (not spindb) and (CheckForSpinsGui()) then
        coroutine.resume(coroutine.create(function()
            spindb = true;
            
            local Element, Rarity, Tier = Roll();

            if (Element == library.flags.asElement) or (Tier <= table.find(Rarities, library.flags.asRarityWall)) then
                Notify("Kept ".. Element .." at rarity ".. Rarity, 5);
                autospin:SetState(false);
            else
                Notify("Rolled ".. Element .." at rarity ".. Rarity);
            end
            if (PlayerData.Spins.Value <= 0) then
                autospin:SetState(false);
                Notify("No spins left!", 5)
            end

            spindb = false;
        end))
    end
end)

local PossibleSpinRequests = {};

for i = 1, #Rarities do
    local Rarity = Rarities[i];
    for ie = 1, #Magics[Rarity] do
        table.insert(PossibleSpinRequests, Magics[Rarity][ie])
    end
end

local window = library:CreateWindow("Elemental Awakening") do
	local folder = window:AddFolder("Auto Farm") do
		folder:AddToggle({ text = "Enabled", flag = "autoFarm" })
		folder:AddBox({ text = "Move Name", value = "Water Blast", flag = "afMove" })
		folder:AddSlider({ text = "Time Between Uses", value = 5, min = 0, max = 200, flag = "afTimeToWait" })
		folder:AddSlider({ text = "Hold Time", value = 0, min = 0, max = 10, flag = "afHoldTime" })
	end
	local folder = window:AddFolder("Auto Spin") do
		folder:AddToggle(autospin)
        folder:AddList({ text = "Wanted Element", flag = "asElement", values = PossibleSpinRequests })
        folder:AddList({ text = "Rarity Wall", flag = "asRarityWall", values = Rarities })
	end
end

local window = library:CreateWindow("Options & Credits") do
	window:AddButton({ text = "Anti-Idle", callback = function()
        if GC then
            for i, v in pairs(GC(Player.Idled)) do -- ty infinite yield <3
                if v["Disable"] then
                    v["Disable"](v)
                elseif v["Disconnect"] then
                    v["Disconnect"](v)
                end
            end
        else
            Player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
        Notify("Anti-idle has been enabled.")
	end})
	window:AddButton({ text = "Close", callback = function()
		pcall(shared._unload)
	end})
	window:AddLabel({ text = "Whimsical - Scripting" })
	window:AddLabel({ text = "Jan - UI Library" })
end

library:Init()
