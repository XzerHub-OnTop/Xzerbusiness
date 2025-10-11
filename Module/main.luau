local Module = (function(a, b)
	local _ENV = a

	_ENV.__Break = true

	local Configs = {}
	local Serialized = {}

	local Connections = _ENV.Connections or {} do
		_ENV.Connections = Connections

		for i = 1, #Connections do
			Connections[i]:Disconnect()
		end

		table.clear(Connections)
	end

	local Running = _ENV.Running or {} do
		_ENV.Running = Running

		for i = 1, #Running do
			task.cancel(Running[i])
		end

		table.clear(Running)
	end

	local RunningOption = {}
	local SignalOption = {}
	local Nets = {}

	_ENV.__Break = nil

	Serialized.html = function(text, color)
		if type(text) == "string" and typeof(color) == "Color3" then
			local r, g, b = math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255)

			return string.format('<font color="rgb(%d, %d, %d)">%s</font>', r, g, b, text)
		end

		return text
	end

	Serialized.Utility = (function()
		local self = {}

		function self:reference(obj)
			return cloneref and cloneref(game:GetService(obj))
		end

		function self:clone(Function)
			return clonefunction and clonefunction(Function)
		end

		return self
	end)()

	local RunService = Serialized.Utility:reference('RunService')
	local Lighting = Serialized.Utility:reference('Lighting')
	local TeleportService = Serialized.Utility:reference('TeleportService')
	local HttpService = Serialized.Utility:reference('HttpService')
	local Players = Serialized.Utility:reference('Players')
	local UserInputService = Serialized.Utility:reference('UserInputService')
	local VirtualUser = Serialized.Utility:reference('VirtualUser')

	function Serialized:NewThread(condition, interval, fn, custom)
		while condition do
			if _ENV.__Break then break end

			local Tick = tick()

			if fn then fn() end
			if custom and custom() then break end

			repeat
				RunService.Heartbeat:Wait()
			until tick() - Tick >= (interval or 0.1)
		end
	end

	function Serialized:NewConnection(Signal, Action)
		table.insert(SignalOption, {
			Signal = Signal,
			Action = Action or function()
				return nil
			end
		})
	end

	Serialized:NewConnection(b.Idled, function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)

	function Serialized:NewRunning(Function)
		table.insert(RunningOption, {
			Function = Function or function()
				return nil
			end
		})
	end

	function Serialized:CreateThread(Setting, _Delay, Call)
		Nets[Setting] = function(Value)
			self:NewThread(Value, _Delay or 0.1, Call, function()
				return not Value
			end)
		end
	end

	Serialized.Configs = (function()
		local self = {
			HttpService = Serialized.Utility:reference('HttpService'),
			Base = "XZER/configs",
		}

		local Folder = self.Base
		local Path = Folder .. "/" .. game.PlaceId .. ".json"

		function self.def(key, value)
			if Configs[key] == nil then
				Configs[key] = value
			end
		end

		function self:Save(index, value)
			if index ~= nil then
				Configs[index] = value
			end

			if not isfolder("XZER") then
				makefolder("XZER")
			end

			if not isfolder(Folder) then
				makefolder(Folder)
			end

			writefile(Path, self.HttpService:JSONEncode(Configs))
		end

		function self:Load()
			if not isfile(Path) then
				self:Save()
			end

			local Files = readfile(Path)
			return self.HttpService:JSONDecode(Files)
		end

		return self
	end)()

	Serialized.Thread = (function()
		local self = {}

		function self:Running()
			for _, v in pairs(RunningOption) do
				table.insert(Running, task.spawn(function()
					while task.wait(self.Smoothing and 0.25 or 0) do
						if _ENV.__Break then break end

						v.Function()
					end
				end))
			end
		end

		function self:Connections()
			for _, v in pairs(SignalOption) do
				table.insert(Connections, v['Signal']:Connect(v['Action']))
			end
		end

		function self:init()
			self:Running()
			self:Connections()
		end

		return self
	end)()


	Serialized.Components = (function()
		local self = {}

		local function GetSize()
			if UserInputService.KeyboardEnabled then
				return UDim2.new(0, 800, 0, 550)
			else
				return UDim2.new(0, 600, 0, 325)
			end
		end

		function self.new(Visualized)
			return Visualized.new({
				Title = "Xzer",
				Logo = 89020944660589,
				Size = GetSize(),
				Keybind = Enum.KeyCode.LeftShift,
			})
		end

		function self:Tabs(Window, Title, Icon)
			return Window:Add({
				Title = Title,
				Icon = Icon
			})
		end

		function self:PageTitle(Tabs, Title, Desc)
			return Tabs:PageTitle({
				Title = Title,
				Desc = Desc
			})
		end

		function self:Button(Section, Title, Desc, Call, DisbleLine)
			return Section:Button({
				Title = Title,
				Desc = Desc,
				Call = Call,
				DisbleLine = DisbleLine,
			})
		end

		function self:Toggle(Section, Title, Desc, Setting, Call, DisbleLine)
			local Thread = nil

			return Section:Toggle({
				Title = Title,
				Desc = Desc,
				Value = Configs[Setting],
				DisbleLine = DisbleLine,
				Call = function(v)
					Configs[Setting] = v
					Serialized.Configs:Save(Setting, v)

					if v then
						Thread = task.spawn(function()
							if Nets[Setting] then
								Nets[Setting](Configs[Setting])
							end
						end)
					else
						if Thread then
							task.cancel(Thread)
						end
					end

					if Call then
						Call(v)
					end
				end,
			})
		end

		function self:Slider(Section, Title, Desc, Setting, Min, Max, Rounding, Call, DisbleLine)
			return Section:Slider({
				Title = Title,
				Desc = Desc,
				Value = Configs[Section],
				Min = Min,
				Max = Max,
				Rounding = Rounding,
				DisbleLine = DisbleLine,
				Call = function(v)
					Configs[Setting] = v
					Serialized.Configs:Save(Setting, v)

					if Call then
						Call(v)
					end
				end,
			})
		end

		function self:Textfield(Section, Title, Desc, Setting, Call, DisbleLine)
			return Section:Textfield({
				Title = Title,
				Desc = Desc,
				Value = Configs[Setting],
				Holder = "Waiting ...",
				DisbleLine = DisbleLine,
				Call = function(v)
					Configs[Setting] = v
					Serialized.Configs:Save(Setting, v)

					if Call then
						Call(v)
					end
				end,
			})
		end

		function self:Enum(Section, Title, Desc, Enums, Call, DisbleLine)
			return Section:Enum({
				Title = Title,
				Desc = Desc,
				Key = Enums,
				Value = false,
				DisbleLine = DisbleLine,
				Call = Call,
			})
		end

		function self:List(Section, Title, Setting, List, Call, DisbleLine)
			return Section:List({
				Title = Title,
				List = List,
				Value = Configs[Setting],
				DisbleLine = DisbleLine,
				Call = function(v)
					Configs[Setting] = v
					Serialized.Configs:Save(Setting, v)

					if Call then
						Call(v)
					end
				end,
			})
		end

		function self:OnLeaving(Window)
			local PlaceId = game.PlaceId

			local Utils = (function()
				local selfs = {}

				function selfs:Reserval(cursor)
					local url = `https://games.roblox.com/v1/games/{PlaceId}/servers/Public?sortOrder=Asc&limit=100`

					if cursor then
						url ..= `&cursor={cursor}`
					end

					return HttpService:JSONDecode(game:HttpGet(url))
				end

				function selfs:Rejoin()
					if #Players:GetPlayers() <= 1 then
						b:Kick("\nRejoining")
						wait()

						return TeleportService:Teleport(PlaceId, b)
					end

					return TeleportService:TeleportToPlaceInstance(PlaceId, game.JobId, b)
				end

				function selfs:Server()
					local Server, Next

					return (function(a)
						repeat
							local Servers = selfs:Reserval(a)

							Server = Servers and Servers.data and Servers.data[1]
							Next = Servers and Servers.nextPageCursor
						until Server

						if not Server or not Server.id then return end
						return TeleportService:TeleportToPlaceInstance(PlaceId, Server.id, b)
					end)(Next)
				end

				function selfs:Join(id)
					return TeleportService:TeleportToPlaceInstance(PlaceId, id, b)
				end

				return selfs
			end)()

			local Misc = self:Tabs(Window, "Miscellaneous", 125928820284709) do
				self:PageTitle(Misc, "Configuration", "Configuration Manager") do
					local _1 = Misc.new()

					Window:SetEnum(Enum.KeyCode.LeftControl)
					self:Enum(_1, "Keybind", "Set keybind to [ on/off ] Window(UI)", Enum.KeyCode.LeftShift, function(key, value)
						Window:SetEnum(key)
					end)

					self:Button(_1, "Remove Workspace", "Remove your current save configs files.", function()
						pcall(delfile, "XZER")
					end, true)
				end

				self:PageTitle(Misc, "Performance", "Performance Controller") do
					local _1 = Misc.new()

					self:Toggle(_1, "White Screen", "Enabled white screen to stop render and boost performance", "White Screen", function(v)
						RunService:Set3dRenderingEnabled(if v then false else true)
					end)

					self:Button(_1, "Low Graphic Quality", "Enable low graphics to improve performance.", function()
						print('Boosted')

						local Terrain = workspace:FindFirstChildOfClass('Terrain') do
							Terrain.WaterWaveSize = 0
							Terrain.WaterWaveSpeed = 0
							Terrain.WaterReflectance = 0
							Terrain.WaterTransparency = 0
							game.Lighting.GlobalShadows = false
							game.Lighting.FogEnd = 9e9
							settings().Rendering.QualityLevel = 1
						end

						for _, v in game:GetDescendants() do
							if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
								v.Material = "Plastic"
								v.Reflectance = 0
							elseif v:IsA("Decal") then
								v.Transparency = 1
							elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
								v.Lifetime = NumberRange.new(0)
							elseif v:IsA("Explosion") then
								v.BlastPressure = 1
								v.BlastRadius = 1
							end
						end
					end, true)
				end

				self:PageTitle(Misc, "Server", "Server Controller") do
					local _1 = Misc.new()

					Serialized.Configs.def('JobId', "N/A")

					self:Textfield(_1, "JobId", "Paste jobId here", "JobId")

					self:Button(_1, "Join", "Join the server using the JobId provided.", function()
						Utils:Join(Configs['JobId'])
					end)

					self:Button(_1, "Rejoin", "Reconnect to your current server.", function()
						Utils:Rejoin()
					end)

					self:Button(_1, "Clipboard JobId", tostring(game.JobId), function()
						setclipboard(tostring(game.JobId))
					end)

					self:Button(_1, "Change Server", "Find a new one to join.", function()
						Utils:Server()
					end, true)
				end
			end

			Serialized.Thread:init()

			return Misc
		end

		return self
	end)()

	Configs = Serialized.Configs:Load()
	Serialized.Config = Configs

	return Serialized
end)(getgenv(), game:GetService('Players').LocalPlayer)

return Module
