--[[
    whimsical's riot hitbox extender
    @ItzPikaExploits - Github
--]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzPikaExploits/scripts/main/UIUtilEdit.lua"))()

local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")

if shared._unload then
    pcall(shared._unload)
end

function shared._unload()
    if (shared._id) then
        pcall(runService.UnbindFromRenderStep, runService, shared._id)
    end
    
    if library.open then
        library:Close()
    end
    
    library.base:ClearAllChildren()
    library.base:Destroy()
end

shared._id = game:GetService('HttpService'):GenerateGUID(false)
runService:BindToRenderStep(shared._id, 1, function()
    for _, p in pairs(Players:GetPlayers()) do
        if (p == Players.LocalPlayer) then continue end
        if (not p.Character) then continue end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if (not hrp) then continue end
        hrp.Size = library.flags.HitboxExtender and 
            Vector3.new(library.flags.hbSize, library.flags.hbSize, library.flags.hbSize) or
            Vector3.new(2, 2, 1);
        hrp.Transparency = library.flags.hbTransparency/100
        hrp.CanCollide = false;
    end
    
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
                local ping = tonumber(library.flags.ping) or 0
                Value.Text = tostring(tonumber(ms + ping)) .." ms"
            end
        end
    end
end)

local uiToggle = userInputService.InputBegan:Connect(function(Input)
    if (Input.UserInputType == Enum.UserInputType.Keyboard) then
        local KeyCode = Input.KeyCode;
        if (KeyCode == Enum.KeyCode.RightControl) then
            library:Close()
        end
    end
end)


local window = library:CreateWindow('Main') do
	local folder = window:AddFolder('Hitbox Extenders') do
		folder:AddToggle({ text = 'Enabled', flag = 'HitboxExtender' })

		folder:AddSlider({ text = 'Size', flag = 'hbSize', min = 0, max = 100, value = 10 })
		folder:AddSlider({ text = 'Transparency', flag = 'hbTransparency', min = 0, max = 100, value = 90 })
	end
    folder:AddBox({ text = 'Ping Spoof (PStat)', flag = 'ping', value = "0" })
end

local window = library:CreateWindow('Options & Credits') do
	window:AddButton({ text = "Close", callback = function()
	    pcall(shared._unload)
	    uiToggle:Disconnect()
	end})
	window:AddLabel({ text = 'Jan - UI Library' })
	window:AddLabel({ text = 'whimsical - Script' })
end

library:Init()
