local Replicated = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local function Notify(p1)
    local NotifcationHandler = Players.LocalPlayer.PlayerGui.Notification["Notification Handler"]
    local l__NotificationTemplate__1 = NotifcationHandler:FindFirstChild("NotificationTemplate");
    local l__Popups__2 = NotifcationHandler.Parent:WaitForChild("Popups");
    local l__TweenService__3 = game:GetService("TweenService");
	spawn(function()
		local v1 = l__NotificationTemplate__1:Clone();
		v1.Text = p1;
		v1.Parent = l__Popups__2;
		local v2 = Instance.new("Sound", v1);
		v2.SoundId = "rbxassetid://4590657391";
		v2:Play();
		v1:TweenSize(UDim2.new(1, 0, 0.05, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.15);
		wait(3);
		l__TweenService__3:Create(v1, TweenInfo.new(1, Enum.EasingStyle.Linear), {
			BackgroundTransparency = 1, 
			TextTransparency = 1
		}):Play();
		wait(1);
		v1:Destroy();
	end);
end;

if (not _G.killsay) or (_G.killsay and not _G.killsay.connected) then
    _G.killsay = Replicated.SendNotification.OnClientEvent:Connect(function(a, b)
        if (a == "New") then
            if (b:sub(1, 7) == "Killed " and Players:FindFirstChild(b:sub(8))) then
                Replicated.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.KillSayList[math.random(1, #_G.KillSayList)], "All")
            end
        end
    end)
    Notify("Kill say initialized.")
else
    _G.killsay:Disconnect()
    Notify("Kill say deinitialized.")
end
