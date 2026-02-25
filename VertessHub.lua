local new = {}
local t = game:GetService("TweenService")
local info = TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local info2 = TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local info3 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local UIS = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local keycode = ""

local function encode(a)
	local chars = '0123456789'
	local result = ''
	for i=1,9 do
		local charIndex = math.random(#chars)
		result = result .. chars:sub(charIndex, charIndex)
	end
	a.Name = result
end
local function name(a,name) a.Name = name end
local function borderpixel(a) a.BorderSizePixel = 0 end
local function corner(a,b,c) 
	local corner = Instance.new("UICorner",a)
	corner.CornerRadius = UDim.new(b, c) or UDim.new(0, 8)
end
local function stroke(a,b,c,d,e,f) 
	local stroke = Instance.new("UIStroke",a)
	stroke.Color = Color3.fromRGB(b, c, d)
	stroke.Thickness = e
	stroke.BorderStrokePosition = f or Enum.BorderStrokePosition.Outer
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end
local function pos(a,b,c,d,e) a.Position = UDim2.new(b, c, d, e) end
local function center(a) a.AnchorPoint = Vector2.new(0.5,0.5) end
local function size(a,b,c,d,e) a.Size = UDim2.new(b, c, d, e) end
local function tbackground(a) a.BackgroundTransparency = 1 end
local function nvisible(a) a.Visible = false end
local function backgroundcolor(a,b,c,d) a.BackgroundColor3 = Color3.fromRGB(b, c, d) end
local function img(a,b) a.Image = b end
local function imgcolor(a,b,c,d) a.ImageColor3 = Color3.fromRGB(b, c, d) end
local function text(a,b) a.Text = b end
local function textColor(a,b,c,d) a.TextColor3 = Color3.fromRGB(b, c, d) end
local function textSize(a,b) a.TextSize = b end
local function textFont(a,b) a.Font = b end
local function textWarp(a,b) a.TextWrapped = b end
local function textX(a,b) a.TextXAlignment = b end
local function textY(a,b) a.TextYAlignment = b end
local function txtWrapped(a) a.TextWrapped = true end

local function Move(a)
	local dragging = false
	local offsetX, offsetY = 0, 0
	local mouseDownOnButton = false

	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local mouseX, mouseY = input.Position.X, input.Position.Y
			local buttonX = a.AbsolutePosition.X
			local buttonY = a.AbsolutePosition.Y
			local buttonWidth = a.AbsoluteSize.X
			local buttonHeight = a.AbsoluteSize.Y

			if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY and mouseY <= buttonY + buttonHeight then
				offsetX = buttonX - mouseX
				offsetY = buttonY - mouseY
				dragging = true
			end
		end
	end

	local function onInputChanged(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mouseX, mouseY = input.Position.X, input.Position.Y
			t:Create(a.Parent, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.new(0, mouseX + offsetX, 0, mouseY + offsetY)}):Play()
		end
	end

	local function onInputEnded(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end

	UIS.InputBegan:Connect(onInputBegan)
	UIS.InputChanged:Connect(onInputChanged)
	UIS.InputEnded:Connect(onInputEnded)
end

local function getKeyCodeString(a)
	local keyCodeString = tostring(a)
	local key = keyCodeString:sub(keyCodeString:find("%.([^.]+)$") + 1)
	keycode = a
	return key
end

function new.Window(namewindow)
	local Gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui) encode(Gui)
	
	local Main1 = Instance.new("CanvasGroup", Gui) borderpixel(Main1)
	corner(Main1, 0, 8)
	pos(Main1, .333, 0, .3, 0)
	size(Main1,0, 380, 0, 270)
	backgroundcolor(Main1, 0, 0, 25)
	stroke(Main1, 0, 0, 150, 1)
	
	local Top = Instance.new("Frame", Main1) borderpixel(Top)
	corner(Top, 0, 8)
	size(Top, 1, 0, 0, 30)
	backgroundcolor(Top, 0, 0, 70)
	stroke(Top, 0, 0, 150, 1)
	Move(Top)
	if UIS.TouchEnabled then
		local drag = Instance.new("UIDragDetector", Top)
		drag.BoundingUI = Main1
	end
	
	local Logo = Instance.new("ImageLabel", Top) borderpixel(Logo)
	size(Logo, 0, 22, 0, 22)
	pos(Logo, 0, 17, 0, 15)
	center(Logo)
	tbackground(Logo)
	img(Logo, "rbxassetid://94570010893830")

	local Title = Instance.new("TextLabel", Top) borderpixel(Title)
	size(Title, 1, -94, 1, 0)
	pos(Title, 0, 34, 0, 0)
	tbackground(Title)
	text(Title, namewindow)
	textSize(Title, 18)
	textFont(Title, Enum.Font.Cartoon)
	textX(Title, Enum.TextXAlignment.Left)
	textColor(Title, 255, 255, 255)
	txtWrapped(Title)
	
	local Close = Instance.new("TextButton", Top) borderpixel(Close) text(Close, "")
	corner(Close, 0, 5)
	size(Close, 0, 20, 0, 20)
	pos(Close, 1, -18, 0.5, 0)
	center(Close)
	backgroundcolor(Close, 0, 0, 25)
	stroke(Close, 0, 0, 150, 1)
	
	local CloseText = Instance.new("ImageLabel", Close) borderpixel(CloseText)
	size(CloseText, .5, 0, .5, 0)
	pos(CloseText, .5, 0, .5, 0)
	center(CloseText)
	tbackground(CloseText)
	img(CloseText, "rbxassetid://96595317895175")
	imgcolor(CloseText, 255, 0, 0)
	
	local CollapseBtn = Instance.new("TextButton", Top) borderpixel(CollapseBtn) text(CollapseBtn, "")
	corner(CollapseBtn, 0, 5)
	size(CollapseBtn, 0, 20, 0, 20)
	pos(CollapseBtn, 1, -46, .5, 0)
	center(CollapseBtn)
	backgroundcolor(CollapseBtn, 0, 0, 25)
	stroke(CollapseBtn, 0, 0, 150, 1)
	
	local opened = false
	CollapseBtn.MouseButton1Click:Connect(function()
		if opened == false then
			t:Create(Main1, info, {Size = UDim2.new(0, 115+Title.TextBounds.X, 0, 31)}):Play()
		else
			t:Create(Main1, info, {Size = UDim2.new(0, 380, 0, 270)}):Play()
		end
		opened = not opened
	end)
	
	local CollapseVisual = Instance.new("Frame", CollapseBtn) borderpixel(CollapseVisual)
	corner(CollapseVisual, 1, 0)
	center(CollapseVisual)
	size(CollapseVisual, 0, 12, 0, 4)
	pos(CollapseVisual, .5, 0, .5, 0)
	backgroundcolor(CollapseVisual, 255, 255, 255)
	
	local Sectionsframe = Instance.new("Frame", Main1) borderpixel(Sectionsframe)
	size(Sectionsframe, 0, 106, 0, 233)
	pos(Sectionsframe, 0, 4, 0, 34)
	corner(Sectionsframe, 0, 8)
	stroke(Sectionsframe, 0, 0, 150, 1)
	backgroundcolor(Sectionsframe, 0, 0, 70)
	
	local List = Instance.new("ScrollingFrame", Sectionsframe) borderpixel(List)
	size(List, 1, 0, 1, 0)
	tbackground(List)
	List.ScrollBarThickness = 4
	List.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	
	local Container = Instance.new("Frame", List) borderpixel(Container)
	pos(Container, 0, 6, 0, 6)
	size(Container, 1, -16, 1, -4)
	tbackground(Container)
	
	local UIListLayout = Instance.new("UIListLayout", Container)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 6)
	
	local MainSections = Instance.new("ScrollingFrame", Main1) borderpixel(MainSections)
	MainSections.CanvasSize = UDim2.new(0, 0, 0, 0)
	tbackground(MainSections)
	size(MainSections, 0, 266, 0, 235)
	pos(MainSections, 0, 113, 0, 33)
	corner(MainSections, 0, 8)
	
	local ContainerSections = Instance.new("Frame", MainSections) borderpixel(ContainerSections)
	size(ContainerSections, 1, 0, 1, 0)
	tbackground(ContainerSections)
	
	local Sections = {}
	
	function Sections:Section(namesection)
		local Sectionbtn = Instance.new("TextButton", Container) borderpixel(Sectionbtn) txtWrapped(Sectionbtn)
		text(Sectionbtn, namesection)
		textSize(Sectionbtn, 15)
		backgroundcolor(Sectionbtn, 0, 0, 25)
		textColor(Sectionbtn, 255, 255, 255)
		textFont(Sectionbtn, Enum.Font.Cartoon)
		corner(Sectionbtn, 0, 6)
		stroke(Sectionbtn, 0, 0, 150, 1)
		size(Sectionbtn, 1, 0, 0, 22)
		
		local SectionPage = Instance.new("ScrollingFrame", ContainerSections) borderpixel(SectionPage)
		SectionPage.CanvasSize = UDim2.new(0, 0, 0, 0)
		SectionPage.ScrollBarThickness = 4
		SectionPage.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
		backgroundcolor(SectionPage, 0, 0, 70)
		corner(SectionPage, 0, 8)
		size(SectionPage, 1, -1, 1, -1)
		pos(SectionPage, 0, 1, #Sections, 1)
		stroke(SectionPage, 0, 0, 150, 1)
		
		local CSectionPage = Instance.new("Frame", SectionPage) borderpixel(CSectionPage)
		size(CSectionPage, 1, -16, 1, -4)
		pos(CSectionPage, 0, 6, 0, 6)
		tbackground(CSectionPage)
		
		local UiListSection = Instance.new("UIListLayout", CSectionPage)
		UiListSection.SortOrder = Enum.SortOrder.LayoutOrder
		UiListSection.Padding = UDim.new(0, 5)
		
		if #Sections == 0 then
			backgroundcolor(Sectionbtn, 0, 0, 60)
		end
		
		Sectionbtn.MouseButton1Click:Connect(function()
			for i, v in pairs(ContainerSections:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					local pos = SectionPage.Position
					t:Create(v, info, {Position = UDim2.new(0, 1, v.Position.Y.Scale-pos.Y.Scale, 1)}):Play()
				end
			end
			for i, v in pairs(Container:GetChildren()) do
				if v:IsA("TextButton") then
					t:Create(v, info2, {BackgroundColor3 = Color3.fromRGB(0, 0, 25)}):Play()
				end
			end
			t:Create(Sectionbtn, info2, {BackgroundColor3 = Color3.fromRGB(0, 0, 60)}):Play()
		end)
		
		table.insert(Sections, namesection)
		
		local Buttons = {}
		
		function Buttons:Label(labeltext)
			local Label = Instance.new("TextLabel", CSectionPage) borderpixel(Label)
			text(Label, " "..labeltext)
			size(Label, 1, 0, 0, 26)
			corner(Label, 0, 7)
			textSize(Label, 16)
			textColor(Label, 255, 255, 255)
			textFont(Label, Enum.Font.Cartoon)
			textX(Label, Enum.TextXAlignment.Left)
			stroke(Label, 0, 0, 150, 1)
			backgroundcolor(Label, 0, 0, 25)
		end
		
		function Buttons:Button(btntext, callback)
			local btn = Instance.new("TextButton", CSectionPage) borderpixel(btn)
			text(btn, "")
			size(btn, 1, 0, 0, 26)
			corner(btn, 0, 7)
			stroke(btn, 0, 0, 150, 1)
			backgroundcolor(btn, 0, 0, 25)
			
			local textbtn = Instance.new("TextLabel", btn) borderpixel(textbtn) txtWrapped(textbtn)
			text(textbtn, btntext)
			textSize(textbtn, 16)
			textColor(textbtn, 255, 255, 255)
			textFont(textbtn, Enum.Font.Cartoon)
			textX(textbtn, Enum.TextXAlignment.Left)
			tbackground(textbtn)
			pos(textbtn, 0, 28, 0, 0)
			size(textbtn, 1, -28, 1, 0)
			
			local btnvisual = Instance.new("ImageLabel", btn) borderpixel(btnvisual)
			btnvisual.Rotation = 45
			size(btnvisual, 0, 22, 0, 22)
			center(btnvisual)
			pos(btnvisual, 0, 14, 0.5, 0)
			tbackground(btnvisual)
			img(btnvisual, "rbxassetid://111829919777105")
			
			btn.MouseButton1Click:Connect(function()
				callback()
			end)
		end
		
		function Buttons:Togglebtn(textToggletbtn, callback)
			local db = false
			local btn = Instance.new("TextButton", CSectionPage) borderpixel(btn)
			text(btn, "")
			size(btn, 1, 0, 0, 26)
			corner(btn, 0, 7)
			stroke(btn, 0, 0, 150, 1)
			backgroundcolor(btn, 0, 0, 25)
			
			local textbtn = Instance.new("TextLabel", btn) borderpixel(textbtn) txtWrapped(textbtn)
			text(textbtn, textToggletbtn)
			textSize(textbtn, 16)
			textColor(textbtn, 255, 255, 255)
			textFont(textbtn, Enum.Font.Cartoon)
			textX(textbtn, Enum.TextXAlignment.Left)
			tbackground(textbtn)
			pos(textbtn, 0, 28, 0, 0)
			size(textbtn, 1, -28, 1, 0)
			
			local circle = Instance.new("Frame", btn) borderpixel(circle)
			size(circle, 0, 14, 0, 14)
			center(circle)
			pos(circle, 0, 14, 0.5, 0)
			tbackground(circle)
			corner(circle, 1, 0)
			stroke(circle, 255, 255, 255, 1)
			
			local circle2 = Instance.new("Frame", circle) borderpixel(circle2)
			size(circle2, 0, 10, 0, 10)
			corner(circle2, 1, 0)
			pos(circle2, 0.5, 0, 0.5, 0)
			center(circle2)
			tbackground(circle2)
			backgroundcolor(circle2, 255, 255, 255)
			
			btn.MouseButton1Click:Connect(function()
				db = not db
				callback(db)
				if circle2.BackgroundTransparency == 1 then
					t:Create(circle2, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				else
					t:Create(circle2, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				end
			end)
		end
		
		function Buttons:Slider(textbtn, default, max, min, callback, nums)
			local btn = Instance.new("Frame", CSectionPage) borderpixel(btn)
			size(btn, 1, 0, 0, 26)
			corner(btn, 0, 7)
			stroke(btn, 0, 0, 150, 1)
			backgroundcolor(btn, 0, 0, 25)
			
			local Label = Instance.new("TextLabel", btn) borderpixel(Label)
			text(Label, " "..textbtn)
			size(Label, 1, 0, 0, 26)
			corner(Label, 0, 7)
			textSize(Label, 16)
			textColor(Label, 255, 255, 255)
			textFont(Label, Enum.Font.Cartoon)
			textX(Label, Enum.TextXAlignment.Left)
			stroke(Label, 0, 0, 150, 1)
			backgroundcolor(Label, 0, 0, 25)
			
			local bar = Instance.new("Frame", btn) borderpixel(bar)
			size(bar, 0, 100, 0, 6)
			pos(bar, 1, -106, 0, 10)
			corner(bar, 1, 0)
			backgroundcolor(bar, 0, 0, 0)
			stroke(bar, 0, 0, 150, 1)
			
			local fillbar = Instance.new("Frame", bar) borderpixel(fillbar)
			size(fillbar, 0, 0, 1, 0)
			corner(fillbar, 1, 0)
			backgroundcolor(fillbar, 0, 0, 75)
			
			local textval = Instance.new("TextLabel", btn) borderpixel(textval)
			textval.AnchorPoint = Vector2.new(1, 0)
			text(textval, default)
			size(textval, 0, 20, 1, 0)
			pos(textval, 1, -110, 0, 0)
			textColor(textval, 255, 255, 255)
			textFont(textval, Enum.Font.Cartoon)
			textSize(textval, 14)
			tbackground(textval)
			textX(textval, Enum.TextXAlignment.Right)
			local dragging = false
			
			local initialXScale = (default - min) / (max - min)
			fillbar.Size = UDim2.new(initialXScale, 0, 1, 0)

			local function update()
				local relativeX = mouse.X - fillbar.Parent.AbsolutePosition.X
				local newXScale = math.clamp(relativeX / 100, 0, 1)
				t:Create(fillbar, info3, {Size = UDim2.new(newXScale, 0, 1, 0)}):Play()
				textval.Text = tonumber(string.format("%." .. tostring(nums) .. "f", newXScale * (max - min) + min))
				if nums then
					callback(tonumber(string.format("%." .. tostring(nums) .. "f", newXScale * (max - min) + min)))
				else
					callback(math.floor(newXScale * (max - min) + min))
				end
			end

			local function onInputChanged(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					update()
				end
			end

			fillbar.Parent.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					update()
				end
			end)

			UIS.InputChanged:Connect(onInputChanged)

			UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)
			textval.Text = default
		end
		
		function Buttons:Keybind(textbtn, Key, callback)
			local firstchanged = false
			local chanding = false
			local btn = Instance.new("TextButton", CSectionPage) borderpixel(btn)
			text(btn, "")
			size(btn, 1, 0, 0, 26)
			corner(btn, 0, 7)
			stroke(btn, 0, 0, 150, 1)
			backgroundcolor(btn, 0, 0, 25)
			
			local Label = Instance.new("TextLabel", btn) borderpixel(Label) txtWrapped(Label)
			text(Label, " "..textbtn)
			size(Label, 1, -28, 0, 26)
			pos(Label, 0, 24, 0, 0)
			textSize(Label, 16)
			textColor(Label, 255, 255, 255)
			textFont(Label, Enum.Font.Cartoon)
			textX(Label, Enum.TextXAlignment.Left)
			tbackground(Label)
			
			local keyvisual = Instance.new("TextLabel", btn) borderpixel(keyvisual)
			size(keyvisual, 0, 16, 0, 16)
			text(keyvisual, getKeyCodeString(Key))
			pos(keyvisual, 0, 6, 0, 5)
			corner(keyvisual, 0, 4)
			backgroundcolor(keyvisual, 0, 0, 60)
			stroke(keyvisual, 0, 0, 150, 1)
			textColor(keyvisual, 255, 255, 255)
			textFont(keyvisual, Enum.Font.Cartoon)
			textSize(keyvisual, 15)
			
			local function updateKeyVisual()
				text(keyvisual, getKeyCodeString(Key))
				keyvisual.Size = UDim2.new(0, keyvisual.TextBounds.X + 8, 0, 16)
				pos(Label, 0, keyvisual.Size.X.Offset+8, 0, 0)
				chanding = false
			end
			
			UIS.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					if chanding then
						Key = input.KeyCode
						updateKeyVisual()
						chanding = false
						firstchanged = true
					end
					if not chanding then
						if input.KeyCode == Key and not firstchanged then
							callback()
						end
						firstchanged = false
					end
				end	
			end)
			
			btn.MouseButton1Click:Connect(function()
				text(keyvisual, "...")
				keyvisual.Size = UDim2.new(0, keyvisual.TextBounds.X+8, 0, 16)
				pos(Label, 0, keyvisual.Size.X.Offset+8, 0, 0)
				chanding = true
			end)
		end
		return Buttons
	end
	return Sections
end

return new
