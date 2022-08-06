--[[
    ProjectSlayers_AutoSpinner.lua
    @Whims_icalVal
    
    Instructions:
    If the script is not running, running the script will start the spinning process.
    If the script is running, running the script will stop the spinning process.
    Edit the "keeplist" below to your needs.
--]]

_G.keeplist = _G.keeplist or { 
    "Supreme",
    "Mythic",
    "Legendary",
    -- add/remove stuff that you do/don't want
    --"Rare",
    --"UnCommon",
    --"Common",
};

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local ClanPicker = require(ReplicatedStorage.Modules.Global.Random_Clan_Picker);

local Player = Players.LocalPlayer;
local Remotes = ReplicatedStorage.Remotes;
local Remote = Remotes.To_Server.Handle_Initiate_S_;

if (not _G.spinning) then
    _G.spinning = true;
    while (_G.spinning) do
        local v1, v2 = Remote:InvokeServer("check_can_spin")
        if (v1 == true) then
            local rarity = "";
            for r, clans in pairs(ClanPicker) do
                if (typeof(clans) == "table") then
                    if (table.find(clans, v2)) then
                        rarity = r;
                    end
                end
            end
            local clan = v2 .." (".. rarity ..")";
            StarterGui:SetCore("SendNotification", {
                Title = "instant spinner",
                Text = "Spun for ".. clan,
            });
            Player.PlayerGui.Customization.Spin.Holder.TextLabel.Text = clan;
            if (table.find(_G.keeplist, rarity)) then
                break;
            end
        else
            StarterGui:SetCore("SendNotification", {
                Title = "instant spinner",
                Text = "You are unable to spin.",
            });
            break;
        end
        task.wait(0.25)
    end
elseif (_G.spinning) then
    _G.spinning = false;
end
