--[[
    VORTEX UI - PROFESYONEL VERSİYON
    Temiz, minimalist ve hatasız tasarım
]]

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Utility
local function Create(className, props)
    local obj = Instance.new(className)
    for prop, val in pairs(props) do
        if prop ~= "Parent" then
            obj[prop] = val
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function Tween(obj, props, duration, easing)
    local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.2, easing or Enum.EasingStyle.Quart), props)
    tween:Play()
    return tween
end

-- Renk Paleti
local Colors = {
    Background = Color3.fromRGB(20, 20, 25),
    Container = Color3.fromRGB(30, 30, 40),
    Element = Color3.fromRGB(40, 40, 55),
    Border = Color3.fromRGB(60, 60, 80),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(180, 180, 200),
    Accent = Color3.fromRGB(0, 150, 255),
    Success = Color3.fromRGB(0, 200, 100),
    Error = Color3.fromRGB(255, 80, 80),
    Warning = Color3.fromRGB(255, 180, 50)
}

-- V Logosu
local function CreateVLogo(parent, size)
    local container = Create("Frame", {
        Parent = parent,
        Name = "VLogo",
        BackgroundTransparency = 1,
        Size = size or UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5)
    })
    
    -- V şekli
    local left = Create("Frame", {
        Parent = container,
        BackgroundColor3 = Colors.Accent,
        Size = UDim2.new(0, 3, 0.8, 0),
        Position = UDim2.new(0.3, 0, 0.1, 0),
        Rotation = -25
    })
    
    local right = Create("Frame", {
        Parent = container,
        BackgroundColor3 = Colors.Accent,
        Size = UDim2.new(0, 3, 0.8, 0),
        Position = UDim2.new(0.7, 0, 0.1, 0),
        Rotation = 25
    })
    
    Create("UICorner", {Parent = left, CornerRadius = UDim.new(1, 0)})
    Create("UICorner", {Parent = right, CornerRadius = UDim.new(1, 0)})
    
    return container
end

-- Vortex UI
local Vortex = {}

function Vortex:CreateWindow(options)
    options = options or {}
    
    local screenGui = Create("ScreenGui", {
        Parent = CoreGui,
        Name = "VortexUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    -- Loading Screen
    local loading = Create("Frame", {
        Parent = screenGui,
        Name = "Loading",
        BackgroundColor3 = Colors.Background,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 1000
    })
    
    local loadingContent = Create("Frame", {
        Parent = loading,
        BackgroundColor3 = Colors.Container,
        Size = UDim2.new(0, 300, 0, 150),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5)
    })
    
    Create("UICorner", {Parent = loadingContent, CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", {Parent = loadingContent, Color = Colors.Border, Thickness = 2})
    
    -- Loading logosu
    local loadingLogo = CreateVLogo(loadingContent, UDim2.new(0, 50, 0, 50))
    loadingLogo.Position = UDim2.new(0.5, 0, 0.3, 0)
    loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Loading yazısı
    Create("TextLabel", {
        Parent = loadingContent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.6, 0),
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.GothamSemibold,
        Text = "VORTEX UI",
        TextColor3 = Colors.Text,
        TextSize = 20
    })
    
    Create("TextLabel", {
        Parent = loadingContent,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.75, 0),
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
    
    -- Main UI (500x400)
    local main = Create("Frame", {
        Parent = screenGui,
        Name = "Main",
        BackgroundColor3 = Colors.Background,
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = false
    })
    
    Create("UICorner", {Parent = main, CornerRadius = UDim.new(0, 8)})
    Create("UIStroke", {Parent = main, Color = Colors.Border, Thickness = 2})
    
    -- Header
    local header = Create("Frame", {
        Parent = main,
        Name = "Header",
        BackgroundColor3 = Colors.Container,
        Size = UDim2.new(1, 0, 0, 45)
    })
    
    Create("UICorner", {
        Parent = header,
        CornerRadius = UDim.new(0, 8)
    })
    
    -- V Logosu (UI Toggle)
    local logoButton = Create("TextButton", {
        Parent = header,
        Name = "LogoButton",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 45, 0, 45),
        Text = "",
        AutoButtonColor = false
    })
    
    local logo = CreateVLogo(logoButton, UDim2.new(0, 24, 0, 24))
    logo.Position = UDim2.new(0.5, 0, 0.5, 0)
    logo.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Başlık
    Create("TextLabel", {
        Parent = header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 0),
        Size = UDim2.new(1, -50, 1, 0),
        Font = Enum.Font.GothamSemibold,
        Text = options.Name or "Vortex UI",
        TextColor3 = Colors.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Content
    local content = Create("Frame", {
        Parent = main,
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 50),
        Size = UDim2.new(1, 0, 1, -50)
    })
    
    -- Tabs
    local tabs = Create("Frame", {
        Parent = content,
        Name = "Tabs",
        BackgroundColor3 = Colors.Container,
        Size = UDim2.new(0, 140, 1, 0)
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
        Padding = UDim.new(0, 5)
    })
    
    -- Main Content
    local mainContent = Create("Frame", {
        Parent = content,
        Name = "MainContent",
        BackgroundColor3 = Colors.Container,
        Size = UDim2.new(1, -150, 1, 0),
        Position = UDim2.new(0, 150, 0, 0)
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
        Padding = UDim.new(0, 8)
    })
    
    -- Loading animasyonu
    Tween(bar, {Size = UDim2.new(1, 0, 1, 0)}, 1.5)
    
    wait(1.8)
    Tween(loading, {BackgroundTransparency = 1}, 0.3)
    Tween(loadingContent, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    wait(0.4)
    loading:Destroy()
    
    -- UI aç
    main.Visible = true
    Tween(main, {Size = UDim2.new(0, 500, 0, 400)}, 0.4, Enum.EasingStyle.Back)
    
    -- UI Functions
    local window = {}
    
    -- Draggable
    local dragging = false
    local dragStart, startPos
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Logo Toggle
    local uiVisible = true
    logoButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        if uiVisible then
            Tween(main, {Size = UDim2.new(0, 500, 0, 400)}, 0.3)
        else
            Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        end
    end)
    
    -- UI Toggle Key
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiVisible = not uiVisible
            if uiVisible then
                Tween(main, {Size = UDim2.new(0, 500, 0, 400)}, 0.3)
            else
                Tween(main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
            end
        end
    end)
    
    -- Tab System
    window.Tabs = {}
    window.CurrentTab = nil
    
    function window:CreateTab(name)
        local tab = {}
        
        -- Tab Button
        local tabBtn = Create("TextButton", {
            Parent = tabList,
            Name = name .. "Tab",
            BackgroundColor3 = Colors.Element,
            Size = UDim2.new(1, 0, 0, 36),
            Font = Enum.Font.Gotham,
            Text = name,
            TextColor3 = Colors.SubText,
            TextSize = 14,
            AutoButtonColor = false
        })
        
        Create("UICorner", {Parent = tabBtn, CornerRadius = UDim.new(0, 6)})
        
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
            Padding = UDim.new(0, 8)
        })
        
        -- Tab Selection
        local function SelectTab()
            if window.CurrentTab then
                Tween(window.CurrentTab.Button, {
                    BackgroundColor3 = Colors.Element,
                    TextColor3 = Colors.SubText
                }, 0.2)
                window.CurrentTab.Content.Visible = false
            end
            
            window.CurrentTab = tab
            Tween(tabBtn, {
                BackgroundColor3 = Colors.Accent,
                TextColor3 = Colors.Text
            }, 0.2)
            tabContent.Visible = true
        end
        
        tabBtn.MouseButton1Click:Connect(SelectTab)
        
        -- Auto-select first tab
        if #tabList:GetChildren() == 1 then
            SelectTab()
        end
        
        tab.Button = tabBtn
        tab.Content = tabContent
        
        -- Element Functions
        function tab:CreateButton(options)
            options = options or {}
            local name = options.Name or "Button"
            local callback = options.Callback or function() end
            
            local btnFrame = Create("Frame", {
                Parent = tabContent,
                Name = name .. "Button",
                BackgroundColor3 = Colors.Element,
                Size = UDim2.new(1, 0, 0, 40)
            })
            
            Create("UICorner", {Parent = btnFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = btnFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = btnFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -24, 1, 0),
                Font = Enum.Font.Gotham,
                Text = name,
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
                Tween(btnFrame, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}, 0.2)
            end)
            
            click.MouseLeave:Connect(function()
                Tween(btnFrame, {BackgroundColor3 = Colors.Element}, 0.2)
            end)
            
            click.MouseButton1Click:Connect(function()
                Tween(btnFrame, {Size = UDim2.new(0.98, 0, 0, 38)}, 0.1)
                wait(0.1)
                Tween(btnFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.1)
                callback()
            end)
            
            return {
                SetText = function(text)
                    label.Text = text
                end
            }
        end
        
        function tab:CreateToggle(options)
            options = options or {}
            local name = options.Name or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local value = defaultValue
            
            local toggleFrame = Create("Frame", {
                Parent = tabContent,
                Name = name .. "Toggle",
                BackgroundColor3 = Colors.Element,
                Size = UDim2.new(1, 0, 0, 40)
            })
            
            Create("UICorner", {Parent = toggleFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = toggleFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = toggleFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -70, 1, 0),
                Font = Enum.Font.Gotham,
                Text = name,
                TextColor3 = Colors.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local switch = Create("Frame", {
                Parent = toggleFrame,
                Name = "Switch",
                BackgroundColor3 = value and Colors.Accent or Colors.Element,
                Size = UDim2.new(0, 50, 0, 24),
                Position = UDim2.new(1, -62, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
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
            
            local function Update()
                if value then
                    Tween(switch, {BackgroundColor3 = Colors.Accent}, 0.2)
                    Tween(circle, {Position = UDim2.new(1, -20, 0.5, 0)}, 0.2)
                else
                    Tween(switch, {BackgroundColor3 = Colors.Element}, 0.2)
                    Tween(circle, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.2)
                end
                callback(value)
            end
            
            click.MouseButton1Click:Connect(function()
                value = not value
                Update()
            end)
            
            Update()
            
            return {
                Set = function(val)
                    value = val
                    Update()
                end,
                Get = function()
                    return value
                end
            }
        end
        
        function tab:CreateSlider(options)
            options = options or {}
            local name = options.Name or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or min
            local callback = options.Callback or function() end
            
            local value = default
            
            local sliderFrame = Create("Frame", {
                Parent = tabContent,
                Name = name .. "Slider",
                BackgroundColor3 = Colors.Element,
                Size = UDim2.new(1, 0, 0, 60)
            })
            
            Create("UICorner", {Parent = sliderFrame, CornerRadius = UDim.new(0, 6)})
            Create("UIStroke", {Parent = sliderFrame, Color = Colors.Border, Thickness = 1})
            
            local label = Create("TextLabel", {
                Parent = sliderFrame,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 12, 0, 8),
                Size = UDim2.new(1, -24, 0, 18),
                Font = Enum.Font.Gotham,
                Text = name,
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
                Get = function()
                    return value
                end
            }
        end
        
        function tab:CreateLabel(text)
            local labelFrame = Create("Frame", {
                Parent = tabContent,
                BackgroundColor3 = Colors.Element,
                Size = UDim2.new(1, 0, 0, 30)
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
            
            return {
                SetText = function(newText)
                    labelFrame.TextLabel.Text = newText
                end
            }
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    function window:Destroy()
        screenGui:Destroy()
    end
    
    return window
end

return Vortex
