local new = loadstring(game:HttpGet("https://raw.githubusercontent.com/paracetamolchik/The-Lost-Front/refs/heads/main/VertessHub.lua"))()
local RunS = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local t = game:GetService("TweenService")
local info = TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
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
	poslist = UDim2.new(1, -220, 0, 10)
	labelsize = UDim2.new(0, 1, 0, 20)
	txtsize = 17
end

local DistanceY = 7
local DistanceZ = 8
local radius = 75

local partvisual = Instance.new("Part", game.Workspace)
partvisual.Size = Vector3.new(radius, radius, radius)
partvisual.Transparency = 0.5
partvisual.Anchored = true
partvisual.CanCollide = false
partvisual.Material = Enum.Material.Neon
partvisual.Color = Color3.fromRGB(255, 0, 0)
partvisual.Name = "visual"
partvisual.Shape = Enum.PartType.Ball

local gui = Instance.new("ScreenGui", game.CoreGui)
local listframe = Instance.new("ScrollingFrame", gui)
listframe.BorderSizePixel = 0
listframe.Size = sizelist
listframe.Position = poslist
listframe.CanvasSize = UDim2.new(0, 0, 0, 0)
listframe.ScrollBarThickness = 6
listframe.BackgroundTransparency = 1
listframe.Visible = false
listframe.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

local listlayout = Instance.new("UIListLayout", listframe)
listlayout.SortOrder = Enum.SortOrder.LayoutOrder

game.Workspace.enemies.ChildAdded:Connect(function(v)
	wait(0.1)
	if not v:FindFirstChild("Humanoid") then
		v.ChildAdded:Wait() 
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
	title.TextXAlignment = Enum.TextXAlignment.Right
	title.Text = v.Name
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.BorderSizePixel = 0
	title.BackgroundTransparency = 1
	local textstroke = Instance.new("UIStroke", title)
	
	humanoid.Died:Connect(function()
		new:Destroy()
	end)
	humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if v.Parent ~= game.Workspace.enemies then
			new:Destroy()
			return
		end
		if not v or not v.Parent or not humanoid or humanoid.Health <= 0 then
			new:Destroy()
			return
		end
		if Fillbar.Size == UDim2.new(0, 0, 1, 0) or Fillbar.Size == UDim2.new(0, 6, 1, 0) then
			new:Destroy()
			return
		end
		local percent = humanoid.Health / fullhp
		listframe.CanvasSize = UDim2.new(0, 0, 0, #listframe:GetChildren() * 20)
		if listframe.CanvasSize.Y.Offset > sizelist.Y.Offset then
			listframe.Size = sizelist + UDim2.new(0, 6, 0, 0)
			listframe.Position = poslist + UDim2.new(0, -6, 0, 0)
			Fillbar.Position = UDim2.new(0, 6, 0, 0)
			t:Create(Fillbar, info, {Size = UDim2.new(percent, -6, 1, 0)}):Play()
		else
			listframe.Size = sizelist
			listframe.Position = poslist
			Fillbar.Position = UDim2.new(0, 0, 0, 0)
			t:Create(Fillbar, info, {Size = UDim2.new(percent, 0, 1, 0)}):Play()
		end
	end)
end)

local ZombieList = section3:Togglebtn("Zombie List", function(db)
	listframe.Visible = db
end)

local distanceY = section1:Slider("Distance Y", 7, 25, 0, function(v)
	DistanceY = v
end, 0)

local distanceZ = section1:Slider("Distance Z", 8, 25, 0, function(v)
	DistanceZ = v
end, 0)

local raduisSlider = section2:Slider("Kill Aura Radius", 75, 250, 25, function(v)
	radius = v
end, 0)

local pickUp = section4:Togglebtn("Pick Up Powerups", function(db)
	togglepickup = db
end)

local WalkSpeed = section5:Slider("Walk Speed", 16, 100, 16, function(v)
	player.Character.Humanoid.WalkSpeed = v
end, 0)

local JumpPower = section5:Slider("Jump Power", 50, 200, 50, function(v)
	player.Character.Humanoid.JumpPower = v
end, 0)

local interval = section1:Slider("Interval", 0.01, 1, 0, function(v)
	print(v)
	interval = v
end, 3)

spawn(function()
	wait(1)
	while wait(0.1) do
		if togglepickup then
			for _,v in pairs(game.Workspace.Powerups:GetChildren()) do
				v.Part.Position = player.Character.HumanoidRootPart.Position
			end
		end
	end
end)

local function getNearest()
	--partvisual.Position = Vector3.new(player.Character.Head.Position.X, player.Character.Head.Position.Y - DistanceY, player.Character.Head.Position.Z)
	--partvisual.Size = Vector3.new(radius, radius, radius)
	local nearest = nil
	local dist = 0
	if toggleauto then
		dist = 10000
	elseif togglekillaura then
		dist = radius
	end
	for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
		if(v:FindFirstChild("Head")~=nil)then
			local m =(player.Character.Head.Position-v.Head.Position).magnitude
			if(m<dist)then
				dist = m
				nearest = v
			end
		end
	end
	for _,v in pairs(game.Workspace.enemies:GetChildren()) do
		if(v:FindFirstChild("Head")~=nil)then
			local m =(player.Character.Head.Position-v.Head.Position).magnitude
			if(m<dist)then
				dist = m
				nearest = v
			end
		end
	end
	return nearest
end

section1:Togglebtn("Enable Auto Kill", function(db)
	toggleauto = db
end)

section2:Togglebtn("Enable Kill Aura", function(db)
	togglekillaura = db
end)

_G.globalTarget = nil
spawn(function()
	wait(1)
	while true do
		local target = getNearest()
		if(target~=nil) and (toggleauto or togglekillaura) then
			if togglekillaura then
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
			game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)
		end
	end
end)

spawn(function()
	while wait(interval) do
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
				print("Sent1")
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
				print("Sent2")
				wait(interval)
			end
		end
	end
end)
