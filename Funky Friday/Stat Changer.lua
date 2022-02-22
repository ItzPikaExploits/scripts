local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local Stats = {
    "HighScore",
    "TopAccuracy",
    "TotalPlays",
    "AvgScore",
    "AvgAccuracy",
};

local Players = game:GetService("Players")

local Player = Players.LocalPlayer;

local window = library:CreateWindow('FF - Fake Stat Changer') do
	local folder = window:AddFolder('Main') do
		local valueinput = folder:AddBox({ text = 'Value', flag = 'StatValue', value = "69", position = 2, })
	    folder:AddList({ text = 'Stat', flag = 'Stat', value = "TotalPlays", position = 1, values = Stats, callback = function()
	        local GameUI = Player.PlayerGui.GameUI;
	        local StatsList = GameUI.Stats.Frame.Body.Stats.List;
	        valueinput:SetValue(StatsList[library.flags.Stat].Stat.Label.Text)
        end, })
        folder:AddButton({ text = 'Set Value', callback = function()
	        local GameUI = Player.PlayerGui.GameUI;
	        local StatsList = GameUI.Stats.Frame.Body.Stats.List;
	        StatsList[library.flags.Stat].Stat.Label.Text = library.flags.StatValue;
        end, })
	end

	local folder = window:AddFolder('Options & Credits') do
		folder:AddButton({ text = "Close", callback = function()
		    library:Close()
		end})
		folder:AddLabel({ text = 'Nightfalling - Creator' })
		folder:AddLabel({ text = 'Jan - UI Library' })
	end
end

if (table.find(Stats, Stat)) then
    Player.PlayerGui.GameUI.Stats.Frame.Body.Stats.List[Stat].Stat.Label.Text = Value;
end

library:Init()
