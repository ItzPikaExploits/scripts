local Replicated = game:GetService("ReplicatedStorage")

local library = loadstring(game:HttpGet("https://pastebin.com/raw/1Sa4Z0eK"))()

_G.bossesToGrind = {"Funny Valentine", "DIO"}

local rs;

local window = library:CreateWindow('A Bizarre Day') do
	local folder = window:AddFolder('Main') do
	    folder:AddToggle({ text = 'Item Grind', flag = 'autoGrab' })
	    folder:AddSlider({ text = '- Time To Wait', flag = 'timeBetweenGrabs', min = 0, max = 10, value = 5 })
	    folder:AddToggle({ text = 'Boss Farm', flag = 'bossFarm' })
    end
	local folder = window:AddFolder('Extra') do
	    folder:AddButton({ text = 'Kill GUI', callback = function()
	        rs:Disconnect()
	        library:Close()
	    end})
    end
end

library:Init()

local lastTP = 0;

rs = game:GetService("RunService").RenderStepped:Connect(function()
    if (library.flags.bossFarm) then
        for _, e in pairs(workspace.Entities:GetChildren()) do
            if (table.find(_G.bossesToGrind, e.Name) and (e.Health > 0)) then
                Replicated.Damage:FireServer(e.Humanoid, CFrame.new(), 0, 0, "", 0, BrickColor.Random().Color, "rbxassetid://5599573239", 1, 0)
            end
        end
    end
    if (os.clock() - lastTP) >= library.flags.timeBetweenGrabs then
        pcall(function()
            lastTP = os.clock();
            local oPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
            if (library.flags.autoGrab) then
                for _, t in pairs(workspace.ItFolder:GetChildren()) do
                    if (t:IsA("Tool") and t:FindFirstChild("Handle")) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = t.Handle.CFrame;
                    end
                    wait(0.5);
                end
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oPos
            lastTP = os.clock();
        end)
    end
end)