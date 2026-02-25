local new = loadstring(game:HttpGet("https://raw.githubusercontent.com/paracetamolchik/The-Lost-Front/refs/heads/main/VertessHub.lua"))()
local window = new.Window("Zombie Attack")
local section1 = window:Section("Auto Kill")
local section2 = window:Section("Kill Aura")
local section3 = window:Section("Visual")
local player = game.Players.LocalPlayer
local toggleauto = false
local togglekillaura = false

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
listframe.Size = UDim2.new(0, 200, 0, 100)
listframe.Position = UDim2.new(1, -210, 0, 10)
listframe.CanvasSize = UDim2.new(0, 0, 0, 0)
listframe.ScrollBarThickness = 8
listframe.BackgroundTransparency = 1
listframe.Visible = false
listframe.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
local listlayout = Instance.new("UIListLayout", listframe)
listlayout.Padding = UDim.new(0, 2)
listlayout.SortOrder = Enum.SortOrder.LayoutOrder

spawn(function()
	game.Workspace.enemies.ChildAdded:Connect(function(v)
		local new = Instance.new("TextLabel", listframe)
		new.Size = UDim2.new(1, 0, 0, 22)
		new.TextSize = 18
		new.Font = Enum.Font.Cartoon
		new.TextXAlignment = Enum.TextXAlignment.Right
		new.Text = v.Name
		new.TextColor3 = Color3.fromRGB(255, 255, 255)
		new.BackgroundTransparency = 1
		listframe.CanvasSize = UDim2.new(0, 0, 0, #listframe:GetChildren() * 22)
	end)
	game.Workspace.enemies.ChildRemoved:Connect(function(v)
		for i, vv in pairs(listframe:GetChildren()) do
			if vv:IsA("TextLabel") then
				if vv.Text == v.Name then
					listframe.CanvasSize = UDim2.new(0, 0, 0, (#listframe:GetChildren() * 22)-22)
					vv:Destroy()
					return
				end
			end
		end
	end)
end)

local ZombieList = section3:Togglebtn("Zombie List", function(db)
	listframe.Visible = db
end)

local distanceY = section1:Slider("Distance Y", 7, 25, 0, function(v)
	DistanceY = v
end)

local distanceZ = section1:Slider("Distance Z", 8, 25, 0, function(v)
	DistanceZ = v
end)

local raduisSlider = section2:Slider("Kill Aura Radius", 75, 250, 25, function(v)
	radius = v
end)

local function getNearest()
	partvisual.Position = Vector3.new(player.Character.Head.Position.X, player.Character.Head.Position.Y - DistanceY, player.Character.Head.Position.Z)
	partvisual.Size = Vector3.new(radius, radius, radius)
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
game:GetService("RunService").RenderStepped:Connect(function()
	local target = getNearest()
	if(target~=nil) and toggleauto then
		player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, DistanceY, DistanceZ))
		_G.globalTarget = target
	end
end)

spawn(function()
	while wait() do
		if toggleauto then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
			game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)
		end
	end
end)

while wait() do
	if(_G.globalTarget~=nil and _G.globalTarget:FindFirstChild("Head") and player.Character:FindFirstChildOfClass("Tool"))then
		if toggleauto or togglekillaura then
			local target = _G.globalTarget
			game.ReplicatedStorage.Gun:FireServer({
				["Normal"] = Vector3.new(0, 0, 0),
				["Direction"] = target.Head.Position,
				["Name"] = player.Character:FindFirstChildOfClass("Tool").Name,
				["Hit"] = target.Head,
				["Origin"] = target.Head.Position,
				["Pos"] = target.Head.Position,
			})
		end
		wait()
	end
end
