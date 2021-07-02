local Replicated = game:GetService("ReplicatedStorage");
local VirtualUser = game:GetService("VirtualUser");
local Debris = game:GetService("Debris");
local GuiService = game:GetService("GuiService");

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

_G.bossesToGrind = {"Funny Valentine", "DIO"}

local connections = {};

local function Notify(Text, DoSound, sProps)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui);
    local Frame = Instance.new("Frame", ScreenGui)
    local yGuiInset = GuiService:GetGuiInset().y
    Frame.Size = UDim2.new(0.5, 0, 0, yGuiInset);
    Frame.Position = UDim2.new(0.5, 0, 0, -yGuiInset);
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
    Frame:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quad", 1)
    Frame.BorderSizePixel = 0;
    local Corner = Instance.new("UICorner", Frame)
    Corner.CornerRadius = UDim.new(0.25, 0)
    local Label = Instance.new("TextLabel", Frame)
    Label.BackgroundTransparency = 1;
    Label.TextScaled = false;
    Label.Size = UDim2.new(1, 0, 1, 0);
    Label.TextSize = (yGuiInset/4) * 2
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Text = Text;
    Label.Font = Enum.Font.GothamBold;
    Label.TextWrapped = true
    if (DoSound) then
        local Sound = Instance.new("Sound", ScreenGui);
        Sound.SoundId = "rbxassetid://5153734608"
        if (typeof(sProps) == "table") then
            for i, v in pairs(sProps) do
                pcall(function()
                    Sound[i] = v;
                end)
            end
        end
        Sound:Play()
    end
    Debris:AddItem(ScreenGui, 5)
    wait(4);
    Frame:TweenPosition(UDim2.new(0.5, 0, 0, -yGuiInset), "Out", "Quad", 1)
end

local function NameToEntity(Name)
    local e = workspace.Entities:FindFirstChild(Name);
    if (Name == "me") then
        e = game.Players.LocalPlayer.Character;
    end
    return e;
end

local window = library:CreateWindow('A Bizarre Day') do
	local folder = window:AddFolder('Grinding') do
	    folder:AddToggle({ text = 'Item Grind', flag = 'autoGrab', callback=function()
	        Notify((library.flags.autoGrab and "Enabled" or "Disabled") .." Item Grind", library.flags.autoGrab) 
	    end})
	    folder:AddSlider({ text = '- Time To Wait', flag = 'timeBetweeniTPS1', min = 0, max = 10, value = 5 })
	    folder:AddSlider({ text = '- Time Between TPs', flag = 'timeBetweeniTPS2', min = 0.5, max = 1.5, value = 1 })
	    folder:AddToggle({ text = 'Ignore Banknotes', flag = 'ignoreBanks', callback=function()
	        Notify((not library.flags.ignoreBanks and "Acknowledging " or "Ignoring ") .."banknotes!", library.flags.ignoreBanks) 
	    end})
	    folder:AddToggle({ text = 'Boss Farm', flag = 'bossFarm', callback=function()
	        Notify((library.flags.bossFarm and "Enabled" or "Disabled") .." Boss Farm", library.flags.bossFarm) 
	    end})
    end
	local folder = window:AddFolder('Use Items') do
        folder:AddButton({ text = 'Rokakaka Fruit', callback = function()
            if (game.Players.LocalPlayer.Character:FindFirstChild("Rokakaka Fruit")) then
    	        Replicated.Roka:FireServer();
    	        Notify("Used Rokakaka Fruit!", true)
    	    else
    	        Notify("Hold out the item!")
	        end
	    end})
        folder:AddButton({ text = 'Arrow', callback = function()
	        if (game.Players.LocalPlayer.Character:FindFirstChild("Arrow")) then
    	        Replicated.Arrow:FireServer();
    	        Notify("Used Arrow!", true)
    	    else
    	        Notify("Hold out the item!")
    	    end
	    end})
    end
	local folder = window:AddFolder('Target') do
        folder:AddBox({ text = 'Victim', value = "", flag = "targetName" })
        folder:AddButton({ text = 'Kill', callback = function()
            local e = NameToEntity(library.flags.targetName);
            if (not e) then
                Notify("\"".. library.flags.targetName .."\" is not a valid entity!");
            else
                for i = 1, 100 do
                    Replicated.Damage:FireServer(unpack({
                        e.Humanoid,
                        e:GetPrimaryPartCFrame(),
                        80,
                        0,
                        Vector3.new(),
                        "rbxassetid://3909691881",
                        0,
                        Color3.new(1, 1, 1),
                        "rbxassetid://5599573239",
                        1,
                        0
                    }))
                end
            end
	    end})
        folder:AddButton({ text = 'God', callback = function()
            local e = NameToEntity(library.flags.targetName);
            if (not e) then
                Notify("\"".. library.flags.targetName .."\" is not a valid entity!");
            else
                Replicated.SamuraiDamage2:FireServer(unpack({
                    e.Humanoid,
                    -1000000000000,
                    e.HumanoidRootPart,
                }))
            end
	    end})
    end
	local folder = window:AddFolder('Extra') do
	    folder:AddToggle({ text = 'Anti AFK', flag = 'antiAFK', callback=function()
	        Notify((library.flags.antiAFK and "Enabled" or "Disabled") .." Anti-AFK", library.flags.antiAFK) 
	    end})
	    folder:AddToggle({ text = 'Boss Notifier', flag = 'bossNotify', callback=function()
	        Notify("You will ".. (not library.flags.bossNotify and "no longer " or "") .."be notified if a boss spawns!", library.flags.bossNotify) 
	    end})
        folder:AddButton({ text = 'Kill GUI', callback = function()
	        for _, c in pairs(connections) do
	            pcall(function()
	                c:Disconnect()
	            end)
	        end
	        library:Close()
	        Notify("Thanks for using ABDGUI by loafa!", true, {Volume=5})
	    end})
    end
end

library:Init()

local lastTP = 0;

table.insert(connections, game:GetService("RunService").RenderStepped:Connect(function()
    if (library.flags.bossFarm) then
        local _, err = pcall(function()
            for _, e in pairs(workspace.Entities:GetChildren()) do
                if (table.find(_G.bossesToGrind, e.Name) and (e:FindFirstChild("Humanoid")) and (e.Humanoid.Health > 0)) then
					if (not e.Deflect.Value) then
						Replicated.Damage:FireServer(unpack({
							e.Humanoid,
							e:GetPrimaryPartCFrame(),
							80,
							0,
							Vector3.new(),
							"rbxassetid://3909691881",
							0,
							Color3.new(1, 1, 1),
							"rbxassetid://5599573239",
							1,
							0
						}))
					end
                end
            end
        end)
    end
    if (os.clock() - lastTP) >= library.flags.timeBetweeniTPS1 then
        pcall(function()
            lastTP = os.clock();
            local oPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
            if (library.flags.autoGrab) then
                function CheckService(s)
                    for _, t in pairs(s:GetChildren()) do
                        if (t.Name == "Banknote" and library.flags.ignoreBanks) then
                            continue;
                        end
                        if (t:IsA("Tool") and t:FindFirstChild("Handle")) then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = t.Handle.CFrame;
							game.Players.LocalPlayer.Character.Humanoid:MoveTo(t.Handle.Position)
                            wait(library.flags.timeBetweeniTPS2);
                        end
                    end
                end
                CheckService(workspace);
                CheckService(workspace.ItFolder);
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oPos
            lastTP = os.clock();
        end)
    end
end))
table.insert(connections, game.Players.LocalPlayer.Idled:Connect(function()
    if (library.flags.antiAFK) then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end))
table.insert(connections, workspace.Entities.ChildAdded:Connect(function(e)
    if (library.flags.bossNotify and table.find(_G.bossesToGrind, e.Name)) then
        Notify(e.Name .." spawned!", true, {Volume=10})
    end
end))
