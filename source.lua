--[[
    VORTEX UI - Tam Fonksiyonel
    Bağımsız V Logosu + Modern UI
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Utility
local function Create(className, props)
    local obj = Instance.new(className)
    for prop, val in pairs(props) do
        if prop ~= "Parent" then obj[property] = value end
    end
    if props.Parent then obj.Parent = props.Parent end
    return obj
end

local function Tween(obj, props, duration, easing)
    return TweenService:Create(obj, TweenInfo.new(duration or 0.3, easing or Enum.EasingStyle.Quart), props)
end

-- Colors
local Colors = {
    Background = Color3.fromRGB(15, 15, 25),
    Container = Color3.fromRGB(25, 25, 35),
    Element = Color3.fromRGB(35, 35, 50),
    Border = Color3.fromRGB(60, 60, 80),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(180, 180, 200),
    Accent = Color3.fromRGB(0, 150, 255),
    Error = Color3.fromRGB(255, 80, 80),
    Success = Color3.fromRGB(0, 200, 100)
}

-- Vortex UI Library
local Vortex = {}

function Vortex:CreateWindow(options)
    options = options or {}
    
    -- Main ScreenGui
    local screenGui = Create("ScreenGui", {
        Parent = CoreGui,
        Name = "VortexUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Loading Screen
    local loadingFrame = Create("Frame", {
        Parent = screenGui,
        Name = "Loading",
        BackgroundColor3 = Colors.Background,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 1000
    })
    
    local loadingContent = Create("Frame", {
        Parent = loadingFrame,
        BackgroundColor3 = Colors.Container,
        Size = UDim2.new(0, 300, 0, 150),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5)
    })
    
    Create("UICorner", {Parent = loadingContent, CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", {Parent = loadingContent, Color = Colors.Border, Thickness = 2})
    
    -- Loading V Logo
    local loadingLogo = Create("TextButton", {
        Parent = loadingContent,
        Name = "LoadingLogo",
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0.5, 0, 0.3, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Colors.Accent,
        Text = "V",
        TextColor3 = Colors.Text,
        TextSize = 20,
        Font = Enum.Font.GothamBlack,
        AutoButtonColor = false
    })
    
    Create("UICorner", {Parent = loadingLogo, CornerRadius = UDim.new(1, 0)})
    Create("UIStroke", {Parent = loadingLogo, Color = Color3.fromRGB(200, 230, 255), Thickness = 1.6})
    
    Create("TextLabel", {
        Parent = loadingContent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.65, 0),
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = "VORTEX UI",
        TextColor3 = Colors.Text,
        TextSize = 20
    })
    
    Create("TextLabel", {
        Parent = loadingContent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.8, 0),
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.Gotham,
        Text = "Loading...",
        TextColor3 = Colors.SubText,
        TextSize = 14
    })
    
    -- Loading bar
    local barBg = Create("Frame", {
        Parent = loadingContent,
        BackgroundColor3 = Colors.Element,
        Position = UDim2.new(0.1, 0, 0.9, 0),
        Size = UDim2.new(0.8, 0, 0, 4)
    })
    
    Create("UICorner", {Parent = barBg, CornerRadius = UDim.new(1, 0)})
    
    local bar = Create("Frame", {
        Parent = barBg,
        BackgroundColor3 = Colors.Accent,
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    Create("UICorner", {Parent = bar, CornerRadius = UDim.new(1, 0)})
    
    -- 📌 BAĞIMSIZ V LOGO BUTONU
    local logoButton = Create("TextButton", {
        Parent = screenGui,
        Name = "VortexLogo",
        Size = UDim2.new(0, 47, 0, 42),
        Position = UDim2.new(0, 15, 0, 15),
        BackgroundColor3 = Colors.Accent,
        Text = "V",
        TextColor3 = Colors.Text,
        TextSize = 18,
        Font = Enum.Font.GothamBlack,
        AutoButtonColor = false,
        ZIndex = 100
    })
    
    Create("UICorner", {Parent = logoButton, CornerRadius = UDim.new(1, 0)})
    Create("UIStroke", {Parent = logoButton, Color = Color3.fromRGB(200, 230, 255), Thickness = 1.6})
    
    -- Logo glow
    local logoGlow = Create("Frame", {
        Parent = logoButton,
        BackgroundColor3 = Colors.Accent,
        BackgroundTransparency = 0.8,
        Size = UDim2.new(1.5, 0, 1.5, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 99
    })
    
    Create("UICorner", {Parent = logoGlow, CornerRadius = UDim.new(1, 0)})
    
    -- 🎯 ANA PENCERE
    local mainFrame = Create("Frame", {
        Parent = screenGui,
        Name = "MainFrame",
        Size = UDim2.new(0, 600, 0, 450),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Colors.Background,
        Visible = false
    })
    
    Create("UICorner", {Parent = mainFrame, CornerRadius = UDim.new(0, 10)})
    Create("UIStroke", {Parent = mainFrame, Color = Colors.Accent, Thickness = 2})
    
    -- Header
    local header = Create("Frame", {
        Parent = mainFrame,
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Colors.Container
    })
    
    Create("UICorner", {Parent = header, CornerRadius = UDim.new(0, 10)})
    
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = options.Name or "Vortex UI",
        TextColor3 = Colors.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Content Area
    local content = Create("Frame", {
        Parent = mainFrame,
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 55),
        Size = UDim2.new(1, 0, 1, -55)
    })
    
    -- Tabs
    local tabs = Create("Frame", {
        Parent = content,
        Name = "Tabs",
        Size = UDim2.new(0, 150, 1, 0),
        BackgroundColor3 = Colors.Container
    })
    
    Create("UICorner", {Parent = tabs, CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", {Parent = tabs, Color = Colors.Border, Thickness = 1})
    
    local tabList = Create("ScrollingFrame", {
        Parent = tabs,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, -20),
        Position = UDim2.new(0, 5, 0, 10),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Colors.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    Create("UIListLayout", {
        Parent = tabList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
    
    -- Main Content
    local mainContent = Create("Frame", {
        Parent = content,
        Name = "MainContent",
        Size = UDim2.new(1, -160, 1, 0),
        Position = UDim2.new(0, 160, 0, 0),
        BackgroundColor3 = Colors.Container
    })
    
    Create("UICorner", {Parent = mainContent, CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", {Parent = mainContent, Color = Colors.Border, Thickness = 1})
    
    local contentScroll = Create("ScrollingFrame", {
        Parent = mainContent,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Colors.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    Create("UIListLayout", {
        Parent = contentScroll,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    -- Loading animation
    Tween(bar, {Size = UDim2.new(1, 0, 1, 0)}, 2):Play()
    
    wait(2.2)
    
    Tween(loadingFrame, {BackgroundTransparency = 1}, 0.3):Play()
    Tween(loadingContent, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
    wait(0.4)
    loadingFrame:Destroy()
    
    -- Logo glow animation
    coroutine.wrap(function()
        while logoButton and logoButton.Parent do
            Tween(logoGlow, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 0.7}, 1.5):Play()
            wait(1.5)
            Tween(logoGlow, {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 0.8}, 1.5):Play()
            wait(1.5)
        end
    end)()
    
    -- Logo hover
    logoButton.MouseEnter:Connect(function()
        Tween(logoButton, {Size = UDim2.new(0, 50, 0, 45), BackgroundColor3 = Color3.fromRGB(0, 170, 255)}, 0.2):Play()
    end)
    
    logoButton.MouseLeave:Connect(function()
        Tween(logoButton, {Size = UDim2.new(0, 47, 0, 42), BackgroundColor3 = Colors.Accent}, 0.2):Play()
    end)
    
    -- UI Toggle with Logo
    local uiVisible = false
    
    logoButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        
        if uiVisible then
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            Tween(mainFrame, {Size = UDim2.new(0, 600, 0, 450)}, 0.4, Enum.EasingStyle.Back):Play()
            Tween(logoButton, {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}, 0.3):Play()
        else
            Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back):Play()
            Tween(logoButton, {BackgroundColor3 = Colors.Accent}, 0.3):Play()
            wait(0.35)
            mainFrame.Visible = false
        end
    end)
    
    -- Key toggle
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiVisible = not uiVisible
            
            if uiVisible then
                mainFrame.Visible = true
                Tween(mainFrame, {Size = UDim2.new(0, 600, 0, 450)}, 0.4, Enum.EasingStyle.Back):Play()
            else
                Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back):Play()
                wait(0.35)
                mainFrame.Visible = false
            end
        end
    end)
    
    -- Draggable Logo
    local draggingLogo = false
    local dragStartLogo, startPosLogo
    
    logoButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingLogo = true
            dragStartLogo = input.Position
            startPosLogo = logoButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then draggingLogo = false end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingLogo and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartLogo
            logoButton.Position = UDim2.new(
                startPosLogo.X.Scale, startPosLogo.X.Offset + delta.X,
                startPosLogo.Y.Scale, startPosLogo.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Draggable Window
    local draggingWindow = false
    local dragStartWindow, startPosWindow
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingWindow = true
            dragStartWindow = input.Position
            startPosWindow = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then draggingWindow = false end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingWindow and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartWindow
            mainFrame.Position = UDim2.new(
                startPosWindow.X.Scale, startPosWindow.X.Offset + delta.X,
                startPosWindow.Y.Scale, startPosWindow.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Window Functions
    local window = {}
    window.Tabs = {}
    window.CurrentTab = nil
    
    function window:CreateTab(name)
        local tab = {}
        
        -- Tab Button
        local tabButton = Create("TextButton", {
            Parent = tabList,
            Name = name .. "Tab",
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Colors.Element,
            Text = name,
            TextColor3 = Colors.SubText,
            TextSize = 14,
            Font = Enum.Font.Gotham,
            AutoButtonColor = false
        })
        
        Create("UICorner", {Parent = tabButton, CornerRadius = UDim.new(0, 6)})
        
        -- Tab Content
        local tabContent = Create("Frame", {
            Parent = contentScroll,
            Name = name .. "Content",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false
        })
        
        Create("UIListLayout", {
            Parent = tabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })
        
        -- Tab Selection
        local function SelectTab()
            if window.CurrentTab then
                window.CurrentTab.Button.BackgroundColor3 = Colors.Element
                window.CurrentTab.Button.TextColor3 = Colors.SubText
                window.CurrentTab.Content.Visible = false
            end
            
            window.CurrentTab = tab
            tabButton.BackgroundColor3 = Colors.Accent
            tabButton.TextColor3 = Colors.Text
            tabContent.Visible = true
        end
        
        tabButton.MouseButton1Click:Connect(SelectTab)
        
        if #tabList:GetChildren() == 1 then SelectTab() end
        
        tab.Button = tabButton
        tab.Content = tabContent
        
        -- Button
        function tab:CreateButton(options)
            options = options or {}
            local btnName = options.Name or "Button"
            local callback = options.Callback or function() end
            
            local btnFrame = Create("Frame", {
                Parent = tabContent,
                Name = btnName .. "Button",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Colors.Element
            })
            
            Create("UICorner", {Parent = btnFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = btnFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = btnFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -24, 1, 0),
                Font = Enum.Font.Gotham,
                Text = btnName,
                TextColor3 = Colors.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local click = Create("TextButton", {
                Parent = btnFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                AutoButtonColor = false
            })
            
            click.MouseEnter:Connect(function()
                Tween(btnFrame, {BackgroundColor3 = Color3.fromRGB(45, 45, 65)}, 0.2):Play()
            end)
            
            click.MouseLeave:Connect(function()
                Tween(btnFrame, {BackgroundColor3 = Colors.Element}, 0.2):Play()
            end)
            
            click.MouseButton1Click:Connect(function()
                Tween(btnFrame, {Size = UDim2.new(0.98, 0, 0, 38)}, 0.1):Play()
                wait(0.1)
                Tween(btnFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.1):Play()
                callback()
            end)
            
            return {SetText = function(text) label.Text = text end}
        end
        
        -- Toggle
        function tab:CreateToggle(options)
            options = options or {}
            local toggleName = options.Name or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local value = defaultValue
            
            local toggleFrame = Create("Frame", {
                Parent = tabContent,
                Name = toggleName .. "Toggle",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Colors.Element
            })
            
            Create("UICorner", {Parent = toggleFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = toggleFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -70, 1, 0),
                Font = Enum.Font.Gotham,
                Text = toggleName,
                TextColor3 = Colors.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local switch = Create("Frame", {
                Parent = toggleFrame,
                Name = "Switch",
                Size = UDim2.new(0, 50, 0, 24),
                Position = UDim2.new(1, -62, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = value and Colors.Accent or Colors.Element
            })
            
            Create("UICorner", {Parent = switch, CornerRadius = UDim.new(1, 0)})
            Create("UIStroke", {Parent = switch, Color = Colors.Border, Thickness = 1})
            
            local circle = Create("Frame", {
                Parent = switch,
                BackgroundColor3 = Colors.Text,
                Size = UDim2.new(0, 18, 0, 18),
                Position = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            
            Create("UICorner", {Parent = circle, CornerRadius = UDim.new(1, 0)})
            
            local click = Create("TextButton", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                AutoButtonColor = false
            })
            
            local function UpdateToggle()
                if value then
                    Tween(switch, {BackgroundColor3 = Colors.Accent}, 0.2):Play()
                    Tween(circle, {Position = UDim2.new(1, -20, 0.5, 0)}, 0.2):Play()
                else
                    Tween(switch, {BackgroundColor3 = Colors.Element}, 0.2):Play()
                    Tween(circle, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.2):Play()
                end
                callback(value)
            end
            
            click.MouseButton1Click:Connect(function()
                value = not value
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                Set = function(val)
                    value = val
                    UpdateToggle()
                end,
                Get = function() return value end
            }
        end
        
        -- Slider
        function tab:CreateSlider(options)
            options = options or {}
            local sliderName = options.Name or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local defaultValue = options.Default or min
            local callback = options.Callback or function() end
            
            local value = defaultValue
            
            local sliderFrame = Create("Frame", {
                Parent = tabContent,
                Name = sliderName .. "Slider",
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundColor3 = Colors.Element
            })
            
            Create("UICorner", {Parent = sliderFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = sliderFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 8),
                Size = UDim2.new(0.5, -12, 0, 18),
                Font = Enum.Font.Gotham,
                Text = sliderName,
                TextColor3 = Colors.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local valueLabel = Create("TextLabel", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0, 8),
                Size = UDim2.new(0.5, -12, 0, 18),
                Font = Enum.Font.GothamSemibold,
                Text = tostring(value),
                TextColor3 = Colors.Accent,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            
            local barBg = Create("Frame", {
                Parent = sliderFrame,
                BackgroundColor3 = Colors.Container,
                Position = UDim2.new(0, 12, 0, 36),
                Size = UDim2.new(1, -24, 0, 6)
            })
            
            Create("UICorner", {Parent = barBg, CornerRadius = UDim.new(1, 0)})
            
            local fill = Create("Frame", {
                Parent = barBg,
                BackgroundColor3 = Colors.Accent,
                Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            })
            
            Create("UICorner", {Parent = fill, CornerRadius = UDim.new(1, 0)})
            
            local knob = Create("Frame", {
                Parent = barBg,
                BackgroundColor3 = Colors.Text,
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            
            Create("UICorner", {Parent = knob, CornerRadius = UDim.new(1, 0)})
            Create("UIStroke", {Parent = knob, Color = Colors.Accent, Thickness = 2})
            
            local dragging = false
            
            local function UpdateSlider(input)
                local pos = (input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X
                pos = math.clamp(pos, 0, 1)
                value = math.floor(min + (max - min) * pos)
                
                valueLabel.Text = tostring(value)
                fill.Size = UDim2.new(pos, 0, 1, 0)
                knob.Position = UDim2.new(pos, 0, 0.5, 0)
                
                callback(value)
            end
            
            barBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    UpdateSlider(input)
                end
            end)
            
            barBg.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    UpdateSlider(input)
                end
            end)
            
            return {
                Set = function(val)
                    value = math.clamp(val, min, max)
                    local pos = (value - min) / (max - min)
                    valueLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, 0, 0.5, 0)
                    callback(value)
                end,
                Get = function() return value end
            }
        end
        
        -- Label
        function tab:CreateLabel(text)
            local labelFrame = Create("Frame", {
                Parent = tabContent,
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundColor3 = Colors.Element
            })
            
            Create("UICorner", {Parent = labelFrame, CornerRadius = UDim.new(0, 6)})
            
            Create("TextLabel", {
                Parent = labelFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                Font = Enum.Font.Gotham,
                Text = text,
                TextColor3 = Colors.SubText,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            return {SetText = function(newText) labelFrame.TextLabel.Text = newText end}
        end
        
        -- Dropdown
        function tab:CreateDropdown(options)
            options = options or {}
            local dropdownName = options.Name or "Dropdown"
            local list = options.List or {"Option 1", "Option 2", "Option 3"}
            local default = options.Default or list[1]
            local callback = options.Callback or function() end
            
            local selected = default
            local open = false
            
            local dropdownFrame = Create("Frame", {
                Parent = tabContent,
                Name = dropdownName .. "Dropdown",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Colors.Element,
                ClipsDescendants = true
            })
            
            Create("UICorner", {Parent = dropdownFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = dropdownFrame, Color = Colors.Border, Thickness = 1})
            
            local header = Create("TextButton", {
                Parent = dropdownFrame,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false
            })
            
            local label = Create("TextLabel", {
                Parent = header,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(0.5, -12, 1, 0),
                Font = Enum.Font.Gotham,
                Text = dropdownName,
                TextColor3 = Colors.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local selectedLabel = Create("TextLabel", {
                Parent = header,
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0, 0),
                Size = UDim2.new(0.5, -35, 1, 0),
                Font = Enum.Font.Gotham,
                Text = selected,
                TextColor3 = Colors.SubText,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            
            local arrow = Create("TextLabel", {
                Parent = header,
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -30, 0, 0),
                Size = UDim2.new(0, 20, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = "▼",
                TextColor3 = Colors.SubText,
                TextSize = 12
            })
            
            local optionsFrame = Create("Frame", {
                Parent = dropdownFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 8, 0, 46),
                Size = UDim2.new(1, -16, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            Create("UIListLayout", {
                Parent = optionsFrame,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 4)
            })
            
            local function CreateOption(option)
                local optionBtn = Create("TextButton", {
                    Parent = optionsFrame,
                    Name = option,
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = Colors.Container,
                    Text = option,
                    TextColor3 = Colors.SubText,
                    TextSize = 13,
                    Font = Enum.Font.Gotham,
                    AutoButtonColor = false
                })
                
                Create("UICorner", {Parent = optionBtn, CornerRadius = UDim.new(0, 4)})
                
                optionBtn.MouseButton1Click:Connect(function()
                    selected = option
                    selectedLabel.Text = option
                    callback(option)
                    
                    for _, child in pairs(optionsFrame:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.BackgroundColor3 = Colors.Container
                            child.TextColor3 = Colors.SubText
                        end
                    end
                    
                    optionBtn.BackgroundColor3 = Colors.Accent
                    optionBtn.TextColor3 = Colors.Text
                end)
            end
            
            for _, option in ipairs(list) do
                CreateOption(option)
            end
            
            header.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 40 + #list * 36 + 8)}, 0.3):Play()
                    Tween(arrow, {Rotation = 180}, 0.3):Play()
                else
                    Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.3):Play()
                    Tween(arrow, {Rotation = 0}, 0.3):Play()
                end
            end)
            
            return {
                Set = function(option)
                    selected = option
                    selectedLabel.Text = option
                    callback(option)
                end,
                Get = function() return selected end
            }
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    function window:Destroy()
        screenGui:Destroy()
    end
    
    function window:Notify(title, message, duration)
        duration = duration or 5
        
        local notifyFrame = Create("Frame", {
            Parent = screenGui,
            Name = "Notification",
            Size = UDim2.new(0, 300, 0, 0),
            Position = UDim2.new(1, -320, 0, 20),
            BackgroundColor3 = Colors.Container,
            AutomaticSize = Enum.AutomaticSize.Y,
            ClipsDescendants = true
        })
        
        Create("UICorner", {Parent = notifyFrame, CornerRadius = UDim.new(0, 8)})
        Create("UIStroke", {Parent = notifyFrame, Color = Colors.Accent, Thickness = 1})
        
        Create("TextLabel", {
            Parent = notifyFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 12),
            Size = UDim2.new(1, -24, 0, 20),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = Colors.Text,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        Create("TextLabel", {
            Parent = notifyFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 12, 0, 38),
            Size = UDim2.new(1, -24, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = Enum.Font.Gotham,
            Text = message,
            TextColor3 = Colors.SubText,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })
        
        Tween(notifyFrame, {Size = UDim2.new(0, 300, 0, notifyFrame.AbsoluteSize.Y)}, 0.3):Play()
        
        task.delay(duration, function()
            if notifyFrame and notifyFrame.Parent then
                Tween(notifyFrame, {Size = UDim2.new(0, 300, 0, 0)}, 0.3):Play()
                wait(0.35)
                notifyFrame:Destroy()
            end
        end)
    end
    
    return window
end

return Vortex
