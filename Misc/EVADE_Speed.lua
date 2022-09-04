if (_G.olddash) then _G.olddash:Disconnect() end

_G.olddash = game:GetService("RunService").Stepped:Connect(function()
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if (root ~= nil) then
         local newvel = root.Velocity/40;
         root.CFrame += Vector3.new(newvel.X, 0, newvel.Z)
    end
end)
