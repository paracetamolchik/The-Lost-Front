local new = loadstring(game:HttpGet("https://raw.githubusercontent.com/paracetamolchik/VertessHub/refs/heads/main/Hub.lua"))()
local RunS = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local t = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera
local sizeX = cam.ViewportSize.X
local pixel = 1/sizeX
local info = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local window = new.Window("Zombie Attack")
local section1 = window:Section("Auto Kill")
local section2 = window:Section("Kill Aura")
local section3 = window:Section("Visual")
local section4 = window:Section("Misc")
local section5 = window:Section("Player")
local player = game.Players.LocalPlayer
local toggleauto = false
local togglekillaura = false
local togglepickup = false
local interval = 0.01
local deadplr = false
local wsplr = 16
local jpplr = 50
local antiafktoggle = false
local infjumptoggle = false

player.CharacterRemoving:Connect(function()
	deadplr = true
end)

player.CharacterAdded:Connect(function()
	wait(0.3)
	deadplr = false
end)

local sizelist = 0
local poslist = 0
local txtsize = 0
local labelsize = 0

if uis.TouchEnabled then
	sizelist = UDim2.new(0, 120, 0, 180)
	poslist = UDim2.new(1, 124, 0, 10)
	labelsize = UDim2.new(0, 1, 0, 14)
	txtsize = 12
else
	sizelist = UDim2.new(0, 220, 0, 340)
	poslist = UDim2.new(1, -230, 0, 10)
	labelsize = UDim2.new(0, 1, 0, 20)
	txtsize = 17
end

local DistanceY = 7
local DistanceZ = 8
local radius = 25

local partvisual = Instance.new("Part", game.Workspace)
partvisual.Size = Vector3.new(0.5, radius*2, radius*2)
partvisual.Orientation = Vector3.new(0, 0, -90)
partvisual.Transparency = 1
partvisual.Anchored = true
partvisual.CanCollide = false
partvisual.Material = Enum.Material.Neon
partvisual.Color = Color3.fromRGB(255, 0, 0)
partvisual.Name = "visual"
partvisual.Shape = Enum.PartType.Cylinder

local gui = Instance.new("ScreenGui", game.CoreGui)
local listframe = Instance.new("ScrollingFrame", gui)
listframe.BorderSizePixel = 0
listframe.Size = sizelist
listframe.Position = poslist
listframe.CanvasSize = UDim2.new(0, 0, 0, 0)
listframe.ScrollBarThickness = 6
listframe.BackgroundTransparency = 1
listframe.Visible = false
listframe.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

local listlayout = Instance.new("UIListLayout", listframe)
listlayout.SortOrder = Enum.SortOrder.LayoutOrder

local function addlabel(v)
	while true do
		if not v:FindFirstChild("Humanoid") then
			v.ChildAdded:Wait()
		else
			break
		end
	end
	
	local humanoid = v:FindFirstChild("Humanoid")
	if not humanoid then return end

	local fullhp = humanoid.MaxHealth
	humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
		if humanoid.MaxHealth ~= fullhp then
			fullhp = humanoid.MaxHealth
		end
	end)

	local new = Instance.new("Frame", listframe)
	new.Size = UDim2.new(1, 0, 0, 20)
	new.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	new.BorderSizePixel = 0
	local Fillbar = Instance.new("Frame", new)
	Fillbar.Size = UDim2.new(1, 0, 1, 0)
	Fillbar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	Fillbar.BorderSizePixel = 0
	local title = Instance.new("TextLabel", new)
	title.Size = UDim2.new(1, 0, 1, 0)
	title.TextSize = txtsize
	title.Font = Enum.Font.Cartoon
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = " "..v.Name
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.BorderSizePixel = 0
	title.BackgroundTransparency = 1
	local textstroke = Instance.new("UIStroke", title)
	
	humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		local percent = humanoid.Health / fullhp
		listframe.CanvasSize = UDim2.new(0, 0, 0, #listframe:GetChildren() * 20)
		if listframe.CanvasSize.Y.Offset > sizelist.Y.Offset then
			listframe.Size = sizelist + UDim2.new(pixel*6, 0, 0, 0)
			t:Create(Fillbar, info, {Size = UDim2.new(percent-(pixel*6), 0, 1, 0)}):Play()
		else
			listframe.Size = sizelist
			t:Create(Fillbar, info, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
		end
	end)

	while true do
		task.wait()
		if not v then
			new:Destroy()
			break
		end
	end
end

game.Workspace.enemies.ChildAdded:Connect(function(v)
	addlabel(v)
end)

game.Workspace.BossFolder.ChildAdded:Connect(function(v)
	addlabel(v)
end)

local ZombieList = section3:Keybind("Zombie List", Enum.KeyCode.Z, function(db)
	listframe.Visible = not listframe.Visible
end)

local distanceY = section1:Slider("Distance Y", 7, 25, 0, function(v)
	DistanceY = v
end, 0)

local distanceZ = section1:Slider("Distance Z", 8, 25, 0, function(v)
	DistanceZ = v
end, 0)

local raduisSlider = section2:Slider("Kill Aura Radius", 25, 150, 10, function(v)
	radius = v
end, 0)

local pickUp = section4:Togglebtn("Pick Up Powerups", function(db)
	togglepickup = db
end)

local WalkSpeed = section5:Slider("Walk Speed", 16, 100, 16, function(v)
	wsplr = v
end, 0)

spawn(function()
	while true do
		task.wait()
		if not deadplr then
			if player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.WalkSpeed = wsplr
			end
		end
	end
end)

local JumpPower = section5:Slider("Jump Power", 50, 200, 50, function(v)
	jpplr = v
end, 0)

spawn(function()
	while true do
		task.wait()
		if not deadplr then
			if player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.JumpPower = jpplr
			end
		end
	end
end)

local infjump = section5:Togglebtn("Inf Jump", function(db)
	infjumptoggle = db
end)

spawn(function()
	game:GetService("UserInputService").JumpRequest:Connect(function()
		if infjumptoggle then
			game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end
	end)
end)

local antiafk = section5:Togglebtn("Anti AFK", function(db)
	antiafktoggle = db
end)

spawn(function()
	while true do
		if antiafktoggle then
			VIM:SendMouseButtonEvent(0, 0, 0, true, game:GetService("Players").LocalPlayer, 0)
    		task.wait()
    		VIM:SendMouseButtonEvent(0, 0, 0, false, game:GetService("Players").LocalPlayer, 0)
			wait(60*15)
		end
		task.wait()
	end
end)

local interval = section1:Slider("Interval", 0.01, 1, 0, function(v)
	print(v)
	interval = v
end, 3)

spawn(function()
	wait(1)
	while wait(0.1) do
		if togglepickup and not deadplr then
			for _,v in pairs(game.Workspace.Powerups:GetChildren()) do
				if player:FindFirstChild("Character") and player:FindFirstChild("Humanoid") then
					v.Part.Position = player.Character.HumanoidRootPart.Position
				end
			end
		end
	end
end)

spawn(function()
	while true do
		task.wait()
		if not deadplr then
			if player.Character:FindFirstChild("HumanoidRootPart") then
				partvisual.Position = player.Character:WaitForChild("HumanoidRootPart").Position
				partvisual.Size = Vector3.new(0.1, radius*2, radius*2)
			end
		end
	end
end)

local function getNearest()
	local nearest = nil
	local dist = 0
	if toggleauto then
		dist = 10000
	elseif togglekillaura then
		dist = radius
	end
	for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
		if not deadplr then
			if v:FindFirstChild("Head") and player.Character:FindFirstChild("Head") then
				local v1 = player.Character.Head.Position
				local v2 = v:WaitForChild("Head").Position
				local m =(v1-v2).magnitude
				if(m<dist)then
					dist = m
					nearest = v
				end
			end
		end
	end
	for _,v in pairs(game.Workspace.enemies:GetChildren()) do
		if not deadplr then
			if v:FindFirstChild("Head") and player.Character:FindFirstChild("Head") then
				local v1 = player.Character.Head.Position
				local v2 = v:WaitForChild("Head").Position
				local m =(v1-v2).magnitude
				if(m<dist)then
					dist = m
					nearest = v
				end
			end
		end
	end
	return nearest
end

section1:Togglebtn("Auto Kill", function(db)
	toggleauto = db
end)

section2:Togglebtn("Kill Aura", function(db)
	togglekillaura = db
end)

section2:Togglebtn("Visible Radius", function(db)
	if db then
		t:Create(partvisual, info, {Transparency = 0.5}):Play()
	else
		t:Create(partvisual, info, {Transparency = 1}):Play()
	end
end)

_G.globalTarget = nil
spawn(function()
	wait(1)
	while true do
		local target = getNearest()
		if(target~=nil) and (toggleauto or togglekillaura) then
			if toggleauto and target.HumanoidRootPart then
				player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, DistanceY, DistanceZ))
			end
			_G.globalTarget = target
		end
		wait()
	end
end)

spawn(function()
	wait(1)
	while wait() do
		if toggleauto then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0.1,0)
		end
	end
end)

spawn(function()
	wait(1.1)
	while wait() do
		if(_G.globalTarget~=nil and _G.globalTarget:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Tool"))then
			if toggleauto then
				local target = _G.globalTarget
				game.ReplicatedStorage.Gun:FireServer({
					["Normal"] = Vector3.new(0, 0, 0),
					["Direction"] = target.Head.Position,
					["Name"] = player.Character:FindFirstChildOfClass("Tool").Name,
					["Hit"] = target.Head,
					["Origin"] = target.Head.Position,
					["Pos"] = target.Head.Position,
				})
				wait(interval)
			end
			if togglekillaura then
				local target = _G.globalTarget
				game.ReplicatedStorage.Gun:FireServer({
					["Normal"] = Vector3.new(0, 0, 0),
					["Direction"] = target.Head.Position,
					["Name"] = player.Character:FindFirstChildOfClass("Tool").Name,
					["Hit"] = target.Head,
					["Origin"] = target.Head.Position,
					["Pos"] = target.Head.Position,
				})
				wait(interval)
			end
		end
	end
end)
