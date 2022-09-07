local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer;

if (typeof(_G.evade_data) == "table") then
    for _, c in pairs(_G.evade_data) do
        c:Disconnect()
    end
end
_G.evade_data = {}

table.insert(_G.evade_data, RunService.Stepped:Connect(function()
    local char = Player.Character;
    if (not char) then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if (root ~= nil) then
         local newvel = root.Velocity/45;
         root.CFrame += Vector3.new(newvel.X, 0, newvel.Z)
    end
end))

table.insert(_G.evade_data, RunService.RenderStepped:Connect(function(dt)
    if (UserInputService:IsKeyDown(Enum.KeyCode.V)) and (not UserInputService:GetFocusedTextBox()) then
        local root = Player.Character:FindFirstChild("HumanoidRootPart")
        root.CFrame += root.CFrame.LookVector * 10;
        local sound = Instance.new("Sound");
        sound.SoundId = "rbxassetid://3763437293";
        sound.Volume = 1;
        sound.TimePosition = 0.815;
        sound.Parent = root;
        sound:Play()
        Debris:AddItem(sound, 1);
    end
end))
