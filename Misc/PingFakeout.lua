if (_G.runningFPD) then return end

local RunService = game:GetService("RunService")

_G.runningFPD = RunService.Heartbeat:Connect(function()
    if (not game.CoreGui.RobloxGui:FindFirstChild("PerformanceStats")) then return end
    for _, btn in pairs(game.CoreGui.RobloxGui.PerformanceStats:GetChildren()) do
        if (btn.Name ~= "PS_Button") then continue end
        local Panel = btn.StatsMiniTextPanelClass
        if (Panel.TitleLabel.Text == "Ping") then
            local Value = Panel:FindFirstChild("ValueLabeln");
            if (not Value) then
                Value = Panel.ValueLabel:Clone()
                Value.Name = "ValueLabeln"
                Value.Parent = Panel;
            end
            Value.Visible = true
            Panel.ValueLabel.Visible = false;
            local ms = string.sub(Panel.ValueLabel.Text, 1, -4)
            if (tonumber(ms)) then
                Value.Text = tostring(tonumber(ms + _G.FakePing)) .." ms"
            end
        end
    end
end)
