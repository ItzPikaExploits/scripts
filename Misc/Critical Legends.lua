-- LOAD GUI & LIBRARY (Wally Lib) --
local library = loadstring(game:HttpGet("https://pastebin.com/raw/CkyR8ePz", true))()

-- GUI Window
local farm = library:CreateWindow('Critical Legends')
farm:Section('Created by HamstaGang')

-- Player Locals
local Plr = game:GetService("Players").LocalPlayer
local Curr_Weapon = nil;

-- Zones Array
local Zones_Arr = {};
local Selected_Zone = "Primis Field 1"

function Setup_Zones()
    -- Zones
    local Zones = game:GetService("Workspace").Enemies

    -- Add all zones to array
    for i, Zone in pairs(Zones:GetChildren()) do
        table.insert(Zones_Arr, Zone.Name);
    end
end

-- God Mode
local gOdMoDe
gOdMoDe = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() and self.Name == "Damage" and args[3] ~= nil and method == "FireServer" then
        return;
    end

    return gOdMoDe(self, ...)
end)

-- // Add GUI buttons/toggles/dropdowns \\

-- Capture and setup Zones dropdown
Setup_Zones();
local FarmZones = farm:Dropdown('Farm Zones', {flag = "FarmZones"; list = Zones_Arr;}, function(v)
    Selected_Zone = v;
end)

-- Toggle Auto Farm
local AutoFarm = farm:Toggle('Auto Farm', {flag = "AutoFarm"})

-- Auto Farm
spawn(function()
    while wait() do
        if farm.flags.AutoFarm then
            print("-- Farming --")
            if Selected_Zone ~= "" then
                print("-- Farming: ".. Selected_Zone .."  --")
                local xZone = game:GetService("Workspace").Enemies[Selected_Zone];

                for x, Enemy in pairs(xZone:GetChildren()) do
                    if Enemy.Name ~= "Tier" and farm.flags.AutoFarm then
                        -- Teleport to Enemy (Game has section loading so we need to teleport first)
                        Plr.Character.HumanoidRootPart.CFrame = Enemy.EnemyLocation.CFrame;
                        wait(0.2)

                        local Curr_Enemy = Enemy:FindFirstChild(tostring(Enemy.Model.Value), true)

                        if Curr_Enemy then
                            print("-- Farming: Fighting ".. tostring(Enemy.Model.Value)  .."  --")

                            -- Start Combat
                            Enemy.CombatTrigger:FireServer("Solo")
                            wait(0.3)

                            -- Auto Attack
                            repeat
                                local Curr_Enemy = Enemy:FindFirstChild(tostring(Enemy.Model.Value), true)
                                game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(Curr_Enemy, Curr_Weapon)
                                wait(0.5);
                            until Curr_Enemy == nil
                        end
                    end
                end
            end
        end
    end
end)

farm:Section('Chests')

local chest = farm:Button('Grab Chests', function()
    local chests = game.Workspace.Chests:GetChildren()
    for i,v in pairs(chests) do
        if not v:FindFirstChild("Open") then
            plr.Character.HumanoidRootPart.CFrame = v.Giver.CFrame
        end
        wait(0.5)
    end
end)


farm:Section('Stat Leveling')

-- Plr Stats
local Stats_Folder = Plr.PlayerData.Stats

-- Curr Stat
local Stat = "Damage";

-- Stat List
local StatList = farm:Dropdown('Stat', {flag = "PlrStats"; list = {"Damage"; "Shield"; "Health"; "Mana"; "Magic";};}, function(v)
    Stat = v;
end)

local AutoStat = farm:Toggle('Auto Level Stat', {flag = "AutoStat"})

-- Auto Stat Level Function
spawn(function()
    while wait(1) do
        if farm.flags.AutoStat then
            game:GetService("ReplicatedStorage").Remotes.StatsChange:FireServer(Stat)
        end
    end
end)


-- Auto update current weapon. Combatfolder spawns upon battle.
game.Workspace.ChildAdded:Connect(function(child)
    if child.ClassName == "Folder" and child.Name == "CombatFolder" then
        for x,v in pairs(child:GetChildren()) do
            if v.ClassName == "Folder" then
                v.ChildAdded:Connect(function(weapon)
                    Curr_Weapon = weapon;
                end)
            end
        end
    end;
end);
