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

local gui = game.Players.LocalPlayer.PlayerGui
local testGui = create("ScreenGui", gui, "test")

----- Main -----

local Main = create("CanvasGroup", testGui, "Main",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.137255)},
	{BackgroundTransparency = 0},
	{Size = UDim2.new(0, 400, 0, 300)}, 
	{Position = UDim2.new(0.5, 0, 0.5, 0)}, 
	{AnchorPoint = Vector2.new(0.5, 0.5)})
local UiCorner1 = create("UICorner", Main, "UICorner", {CornerRadius = UDim.new(0, 8)})

----- Top -----

local Top1 = create("Frame", Main, "Top",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
	{Size = UDim2.new(1, 0, 0, 30)})
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
	{Position = UDim2.new(0, 386, 0.5, 0)},
	{AnchorPoint = Vector2.new(0.5, 0.5)},
	{Image = "rbxassetid://96595317895175"})
local Text1 = create("TextLabel", Top1, "TextLabel",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(1, 0, 1, 0)}, 
	{Position = UDim2.new(0, 38, 0, 0)},
	{Text = "Vertess hub"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon},
	{TextXAlignment = Enum.TextXAlignment.Left})
local UiDrag = create("UIDragDetector", Main, "UIDragDetector", {BoundingUI = Top1})

----- Left -----

local Left = create("Frame", Main, "Left",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Position = UDim2.new(0, 0, 0, 30)},
	{Size = UDim2.new(0, 90, 0, 270)})
local UiStroke = create("UIStroke", Left, "UIStroke",
	{Color = Color3.new(0, 0, 0.27451)},
	{Thickness = 2})
local btn1 = create("TextButton", Left, "TextButton",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
	{AnchorPoint = Vector2.new(0.5, 0.5)},
	{Size = UDim2.new(0, 74, 0, 26)}, 
	{Position = UDim2.new(0.5, 0, 0, 22)},
	{Text = "Scripts"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon})
local UiCorner3 = create("UICorner", btn1, "UICorner", {CornerRadius = UDim.new(0, 6)})
local btn2 = create("TextButton", Left, "TextButton",
	{BorderSizePixel = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
	{AnchorPoint = Vector2.new(0.5, 0.5)},
	{Size = UDim2.new(0, 74, 0, 26)}, 
	{Position = UDim2.new(0.5, 0, 0, 56)},
	{Text = "Settings"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon})
local UiCorner4 = create("UICorner", btn2, "UICorner", {CornerRadius = UDim.new(0, 6)})

----- Container -----

local Container = create("ScrollingFrame", Main, "Container",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Position = UDim2.new(0, 90, 0, 30)},
	{Size = UDim2.new(0, 310, 0, 270)},
	{CanvasSize = UDim2.new(0, 0, 0, 0)})
local ScriptsFrame = create("Frame", Container, "ScriptsFrame",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(1, -14, 1, -6)}, 
	{Position = UDim2.new(0, 8, 0, 6)})
local UiListLayout = create("UIListLayout", ScriptsFrame, "UIListLayout")
local TLFFrame = create("Frame", ScriptsFrame, "TLFFrame",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.27451)},
	{Size = UDim2.new(1, 0, 0, 30)})
local UiCorner5 = create("UICorner", TLFFrame, "UICorner", {CornerRadius = UDim.new(0.4, 0)})
local TLFText = create("TextLabel", TLFFrame, "TLFFrame",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 1},
	{Size = UDim2.new(1, -6, 1, 0)}, 
	{Position = UDim2.new(0, 6, 0, 0)},
	{Text = "The Lost Front"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon},
	{TextXAlignment = Enum.TextXAlignment.Left})
local btn3 = create("TextButton", TLFFrame, "TextButton",
	{BorderSizePixel = 0},
	{BackgroundTransparency = 0},
	{BackgroundColor3 = Color3.new(0, 0, 0.588235)},
	{Size = UDim2.new(0, 70, 0, 22)}, 
	{AnchorPoint = Vector2.new(1, 0.5)},
	{Position = UDim2.new(1, -10, 0.5, 0)},
	{Text = "Execute"},
	{TextColor3 = Color3.new(1, 1, 1)},
	{TextSize = 18},
	{Font = Enum.Font.Cartoon})
local UiCorner5 = create("UICorner", btn3, "UICorner", {CornerRadius = UDim.new(1, 0)})

btn3.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/paracetamolchik/The-Lost-Front/refs/heads/main/File.lua"))()
	Main:Destroy()
end)
