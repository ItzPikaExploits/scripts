local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()
local notiflib = loadstring(game:HttpGet("https://raw.githubusercontent.com/OpenGamerTips/BaconLib/master/lib.lua"))()

function Notify(Text)
	notiflib:CreateNotification("Nightmare's UI", Text)
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer;

local TribeNumber = 0

local window = lib:CreateWindow("Nightmare's UI")

local function NewRegion3(Position, Size)
    local part = {
        Position = Position,
        Size = Size
    }
    local min = Vector3.new(part.Position.X-part.Size.X/2, part.Position.Y-part.Size.Y/2, part.Position.Z-part.Size.Z/2)
    local max= Vector3.new(part.Position.X+part.Size.X/2, part.Position.Y+part.Size.Y/2, part.Position.Z+part.Size.Z/2)
    return Region3.new(min, max);
end

local function GetTeam()
    local CurrentIsland = nil;
    local _, err = pcall(function()
        local Region = NewRegion3(
                Player.Character.HumanoidRootPart.Position, 
                Vector3.new(100, 100, 100)
            );
        local Parts = workspace:FindPartsInRegion3WithWhiteList(Region, {workspace:FindFirstChild("1"), workspace:FindFirstChild("2"), workspace:FindFirstChild("3")})
        for _, part in pairs(Parts) do
            for i = 1, 3 do
                local i = tostring(i);
                if (workspace:FindFirstChild(i) and part:IsDescendantOf(workspace[i])) then
                    CurrentIsland = workspace[i];
                end
            end
            if (CurrentIsland) then
                break;
            end
        end
    end)
    if (err) then warn(err) end
    return CurrentIsland and tonumber(CurrentIsland.Name);
end

local FIND_ITEMS = window:AddFolder("Item Searching");
local searchItems = FIND_ITEMS:AddButton({ 
	text = "Search for Advantage",
	callback = function()
	local _, err = pcall(function()
            local item = (function()
                local toreturn = nil;
                for _, c in pairs(workspace:FindFirstChild(tostring(TribeNumber)):GetDescendants()) do
                    if (c.Name == "Part" and c:IsA("Model") and c:FindFirstChild("Part")) then
                        toreturn = c.Part;
                    end
                end
                return toreturn
            end)()
            if (item) then
                Player.Character.Humanoid:MoveTo(item.Position)
            else
                Notify("No advantages on your island!")
            end
	end)
			if (err) then warn(err) end
	end,
});
local TEAM_LABEL = FIND_ITEMS:AddLabel({text="MY TRIBE ISLAND IS..."})
local getIsland = FIND_ITEMS:AddButton({ 
	text = "Get Tribal Island",
	callback = function()
		TribeNumber = GetTeam();
		TEAM_LABEL.Text = "MY TRIBE ISLAND IS... ".. tostring(TribeNumber)
	end,
});

lib:Init()
