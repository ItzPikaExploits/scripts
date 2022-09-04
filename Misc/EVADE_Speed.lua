if (_G.oldspeed) then _G.oldspeed:Disconnect() end

_G.oldspeed = game:GetService("RunService").Stepped:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if (root ~= nil) then
         local newvel = root.Velocity/50;
         root.CFrame += Vector3.new(newvel.X, 0, newvel.Z)
    end
end)
