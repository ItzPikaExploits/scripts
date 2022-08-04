local RunService = game:GetService("RunService")

local TrackedItems = {};

local Camera = workspace.CurrentCamera;
local SpawnedItems = workspace.Map.Items.SpawnedItems;

local function TrackItem(tool)
    if (TrackedItems[tool]) then return end
    local Label = Drawing.new("Text")
    Label.Text = tool.Name
    Label.Size = 20
    Label.Color = Color3.new(1, 1, 1)
    Label.Center = true
    Label.Outline = true
    Label.OutlineColor = Color3.new(0, 0, 0)
    TrackedItems[tool] = { Label };
    
    tool.AncestryChanged:Connect(function()
        if (not tool:IsDescendantOf(SpawnedItems)) then
            local data = TrackedItems[tool];
            local Label = data[1]
            Label:Remove();
            TrackedItems[tool] = nil;
        end
    end)
end

for _, c in pairs(SpawnedItems:GetChildren()) do
    coroutine.wrap(TrackItem)(c);
end
SpawnedItems.ChildAdded:Connect(TrackItem);

RunService.RenderStepped:Connect(function()
    for t, info in pairs(TrackedItems) do
        local handle = t:FindFirstChildWhichIsA("BasePart") or t:FindFirstChildWhichIsA("Attachment");
        if (not handle) then continue; end
        
        local Label = info[1];
        local Position = handle.Position;
            
        if (handle:IsA("Attachment")) then
            Position = handle.WorldPosition;
        end
        
        local vector, onScreen = Camera:WorldToScreenPoint(Position)
        local screenPoint = Vector2.new(vector.X, vector.Y)
        Label.Position = screenPoint;
        Label.Visible = onScreen;
    end
end)
