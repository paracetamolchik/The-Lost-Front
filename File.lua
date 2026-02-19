local t = game:GetService("TweenService")
local info = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local info2 = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local info3 = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In)
local enabled = false
local animating = false

local function create(className, parent, name, ...)
	local new = Instance.new(className)
	new.Parent = parent
	new.Name = name
	for i = 1, select("#", ...) do
		local property = select(i, ...)
		if type(property) == "table" then
			for key, value in pairs(property) do
				new[key] = value
			end
		else
			error("Invalid property type")
		end
	end
	return new
end

local function createframe(text, Type, parent)
	local frame = create("Frame", parent, "TextLabel", 
		{BorderSizePixel = 0},
		{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
		{Size = UDim2.new(1, -10, 0, 30)})
	local UiCorner1 = create("UICorner", frame, "UICorner", {CornerRadius = UDim.new(0,15)})
	if Type == "Toggle" then
		local btn = create("TextButton", frame, "btn",{Text = ""},
			{BorderSizePixel = 0},
			{BackgroundTransparency = 1},
			{Size = UDim2.new(0, 18, 0, 18)},
			{Position = UDim2.new(0, 20, 0, 15)},
			{AnchorPoint = Vector2.new(0.5, 0.5)})
		local UiCorner2 = create("UICorner", btn, "UICorner", {CornerRadius = UDim.new(1,0)})
		local UiStroke = create("UIStroke", btn, "UIStroke", {Color = Color3.new(1, 1, 1)},
			{Thickness = 2},{ApplyStrokeMode = Enum.ApplyStrokeMode.Border},
			{BorderStrokePosition = Enum.BorderStrokePosition.Center})
		local visual = create("Frame", btn, "visual",
			{BorderSizePixel = 0},
			{Size = UDim2.new(0, 12, 0, 12)},
			{Position = UDim2.new(0.5, 0, 0.5, 0)},
			{AnchorPoint = Vector2.new(0.5, 0.5)},
			{Visible = false},
			{BackgroundColor3 = Color3.new(1, 1, 1)}) 
		local UiCorner3 = create("UICorner", visual, "UICorner", {CornerRadius = UDim.new(1,0)})
		local text1 = create("TextLabel", frame, "TextLabel", {Text = text},
			{BorderSizePixel = 0},
			{BackgroundTransparency = 1},
			{Size = UDim2.new(1, 0, 1, 0)}, 
			{Position = UDim2.new(0, 40, 0, 0)},
			{TextColor3 = Color3.new(1, 1, 1)},
			{TextSize = 18},
			{Font = Enum.Font.Cartoon},
			{TextXAlignment = Enum.TextXAlignment.Left})
	elseif Type == "Click" then
		local imgbtn = create("ImageButton", frame, "imgbtn",
			{BorderSizePixel = 0},
			{Size = UDim2.new(0, 26, 0, 26)},
			{Position = UDim2.new(0, 20, 0, 15)},
			{AnchorPoint = Vector2.new(0.5, 0.5)},
			{BackgroundTransparency = 1},
			{Image = "rbxassetid://111829919777105"},
			{Rotation = 45})
		local UiCorner2 = create("UICorner", imgbtn, "UICorner", {CornerRadius = UDim.new(1,0)})
		local text1 = create("TextLabel", frame, "TextLabel", {Text = text},
			{BorderSizePixel = 0},
			{BackgroundTransparency = 1},
			{Size = UDim2.new(1, 0, 1, 0)}, 
			{Position = UDim2.new(0, 40, 0, 0)},
			{TextColor3 = Color3.new(1, 1, 1)},
			{TextSize = 18},
			{Font = Enum.Font.Cartoon},
			{TextXAlignment = Enum.TextXAlignment.Left})
	elseif Type == "group" then
		local btn = create("TextButton", frame, "btn",{Text = ""},
		{BorderSizePixel = 0},
		{BackgroundTransparency = 1},
		{Size = UDim2.new(0, 18, 0, 18)},
		{Position = UDim2.new(0, 20, 0, 15)},
		{AnchorPoint = Vector2.new(0.5, 0.5)})
		local UiCorner2 = create("UICorner", btn, "UICorner", {CornerRadius = UDim.new(1,0)})
		local UiStroke = create("UIStroke", btn, "UIStroke", {Color = Color3.new(1, 1, 1)},
		{Thickness = 2},{ApplyStrokeMode = Enum.ApplyStrokeMode.Border},
		{BorderStrokePosition = Enum.BorderStrokePosition.Center})
		local visual = create("Frame", btn, "visual",
			{BorderSizePixel = 0},
			{Size = UDim2.new(0, 12, 0, 12)},
			{Position = UDim2.new(0.5, 0, 0.5, 0)},
			{AnchorPoint = Vector2.new(0.5, 0.5)},
			{Visible = false},
			{BackgroundColor3 = Color3.new(1, 1, 1)}) 
		local UiCorner3 = create("UICorner", visual, "UICorner", {CornerRadius = UDim.new(1,0)})
		local text1 = create("TextLabel", frame, "TextLabel", {Text = text},
		{BorderSizePixel = 0},
		{BackgroundTransparency = 1},
		{Size = UDim2.new(1, 0, 1, 0)}, 
		{Position = UDim2.new(0, 40, 0, 0)},
		{TextColor3 = Color3.new(1, 1, 1)},
		{TextSize = 18},
		{Font = Enum.Font.Cartoon},
		{TextXAlignment = Enum.TextXAlignment.Left})
		local more = create("ImageButton", frame, "More",
			{Image = "rbxassetid://109749537575072"},
			{BorderSizePixel = 0},
			{BackgroundTransparency = 1},
			{Position = UDim2.new(1, -12, 0, 15)},
			{Size = UDim2.new(0, 20, 0, 20)},
			{AnchorPoint = Vector2.new(1, 0.5)})
	elseif Type == "subgroup" then
		local btn = create("TextButton", frame, "btn",{Text = ""},
		{BorderSizePixel = 0},
		{BackgroundTransparency = 1},
		{Size = UDim2.new(0, 18, 0, 18)},
		{Position = UDim2.new(0, 20, 0, 15)},
		{AnchorPoint = Vector2.new(0.5, 0.5)})
		local UiCorner2 = create("UICorner", btn, "UICorner", {CornerRadius = UDim.new(1,0)})
		local UiStroke = create("UIStroke", btn, "UIStroke", {Color = Color3.new(1, 1, 1)},
		{Thickness = 2},{ApplyStrokeMode = Enum.ApplyStrokeMode.Border},
		{BorderStrokePosition = Enum.BorderStrokePosition.Center})
		local visual = create("Frame", btn, "visual",
			{BorderSizePixel = 0},
			{Size = UDim2.new(0, 12, 0, 12)},
			{Position = UDim2.new(0.5, 0, 0.5, 0)},
			{AnchorPoint = Vector2.new(0.5, 0.5)},
			{Visible = false},
			{BackgroundColor3 = Color3.new(1, 1, 1)}) 
		local UiCorner3 = create("UICorner", visual, "UICorner", {CornerRadius = UDim.new(1,0)})
		local text1 = create("TextLabel", frame, "TextLabel", {Text = text},
		{BorderSizePixel = 0},
		{BackgroundTransparency = 1},
		{Size = UDim2.new(1, 0, 1, 0)}, 
		{Position = UDim2.new(0, 40, 0, 0)},
		{TextColor3 = Color3.new(1, 1, 1)},
		{TextSize = 18},
		{Font = Enum.Font.Cartoon},
		{TextXAlignment = Enum.TextXAlignment.Left})
	end
	return frame
end

local gui = game.Players.LocalPlayer.PlayerGui
local testGui = create("ScreenGui", gui, "test",{ResetOnSpawn = false})

----- Main -----

local Main = create("CanvasGroup", testGui, "Main",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.137255)},
	{Size = UDim2.new(0, 400, 0, 300)}, 
	{Position = UDim2.new(0.5, -200, 0.5, -150)})
local UiCorner1 = create("UICorner", Main, "UICorner", {CornerRadius = UDim.new(0, 8)})

----- Top -----

local Top1 = create("Frame", Main, "Top",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
	{Size = UDim2.new(1, 0, 0, 34)})
local UiCorner2 = create("UICorner", Top1, "UICorner", {CornerRadius = UDim.new(0, 8)})
local img1 = create("ImageLabel", Top1, "ImageLabel",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(0, 24, 0, 24)}, 
	{Position = UDim2.new(0, 18, 0.5, 0)},
	{AnchorPoint = Vector2.new(0.5, 0.5)},
	{Image = "rbxassetid://94570010893830"})
local img2 = create("ImageButton", Top1, "ImageButton",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(0, 14, 0, 14)}, 
	{Position = UDim2.new(1, -10, 0.5, 0)},
	{AnchorPoint = Vector2.new(1, 0.5)},
	{Image = "rbxassetid://96595317895175"})
local Text1 = create("TextLabel", Top1, "TextLabel",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(1, 0, 1, 0)}, 
	{Position = UDim2.new(0, 38, 0, 0)},
	{Text = "The Lost Front"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon},
	{TextXAlignment = Enum.TextXAlignment.Left})
local UiDrag = create("UIDragDetector", Main, "UIDragDetector", {BoundingUI = Top1})
local ChangeSize = create("TextButton", Top1, "TextButton",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(0, 16, 0, 16)}, 
	{Position = UDim2.new(1, -36, 0.5, 0)},
	{AnchorPoint = Vector2.new(1, 0.5)},
	{Text = ""})
local visual = create("Frame", ChangeSize, "visual",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(1, 1, 1)}, 
	{Size = UDim2.new(0, 16, 0, 4)}, 
	{Position = UDim2.new(0, 0, 0.5, 0)},
	{AnchorPoint = Vector2.new(0, 0.5)})
local UiCorner3 = create("UICorner", visual, "UICorner", {CornerRadius = UDim.new(0, 8)})
local info4 = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local opened = false
ChangeSize.MouseButton1Click:Connect(function()
	if opened == false then
		t:Create(Main, info4, {Size = UDim2.new(0, 250, 0, 35)}):Play()
	else
		t:Create(Main, info4, {Size = UDim2.new(0, 400, 0, 300)}):Play()
	end
	opened = not opened
end)

----- Main -----

local Main2 = create("ScrollingFrame", Main, "Main",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(0, 392, 0, 260)}, 
	{Position = UDim2.new(0, 8, 0, 42)}, 
	{CanvasSize = UDim2.new(0, 0, 0, 270)},
	{ScrollBarThickness = 6})
local Uilist = create("UIListLayout", Main2, "UIListLayout", {Padding = UDim.new(0, 8)})
local ESP = createframe("ESP", "Toggle", Main2)
local Aim = createframe("Aim", "group", Main2)
local fov
local HDW = createframe("Highlight Dropped Weapons", "Toggle", Main2)
local RDB = createframe("Remove Dead Bodies", "Toggle", Main2)
local RemoveFog = createframe("Remove Fog", "Toggle", Main2)
local SpeedBoost = createframe("Speed Boost", "Toggle", Main2)

local DeleteTrees = createframe("Delete Trees", "Click", Main2)

local deleted = false
DeleteTrees.imgbtn.MouseButton1Click:Connect(function()
	if not deleted then game.Workspace.ignore.trees:Destroy() deleted = true end
end)
local HWDToggle = false
local hdw = nil
local hdwBtn = nil

while not hdw or not hdw.btn do
	hdw = HDW
	hdwBtn = hdw and hdw.btn
	task.wait()
end
hdwBtn.MouseButton1Click:Connect(function()
	if HWDToggle == false then
		for i, v in pairs(game.Workspace.debris.dropped:GetChildren()) do
			local new = Instance.new("Highlight")
			new.Parent = v
		end
		game.Workspace.debris.dropped.ChildAdded:Connect(function(v)
			if HWDToggle == true then
				local new = Instance.new("Highlight")
				new.Parent = v
			end
		end)
		HWDToggle = true
		hdwBtn.visual.Visible = HWDToggle
	else
		for i, v in pairs(game.Workspace.debris.dropped:GetChildren()) do
			if v:FindFirstChild("Highlight") then
				v.Highlight:Destroy()
			end
		end
		HWDToggle = false
		hdwBtn.visual.Visible = HWDToggle
	end
end)
local RemoveFogToggle = false
RemoveFog.btn.MouseButton1Click:Connect(function()
	if RemoveFogToggle == false then
		game.Lighting.Atmosphere.Density = 0
		RemoveFogToggle = true
		RemoveFog.btn.visual.Visible = true
	else
		game.Lighting.Atmosphere.Density = 0.456
		RemoveFogToggle = false
		RemoveFog.btn.visual.Visible = false
	end
end)

local SpeedBoostToggle = false
local player = game.Players.LocalPlayer
local running = false

SpeedBoost.btn.MouseButton1Click:Connect(function()
	SpeedBoostToggle = not SpeedBoostToggle
	SpeedBoost.btn.visual.Visible = SpeedBoostToggle
	if SpeedBoostToggle and not running then
		running = true
		spawn(function()
			while task.wait() do
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					if SpeedBoostToggle then
						player.Character.Humanoid.WalkSpeed = 14
						task.wait()
					else
						player.Character.Humanoid.WalkSpeed = 10
						break
					end
				end
			end
		end)
		running = false
	end
end)

local ESPToggle = false
local function check(g1, g2)
	for i,v in pairs(g1:GetChildren()) do
		if v.Name == player.Name then
			for i, v in pairs(g1:GetChildren()) do
				if v:FindFirstChild("Highlight") then
					v.Highlight:Destroy()
				end
				if ESPToggle and v.Name ~= player.Name then
					local new = Instance.new("Highlight")
					new.Parent = v
					new.FillColor = Color3.new(0, 1, 0)
					new.OutlineTransparency = 1
				end
			end
			for i, vv in pairs(g2:GetChildren()) do
				if vv:FindFirstChild("Highlight") or vv:FindFirstChild("Hihglight") then
					vv.Highlight:Destroy()
				end
				if ESPToggle then
					local new2 = Instance.new("Highlight")
					new2.Parent = vv
					new2.FillColor = Color3.new(1, 0, 0)
					new2.OutlineTransparency = 1
				end
			end
		end
	end
	for i,v in pairs(g2:GetChildren()) do
		if v.Name == player.Name then
			for i, v in pairs(g2:GetChildren()) do
				if v:FindFirstChild("Highlight") then
					v.Highlight:Destroy()
				end
				if ESPToggle and v.Name ~= player.Name then
					local new = Instance.new("Highlight")
					new.Parent = v
					new.FillColor = Color3.new(0, 1, 0)
					new.OutlineTransparency = 1
				end
			end
			for i, vv in pairs(g1:GetChildren()) do
				if vv:FindFirstChild("Highlight") or vv:FindFirstChild("Hihglight") then
					vv.Highlight:Destroy()
				end
				if ESPToggle then
					local new2 = Instance.new("Highlight")
					new2.Parent = vv
					new2.FillColor = Color3.new(1, 0, 0)
					new2.OutlineTransparency = 1
				end
			end
		end
	end
end


ESP.btn.MouseButton1Click:Connect(function()
	ESPToggle = not ESPToggle
	ESP.btn.visual.Visible = ESPToggle
	local g1 = game.Workspace.IIIIllllIIIllIIlIlI_IIllIlIIIllII_o.IIoooIIl
	local g2 = game.Workspace.IIIIllllIIIllIIlIlI_IIllIlIIIllII_o.lIIooolll
	check(g1, g2)
	check(g2, g1)
	g1.ChildAdded:Connect(function()
		check(g1, g2)
		check(g2, g1)
	end)
	g2.ChildAdded:Connect(function()
		check(g1, g2)
		check(g2, g1)
	end)
end)

local RDBToggle = false
RDB.btn.MouseButton1Click:Connect(function()
	RDBToggle = not RDBToggle
	for i,v in pairs(game.Workspace.bodies:GetDescendants()) do
		if v.Name == "dead" then
			v:Destroy()
		end
	end
	RDB.btn.visual.Visible = RDBToggle
	if RDBToggle then
		for i,v in pairs(game.Workspace.bodies:GetChildren()) do
			v:GetPropertyChangedSignal("Name"):Connect(function()
				print(1)
				if v.Name == "dead" then
					v:Destroy()
				end
			end)
		end
		while true do
			wait(0.1)
			if RDBToggle then
				for i,v in pairs(game.Workspace.bodies:GetChildren()) do
					if v.Name == "dead" then
						v:Destroy()
					end
				end
			end
		end
	end
end)
