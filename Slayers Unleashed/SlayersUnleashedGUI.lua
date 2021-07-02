--[[
    SlayersUnleashedGUI.lua
    @loafa

    This GUI includes:
    - Auto clicker: This allows you to use your computer while grinding logs.
--]]

local VirtualUser = game:GetService("VirtualUser");
local Debris = game:GetService("Debris");
local GuiService = game:GetService("GuiService");

local library = loadstring(game:HttpGet("https://pastebin.com/raw/1Sa4Z0eK"))()

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

local Connections = {}

local window = library:CreateWindow('Slayers Unleashed') do
	local folder = window:AddFolder('Grinding') do
	    folder:AddToggle({ text = 'Auto Clicker', flag = 'autoClicker', callback=function()
	        Notify((library.flags.autoClicker and "Enabled" or "Disabled") .." Auto Clicker", library.flags.autoClicker) 
	    end})
	end
	local folder = window:AddFolder('Extra') do
	    folder:AddButton({ text = 'Close GUI', callback=function()
	        for _, c in pairs(Connections) do
	            pcall(function()
	                c:Disconnect()
	            end)
	        end
	        library:Close()
	        Notify("Thanks for using ABDGUI by loafa!", true, {Volume=5})
	    end})
	end
end

library:Init();

table.insert(Connections, game:GetService("RunService").Heartbeat:Connect(function()
    if (library.flags.autoClicker) then
        VirtualUser:ClickButton1(Vector2.new())
    end
end))
