--[[
    VORTEX UI - ÖZELLEŞTİRİLMİŞ VERSİYON
    Özellikler:
    1. V Logosu - UI açma/kapama butonu
    2. Loading ekranı "Vortex UI Loading" yazılı
    3. Frame boyutu %20 küçültüldü
    4. Modern tasarım, mavi-siyah tonlar
    5. Marka: Vortex UI
]]

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Utility Functions
local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- V Logosu Renkleri
local VLogoColors = {
    LightBlue = Color3.fromRGB(100, 149, 237),    -- Açık Mavi (CornflowerBlue)
    MediumBlue = Color3.fromRGB(65, 105, 225),    -- Orta Mavi (RoyalBlue)
    DarkBlue = Color3.fromRGB(25, 25, 112),       -- Koyu Mavi (MidnightBlue)
    AccentBlue = Color3.fromRGB(30, 144, 255),    -- Vurgu Mavisi (DodgerBlue)
    NeonBlue = Color3.fromRGB(0, 191, 255)        -- Neon Mavi (DeepSkyBlue)
}

-- Tema Sistemi
local Themes = {
    Vortex = {
        Background = Color3.fromRGB(15, 15, 25),
        Foreground = Color3.fromRGB(25, 25, 35),
        Container = Color3.fromRGB(35, 35, 45),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 200),
        Accent = VLogoColors.NeonBlue,
        Secondary = VLogoColors.MediumBlue,
        Border = Color3.fromRGB(50, 50, 70),
        Success = Color3.fromRGB(85, 255, 85),
        Error = Color3.fromRGB(255, 85, 85),
        Warning = Color3.fromRGB(255, 255, 85),
        LogoPrimary = VLogoColors.NeonBlue,
        LogoSecondary = VLogoColors.MediumBlue,
        LogoAccent = VLogoColors.DarkBlue,
        GradientStart = VLogoColors.NeonBlue,
        GradientEnd = VLogoColors.DarkBlue
    }
}

-- V Logosu Oluşturma Fonksiyonu (Tıklanabilir)
local function CreateVLogo(parent, theme, size, isButton)
    local logoContainer = CreateInstance("Frame", {
        Name = "VortexLogo",
        Parent = parent,
        BackgroundTransparency = 1,
        Size = size or UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5)
    })
    
    -- Logo butonu (arka plan)
    local logoButton = nil
    if isButton then
        logoButton = CreateInstance("TextButton", {
            Name = "LogoButton",
            Parent = logoContainer,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Text = "",
            AutoButtonColor = false
        })
    end
    
    -- V şekli için üçgenler
    local leftTriangle = CreateInstance("Frame", {
        Name = "LeftTriangle",
        Parent = logoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        Position = UDim2.new(0.3, 0, 0.1, 0),
        Size = UDim2.new(0, 4, 0.8, 0),
        Rotation = -45
    })
    
    local rightTriangle = CreateInstance("Frame", {
        Name = "RightTriangle",
        Parent = logoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        Position = UDim2.new(0.7, 0, 0.1, 0),
        Size = UDim2.new(0, 4, 0.8, 0),
        Rotation = 45
    })
    
    -- Gradient efekti
    local leftGradient = CreateInstance("UIGradient", {
        Parent = leftTriangle,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, theme.LogoPrimary),
            ColorSequenceKeypoint.new(1, theme.LogoSecondary)
        }),
        Rotation = 90
    })
    
    local rightGradient = CreateInstance("UIGradient", {
        Parent = rightTriangle,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, theme.LogoPrimary),
            ColorSequenceKeypoint.new(1, theme.LogoSecondary)
        }),
        Rotation = 90
    })
    
    -- Logo parıltısı
    local glow = CreateInstance("Frame", {
        Name = "LogoGlow",
        Parent = logoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        BackgroundTransparency = 0.9,
        Size = UDim2.new(2, 0, 2, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = -1
    })
    
    CreateInstance("UICorner", {
        Parent = glow,
        CornerRadius = UDim.new(1, 0)
    })
    
    -- Logo animasyonu
    coroutine.wrap(function()
        while logoContainer and logoContainer.Parent do
            Tween(glow, {Size = UDim2.new(2.5, 0, 2.5, 0), BackgroundTransparency = 0.7}, 1.5)
            wait(1.5)
            Tween(glow, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 0.9}, 1.5)
            wait(1.5)
        end
    end)()
    
    return logoContainer, logoButton
end

-- Vortex UI Library
local Vortex = {}

function Vortex:CreateWindow(options)
    options = options or {}
    
    local windowName = options.Name or "Vortex UI"
    local theme = Themes.Vortex
    local isUIVisible = true
    
    -- Main Container
    local screenGui = CreateInstance("ScreenGui", {
        Parent = CoreGui,
        Name = "VortexUIMain",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999
    })
    
    -- LOADING EKRANI
    local loadingFrame = CreateInstance("Frame", {
        Parent = screenGui,
        Name = "LoadingScreen",
        BackgroundColor3 = Color3.fromRGB(10, 10, 15),
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 0,
        ZIndex = 1000
    })
    
    local loadingContainer = CreateInstance("Frame", {
        Parent = loadingFrame,
        Name = "LoadingContainer",
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 400, 0, 200),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5)
    })
    
    CreateInstance("UICorner", {
        Parent = loadingContainer,
        CornerRadius = UDim.new(0, 16)
    })
    
    CreateInstance("UIStroke", {
        Parent = loadingContainer,
        Color = theme.Accent,
        Thickness = 2,
        Transparency = 0.5
    })
    
    -- Loading logosu
    local loadingLogo, _ = CreateVLogo(loadingContainer, theme, UDim2.new(0, 80, 0, 80))
    loadingLogo.Position = UDim2.new(0.5, 0, 0.3, 0)
    loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Loading yazısı
    local loadingText = CreateInstance("TextLabel", {
        Parent = loadingContainer,
        Name = "LoadingText",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.7, 0),
        Size = UDim2.new(1, 0, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "VORTEX UI LOADING",
        TextColor3 = theme.Text,
        TextSize = 24,
        TextTransparency = 0
    })
    
    local loadingDots = CreateInstance("TextLabel", {
        Parent = loadingContainer,
        Name = "LoadingDots",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.85, 0),
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.Gotham,
        Text = "",
        TextColor3 = theme.Accent,
        TextSize = 18,
        TextTransparency = 0
    })
    
    -- Loading animasyonu
    coroutine.wrap(function()
        local dots = {".", "..", "...", "...."}
        local dotIndex = 1
        while loadingDots and loadingDots.Parent do
            loadingDots.Text = dots[dotIndex]
            dotIndex = dotIndex + 1
            if dotIndex > #dots then dotIndex = 1 end
            wait(0.5)
        end
    end)()
    
    -- Loading bar
    local loadingBarBg = CreateInstance("Frame", {
        Parent = loadingContainer,
        Name = "LoadingBarBg",
        BackgroundColor3 = theme.Container,
        Position = UDim2.new(0.1, 0, 0.9, 0),
        Size = UDim2.new(0.8, 0, 0, 4)
    })
    
    CreateInstance("UICorner", {
        Parent = loadingBarBg,
        CornerRadius = UDim.new(1, 0)
    })
    
    local loadingBar = CreateInstance("Frame", {
        Parent = loadingBarBg,
        Name = "LoadingBar",
        BackgroundColor3 = theme.Accent,
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    CreateInstance("UICorner", {
        Parent = loadingBar,
        CornerRadius = UDim.new(1, 0)
    })
    
    -- Main UI Frame (%20 DAHA KÜÇÜK)
    local mainFrame = CreateInstance("Frame", {
        Parent = screenGui,
        Name = "MainFrame",
        BackgroundColor3 = theme.Background,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 480, 0, 320),  -- Normal 600x400 idi, %20 küçültülmüş
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true,
        Visible = false
    })
    
    CreateInstance("UICorner", {
        Parent = mainFrame,
        CornerRadius = UDim.new(0, 14)
    })
    
    local mainStroke = CreateInstance("UIStroke", {
        Parent = mainFrame,
        Color = theme.Accent,
        Thickness = 2,
        Transparency = 0.3
    })
    
    -- Glow efekti
    local glowEffect = CreateInstance("ImageLabel", {
        Parent = mainFrame,
        Name = "GlowEffect",
        BackgroundTransparency = 1,
        Image = "rbxassetid://8992230670",
        ImageColor3 = theme.Accent,
        ImageTransparency = 0.9,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(256, 256, 256, 256),
        Size = UDim2.new(1, 60, 1, 60),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = -1
    })
    
    -- Header
    local header = CreateInstance("Frame", {
        Parent = mainFrame,
        Name = "Header",
        BackgroundColor3 = theme.Foreground,
        Size = UDim2.new(1, 0, 0, 50),
        Position = UDim2.new(0, 0, 0, 0)
    })
    
    CreateInstance("UICorner", {
        Parent = header,
        CornerRadius = UDim.new(0, 14)
    })
    
    -- V Logosu (TIKLANABİLİR - UI Aç/Kapa)
    local logoContainer, logoButton = CreateVLogo(header, theme, UDim2.new(0, 36, 0, 36), true)
    logoContainer.Position = UDim2.new(0, 15, 0.5, 0)
    logoContainer.AnchorPoint = Vector2.new(0, 0.5)
    
    -- Başlık
    local titleLabel = CreateInstance("TextLabel", {
        Parent = header,
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 60, 0, 0),
        Size = UDim2.new(1, -60, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = theme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Logo tıklama efekti
    if logoButton then
        logoButton.MouseEnter:Connect(function()
            Tween(logoContainer, {Size = UDim2.new(0, 38, 0, 38)}, 0.2)
        end)
        
        logoButton.MouseLeave:Connect(function()
            Tween(logoContainer, {Size = UDim2.new(0, 36, 0, 36)}, 0.2)
        end)
        
        logoButton.MouseButton1Click:Connect(function()
            isUIVisible = not isUIVisible
            if isUIVisible then
                Tween(mainFrame, {Size = UDim2.new(0, 480, 0, 320)}, 0.3, Enum.EasingStyle.Back)
                Tween(mainFrame, {BackgroundTransparency = 0}, 0.3)
            else
                Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
                Tween(mainFrame, {BackgroundTransparency = 1}, 0.3)
            end
        end)
    end
    
    -- Content Area
    local contentFrame = CreateInstance("Frame", {
        Parent = mainFrame,
        Name = "Content",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(1, 0, 1, -60)
    })
    
    -- Tab Container
    local tabContainer = CreateInstance("Frame", {
        Parent = contentFrame,
        Name = "TabContainer",
        BackgroundColor3 = theme.Foreground,
        Size = UDim2.new(0, 140, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    })
    
    CreateInstance("UICorner", {
        Parent = tabContainer,
        CornerRadius = UDim.new(0, 12)
    })
    
    CreateInstance("UIStroke", {
        Parent = tabContainer,
        Color = theme.Border,
        Thickness = 1
    })
    
    local tabList = CreateInstance("ScrollingFrame", {
        Parent = tabContainer,
        Name = "TabList",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, -20),
        Position = UDim2.new(0, 5, 0, 10),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    local tabLayout = CreateInstance("UIListLayout", {
        Parent = tabList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    -- Main Content Area
    local mainContent = CreateInstance("Frame", {
        Parent = contentFrame,
        Name = "MainContent",
        BackgroundColor3 = theme.Foreground,
        Size = UDim2.new(1, -150, 1, 0),
        Position = UDim2.new(0, 150, 0, 0)
    })
    
    CreateInstance("UICorner", {
        Parent = mainContent,
        CornerRadius = UDim.new(0, 12)
    })
    
    CreateInstance("UIStroke", {
        Parent = mainContent,
        Color = theme.Border,
        Thickness = 1
    })
    
    local contentScroll = CreateInstance("ScrollingFrame", {
        Parent = mainContent,
        Name = "ContentScroll",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })
    
    local contentLayout = CreateInstance("UIListLayout", {
        Parent = contentScroll,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    -- Draggable Header
    local dragging = false
    local dragStart, startPos
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Loading animasyonu tamamlanıyor
    Tween(loadingBar, {Size = UDim2.new(1, 0, 1, 0)}, 2, Enum.EasingStyle.Quart)
    
    wait(2.2)
    
    -- Loading ekranını kapat
    Tween(loadingContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.5, Enum.EasingStyle.Back)
    Tween(loadingContainer, {BackgroundTransparency = 1}, 0.5)
    Tween(loadingText, {TextTransparency = 1}, 0.5)
    Tween(loadingDots, {TextTransparency = 1}, 0.5)
    
    wait(0.6)
    loadingFrame:Destroy()
    
    -- Main UI'yi aç
    mainFrame.Visible = true
    Tween(mainFrame, {Size = UDim2.new(0, 480, 0, 320)}, 0.5, Enum.EasingStyle.Back)
    
    -- UI Fonksiyonları
    local windowFunctions = {}
    
    function windowFunctions:CreateTab(tabName)
        local tab = {}
        
        -- Tab Button
        local tabButton = CreateInstance("TextButton", {
            Parent = tabList,
            Name = tabName .. "Tab",
            BackgroundColor3 = theme.Container,
            BackgroundTransparency = 0.5,
            Size = UDim2.new(1, 0, 0, 40),
            Font = Enum.Font.GothamSemibold,
            Text = tabName,
            TextColor3 = theme.SubText,
            TextSize = 14,
            AutoButtonColor = false
        })
        
        CreateInstance("UICorner", {
            Parent = tabButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        CreateInstance("UIStroke", {
            Parent = tabButton,
            Color = theme.Border,
            Thickness = 1,
            Transparency = 0.5
        })
        
        -- Tab Content
        local tabContent = CreateInstance("Frame", {
            Parent = contentScroll,
            Name = tabName .. "Content",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false
        })
        
        local tabContentLayout = CreateInstance("UIListLayout", {
            Parent = tabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        
        -- Tab seçimi
        local function SelectTab()
            for _, child in pairs(contentScroll:GetChildren()) do
                if child:IsA("Frame") and child.Name:find("Content") then
                    child.Visible = false
                end
            end
            
            for _, child in pairs(tabList:GetChildren()) do
                if child:IsA("TextButton") then
                    Tween(child, {
                        BackgroundColor3 = theme.Container,
                        BackgroundTransparency = 0.5,
                        TextColor3 = theme.SubText
                    }, 0.2)
                end
            end
            
            tabContent.Visible = true
            Tween(tabButton, {
                BackgroundColor3 = theme.Accent,
                BackgroundTransparency = 0.2,
                TextColor3 = theme.Text
            }, 0.2)
        end
        
        tabButton.MouseButton1Click:Connect(SelectTab)
        
        -- İlk tab'ı seç
        if #tabList:GetChildren() == 1 then
            SelectTab()
        end
        
        -- UI Element Fonksiyonları
        function tab:CreateButton(buttonOptions)
            local buttonName = buttonOptions.Name or "Button"
            local callback = buttonOptions.Callback or function() end
            
            local buttonFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = buttonName .. "Button",
                BackgroundColor3 = theme.Container,
                BackgroundTransparency = 0.3,
                Size = UDim2.new(1, 0, 0, 40)
            })
            
            CreateInstance("UICorner", {
                Parent = buttonFrame,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateInstance("UIStroke", {
                Parent = buttonFrame,
                Color = theme.Border,
                Thickness = 1
            })
            
            local buttonLabel = CreateInstance("TextLabel", {
                Parent = buttonFrame,
                Name = "Label",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = buttonName,
                TextColor3 = theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local buttonIcon = CreateInstance("TextLabel", {
                Parent = buttonFrame,
                Name = "Icon",
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 30, 1, 0),
                Position = UDim2.new(1, -40, 0, 0),
                Font = Enum.Font.GothamBold,
                Text = "›",
                TextColor3 = theme.Accent,
                TextSize = 20
            })
            
            local buttonClick = CreateInstance("TextButton", {
                Parent = buttonFrame,
                Name = "ClickArea",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                AutoButtonColor = false
            })
            
            buttonClick.MouseEnter:Connect(function()
                Tween(buttonFrame, {BackgroundTransparency = 0.1}, 0.2)
                Tween(buttonIcon, {Position = UDim2.new(1, -35, 0, 0)}, 0.2)
            end)
            
            buttonClick.MouseLeave:Connect(function()
                Tween(buttonFrame, {BackgroundTransparency = 0.3}, 0.2)
                Tween(buttonIcon, {Position = UDim2.new(1, -40, 0, 0)}, 0.2)
            end)
            
            buttonClick.MouseButton1Click:Connect(function()
                Tween(buttonFrame, {Size = UDim2.new(0.98, 0, 0, 38)}, 0.1)
                wait(0.1)
                Tween(buttonFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.1)
                callback()
            end)
            
            return {
                SetText = function(text)
                    buttonLabel.Text = text
                end
            }
        end
        
        function tab:CreateToggle(toggleOptions)
            local toggleName = toggleOptions.Name or "Toggle"
            local defaultValue = toggleOptions.Default or false
            local callback = toggleOptions.Callback or function() end
            
            local toggleValue = defaultValue
            
            local toggleFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = toggleName .. "Toggle",
                BackgroundColor3 = theme.Container,
                BackgroundTransparency = 0.3,
                Size = UDim2.new(1, 0, 0, 40)
            })
            
            CreateInstance("UICorner", {
                Parent = toggleFrame,
                CornerRadius = UDim.new(0, 8)
            })
            
            CreateInstance("UIStroke", {
                Parent = toggleFrame,
                Color = theme.Border,
                Thickness = 1
            })
            
            local toggleLabel = CreateInstance("TextLabel", {
                Parent = toggleFrame,
                Name = "Label",
                BackgroundTransparency = 1,
                Size = UDim2.new(0.7, -10, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                Font = Enum.Font.GothamSemibold,
                Text = toggleName,
                TextColor3 = theme.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local toggleSwitch = CreateInstance("Frame", {
                Parent = toggleFrame,
                Name = "Switch",
                BackgroundColor3 = defaultValue and theme.Accent or theme.Container,
                BackgroundTransparency = defaultValue and 0.3 or 0.5,
                Size = UDim2.new(0, 50, 0, 24),
                Position = UDim2.new(1, -70, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            
            CreateInstance("UICorner", {
                Parent = toggleSwitch,
                CornerRadius = UDim.new(1, 0)
            })
            
            CreateInstance("UIStroke", {
                Parent = toggleSwitch,
                Color = theme.Border,
                Thickness = 1
            })
            
            local toggleCircle = CreateInstance("Frame", {
                Parent = toggleSwitch,
                Name = "Circle",
                BackgroundColor3 = theme.Text,
                Size = UDim2.new(0, 18, 0, 18),
                Position = defaultValue and UDim2.new(1, -22, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5)
            })
            
            CreateInstance("UICorner", {
                Parent = toggleCircle,
                CornerRadius = UDim.new(1, 0)
            })
            
            local toggleClick = CreateInstance("TextButton", {
                Parent = toggleFrame,
                Name = "ClickArea",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                AutoButtonColor = false
            })
            
            local function UpdateToggle()
                if toggleValue then
                    Tween(toggleSwitch, {BackgroundColor3 = theme.Accent, BackgroundTransparency = 0.3}, 0.2)
                    Tween(toggleCircle, {Position = UDim2.new(1, -22, 0.5, 0)}, 0.2)
                else
                    Tween(toggleSwitch, {BackgroundColor3 = theme.Container, BackgroundTransparency = 0.5}, 0.2)
                    Tween(toggleCircle, {Position = UDim2.new(0, 4, 0.5, 0)}, 0.2)
                end
                callback(toggleValue)
            end
            
            toggleClick.MouseButton1Click:Connect(function()
                toggleValue = not toggleValue
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                Set = function(value)
                    toggleValue = value
                    UpdateToggle()
                end,
                Get = function()
                    return toggleValue
                end
            }
        end
        
        return tab
    end
    
    -- UI Toggle Tuşu (Varsayılan: RightShift)
    local toggleKey = Enum.KeyCode.RightShift
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == toggleKey then
            isUIVisible = not isUIVisible
            if isUIVisible then
                Tween(mainFrame, {Size = UDim2.new(0, 480, 0, 320)}, 0.3, Enum.EasingStyle.Back)
                Tween(mainFrame, {BackgroundTransparency = 0}, 0.3)
            else
                Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
                Tween(mainFrame, {BackgroundTransparency = 1}, 0.3)
            end
        end
    end)
    
    return windowFunctions
end

return Vortex
