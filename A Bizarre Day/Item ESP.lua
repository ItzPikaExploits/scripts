local function CreateESP(Name, Parent)
    local bbg = Instance.new("BillboardGui", Parent);
    bbg.Adornee = Parent;
    bbg.AlwaysOnTop = true
    bbg.Size = UDim2.new(0, 100, 0, 25)
    local tl = Instance.new("TextLabel", bbg)
    tl.BackgroundTransparency = 1;
    tl.TextScaled = true;
    tl.Size = UDim2.new(1, 0, 1, 0)
    tl.Text = Name
    tl.TextColor3 = Color3.new(0, 1, 0)
    tl.Font = "Code"
    tl.TextStrokeTransparency = 0
    return bbg;
end
local Folder = workspace.ItFolder;
local runCheck = function(t)
    if (t:IsA("Tool")) then
        local esp = CreateESP(t.Name, t.Handle)
        local ac = t.AncestryChanged:Connect(function()
            esp:Destroy()
            ac:Disconnect()
        end)
    end
end
while true do
    for _, t in pairs(Folder:GetChildren()) do
        pcall(function()
            runCheck(t)
        end)
    end
    wait(10)
end
