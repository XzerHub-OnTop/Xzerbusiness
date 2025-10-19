local Packages = {}

local RunService = game:GetService('RunService')
local ContentProvider = game:GetService('ContentProvider')
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService('Players')
local CoreGui = game:GetService('CoreGui')

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

function Packages:Hidden()
	return if RunService:IsStudio() then Players else CoreGui
end

function Packages:Init()
	local Check = Instance.new("ScreenGui")
	local Background_1 = Instance.new("Frame")
	local UICorner_1 = Instance.new("UICorner")
	local UIStroke_1 = Instance.new("UIStroke")
	local DropShadow_1 = Instance.new("ImageLabel")
	local Page_1 = Instance.new("Frame")
	local UIPageLayout_1 = Instance.new("UIPageLayout")

	Check.Name = "Check"
	Check.Parent = Packages:Hidden()
	Check.ZIndexBehavior = Enum.ZIndexBehavior.Global

	Background_1.Name = "Background"
	Background_1.Parent = Check
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Color3.fromRGB(250,250,250)
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(0, 300,0, 300)

	UICorner_1.Parent = Background_1

	UIStroke_1.Parent = Background_1
	UIStroke_1.Color = Color3.fromRGB(161,161,161)
	UIStroke_1.Thickness = 1

	DropShadow_1.Name = "DropShadow"
	DropShadow_1.Parent = Background_1
	DropShadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_1.BackgroundColor3 = Color3.fromRGB(28,28,30)
	DropShadow_1.BackgroundTransparency = 1
	DropShadow_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.BorderSizePixel = 0
	DropShadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	DropShadow_1.Size = UDim2.new(1, 120,1, 120)
	DropShadow_1.ZIndex = 0
	DropShadow_1.Image = "rbxassetid://8992230677"
	DropShadow_1.ImageColor3 = Color3.fromRGB(0,0,0)
	DropShadow_1.ImageTransparency = 0.699999988079071
	DropShadow_1.ScaleType = Enum.ScaleType.Slice
	DropShadow_1.SliceCenter = Rect.new(99, 99, 99, 99)

	Page_1.Name = "Page"
	Page_1.Parent = Background_1
	Page_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Page_1.BackgroundTransparency = 1
	Page_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Page_1.BorderSizePixel = 0
	Page_1.Size = UDim2.new(1, 0,1, 0)
	Page_1.ClipsDescendants = true

	UIPageLayout_1.Parent = Page_1
	UIPageLayout_1.TweenTime = 0.5
	UIPageLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIPageLayout_1.TouchInputEnabled = false
	UIPageLayout_1.ScrollWheelInputEnabled = false
	UIPageLayout_1.GamepadInputEnabled = false

	local Loading = Instance.new("Frame")
	local Title_1 = Instance.new("TextLabel")

	Loading.Name = "Loading"
	Loading.Parent = Page_1
	Loading.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Loading.BackgroundTransparency = 1
	Loading.BorderColor3 = Color3.fromRGB(0,0,0)
	Loading.BorderSizePixel = 0
	Loading.Size = UDim2.new(1, 0,1, 0)

	Title_1.Name = "Title"
	Title_1.Parent = Loading
	Title_1.AnchorPoint = Vector2.new(0, 0.5)
	Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Title_1.BackgroundTransparency = 1
	Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Title_1.BorderSizePixel = 0
	Title_1.Position = UDim2.new(0, 0,0.5, 0)
	Title_1.Size = UDim2.new(1, 0,0, 50)
	Title_1.Font = Enum.Font.FredokaOne
	Title_1.Text = "Loading"
	Title_1.TextColor3 = Color3.fromRGB(50,50,50)
	Title_1.TextSize = 30

	task.wait(0.1)

	Title_1.Text = "Loading ."

	task.wait(0.5)

	Title_1.Text = "Loading .."

	task.wait(0.5)

	Title_1.Text = "Loading ..."

	task.wait(0.5)

	Title_1.Text = "Success"

	task.wait(0.5)

	local Add = Instance.new("Frame")
	local Scrolling_1 = Instance.new("ScrollingFrame")
	local UIListLayout_1 = Instance.new("UIListLayout")
	local UIPadding_1 = Instance.new("UIPadding")
	local UIPadding_2 = Instance.new("UIPadding")

	Add.Name = "Add"
	Add.Parent = Page_1
	Add.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Add.BackgroundTransparency = 1
	Add.BorderColor3 = Color3.fromRGB(0,0,0)
	Add.BorderSizePixel = 0
	Add.Size = UDim2.new(1, 0,1, 0)

	Scrolling_1.Name = "Scrolling"
	Scrolling_1.Parent = Add
	Scrolling_1.Active = true
	Scrolling_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Scrolling_1.BackgroundTransparency = 1
	Scrolling_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Scrolling_1.BorderSizePixel = 0
	Scrolling_1.Size = UDim2.new(1, 0,1, 0)
	Scrolling_1.ClipsDescendants = true
	Scrolling_1.AutomaticCanvasSize = Enum.AutomaticSize.None
	Scrolling_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	Scrolling_1.CanvasPosition = Vector2.new(0, 0)
	Scrolling_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	Scrolling_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	Scrolling_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	Scrolling_1.ScrollBarImageColor3 = Color3.fromRGB(0,0,0)
	Scrolling_1.ScrollBarImageTransparency = 1
	Scrolling_1.ScrollBarThickness = 0
	Scrolling_1.ScrollingDirection = Enum.ScrollingDirection.XY
	Scrolling_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	Scrolling_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
	Scrolling_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

	UIListLayout_1.Parent = Scrolling_1
	UIListLayout_1.Padding = UDim.new(0,3)
	UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_1.Wraps = true

	UIPadding_1.Parent = Scrolling_1
	UIPadding_1.PaddingBottom = UDim.new(0,1)
	UIPadding_1.PaddingLeft = UDim.new(0,1)
	UIPadding_1.PaddingRight = UDim.new(0,1)
	UIPadding_1.PaddingTop = UDim.new(0,1)

	UIPadding_2.Parent = Add
	UIPadding_2.PaddingBottom = UDim.new(0,2)
	UIPadding_2.PaddingLeft = UDim.new(0,2)
	UIPadding_2.PaddingRight = UDim.new(0,2)
	UIPadding_2.PaddingTop = UDim.new(0,2)

	local Game = {}

	function Game:Add(Icon, value)
		local Game = Instance.new("ImageLabel")
		local UICorner_1 = Instance.new("UICorner")
		local Title_1 = Instance.new("TextLabel")
		local UIStroke_1 = Instance.new("UIStroke")

		Game.Name = "Game"
		Game.Parent = Scrolling_1
		Game.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Game.BackgroundTransparency = 1
		Game.BorderColor3 = Color3.fromRGB(0,0,0)
		Game.BorderSizePixel = 0
		Game.Size = UDim2.new(0, 145,0, 145)
		Game.Image = "rbxassetid://" .. Icon

		UICorner_1.Parent = Game

		UIStroke_1.Parent = Game
		UIStroke_1.Thickness = 1

		if not value then
			Game.ImageColor3 = Color3.fromRGB(90,90,90)

			Title_1.Name = "Title"
			Title_1.Parent = Game
			Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
			Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Title_1.BackgroundTransparency = 1
			Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Title_1.BorderSizePixel = 0
			Title_1.Position = UDim2.new(0.5, 0,0.5, 0)
			Title_1.Size = UDim2.new(1, 0,0, 20)
			Title_1.Font = Enum.Font.FredokaOne
			Title_1.Text = "None"
			Title_1.TextColor3 = Color3.fromRGB(255,98,98)
			Title_1.TextSize = 18
			Title_1.TextStrokeTransparency = 0
			Title_1.TextWrapped = true
		end
	end

	function Game:Main()
		UIPageLayout_1:JumpTo(Add)
	end

	return Game
end

local Load = Packages:Init()
local _ENV = getgenv()

local IsTrashXeno = (function()
	return string.find(identifyexecutor(), "Xeno")
end)()

local Asset = (function()
	local self = { Game = {} }

	function self:New(ID, RE, Name)
		table.insert(self.Game, {
			ID = ID,
			Name = Name,
			Required = RE,
			Icon = nil,
			Available = if IsTrashXeno then false else true
		})
	end

	self:New(16732694052, { 'require', 'gethui' }, "Fisch")
	self:New(127742093697776, { 'require', 'gethui', 'fireproximityprompt' }, "Plant vs Brainrot")
	self:New(79546208627805, { 'require', 'gethui', 'fireproximityprompt', 'getsenv', 'getgc', 'setupvalue', 'info' }, "99 Night in the forest")

	function self:LoadAsset(ID)
		local success, info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, ID)
		
		if success and info then
			return info.IconImageAssetId
		end
		
		return nil
	end
	
	do
		for _, data in pairs(self.Game) do
			data.Icon = self:LoadAsset(data.ID)

			for _, func in pairs(data.Required) do
				if not _ENV[func] then
					data.Available = false
					break
				end
			end
		end
	end

	return self
end)()

for _, data in pairs(Asset.Game) do
	Load:Add(data.Icon, data.Available)
end

return Load:Main()
