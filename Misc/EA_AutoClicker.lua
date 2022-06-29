-- elemental awakening auto clicker
-- made by whimsical

local Players = game:GetService("Players")
local Player = Players.LocalPlayer;

_G.eaAuto = not _G.eaAuto;

function Notify(text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
       Title = "egg, but better",
       Text = text,
       Duration = (tonumber(duration) and tonumber(duration) or 2),
    });
end

if (_G.eaAuto) then
    if (typeof(_G.eaAC_config) ~= "table") then
        Notify("Unable to find configuration.", 5)
    end
    coroutine.wrap(function()
        xpcall(function()
            local lastuse = 0;
            while (_G.eaAuto) do
                local Character, PlayerGui, Backpack = Player.Character, Player.PlayerGui, Player.Backpack;
                if (PlayerGui) then
                    for _, ScreenGui in pairs(PlayerGui:GetChildren()) do
                        if (ScreenGui.Name == "ScreenGui" and ScreenGui:FindFirstChild("Start")) then
                            local Play = ScreenGui.Start:FindFirstChild("PlayButton")
                            if (Play) then
                                for _, c in pairs(getconnections(Play.MouseButton1Click)) do
                                    c.Function()
                                end
                            end
                        end
                    end
                end
                if ((tick() - lastuse) >= _G.eaAC_config.TimeToWait) and (Character) then
                    local Humanoid = Character:FindFirstChild("Humanoid")
                    if (Humanoid) then
                        local Tool = Character:FindFirstChild(_G.eaAC_config.Move);
                        if (not Tool) then
                            if (Backpack and Backpack:FindFirstChild(_G.eaAC_config.Move)) then
                                Tool = Backpack[_G.eaAC_config.Move];
                                Humanoid:EquipTool(Tool);
                                task.wait(_G.eaAC_config.HoldTime)
                            end
                        end
                        if (Tool) then
                            Tool:Activate()
                            task.wait()
                            Tool:Deactivate()
                            lastuse = tick()
                        end
                    end
                end
                task.wait(0.05)
            end
        end, Notify)
    end)()
    Notify("Enabled with ".. _G.eaAC_config.Move .." and a wait time of ".. tostring(_G.eaAC_config.TimeToWait));
else
    Notify("Disabled.")
end
