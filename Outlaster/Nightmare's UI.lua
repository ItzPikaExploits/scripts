local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local TribeNumber = 0

local window = lib:CreateWindow("Nightmare's UI")

function GetExistingTeam()
    if (workspace:FindFirstChild("1")) then
        return 1;
    elseif (workspace:FindFirstChild("2")) then
        return 2;
    end
end

local FIND_ITEMS = window:AddFolder("Item Searching");
local searchItems = FIND_ITEMS:AddButton({ 
	text = "Search for Advantage",
	callback = function()
	local _, err = pcall(function()
            local item = (function()
                local toreturn = nil;
                for _, c in pairs(workspace:FindFirstChild(tostring(TribeNumber)):GetDescendants()) do
                    if (c.Name == "Part" and c:FindFirstChild("Part")) then
                        toreturn = c.Part;
                    end
                end
                return toreturn
            end)()
            game.Players.LocalPlayer.Character.Humanoid:MoveTo(item.Position)
	end)
			if (err) then warn(err) end
	end,
});
local TEAM_LABEL = FIND_ITEMS:AddLabel({text="MY TRIBE ISLAND IS..."})
local isVoting = FIND_ITEMS:AddButton({ 
	text = "VOTING",
	callback = function()
		TribeNumber = (GetExistingTeam() == 1 and 2 or 1)
		TEAM_LABEL.Text = "MY TRIBE ISLAND IS... ".. TribeNumber
	end,
});
local isSpectatingMerged = FIND_ITEMS:AddButton({ 
	text = "SPECTATING / MERGED",
	callback = function()
		TribeNumber = GetExistingTeam();
		TEAM_LABEL.Text = "MY TRIBE ISLAND IS... ".. TribeNumber
	end,
});

lib:Init()
