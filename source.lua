--[[
    Alexchad Ui Library MODIFIED VERSION
    Değişiklikler:
    1. Kontrol butonları: Küçültme (-) solda, Kapatma (X) sağda
    2. Bildirimler üstte (sağ üst köşe)
    3. Logo sistemi: "SHOW" yazısı + V logosu (mavi-siyah tonları)
]]

local AlexchadLibrary = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TextService = game:GetService("TextService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Get proper GUI parent
local function GetGuiParent()
    local success, result = pcall(function()
        if gethui then
            return gethui()
        elseif syn and syn.protect_gui then
            return CoreGui
        end
        return CoreGui
    end)
    return success and result or CoreGui
end

local GuiParent = GetGuiParent()

-- Clean up ALL existing blur effects
local function CleanupAllBlur()
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("BlurEffect") and effect.Name:find("Rayfield") then
            effect:Destroy()
        end
    end
end

-- ÖZEL V LOGO RENKLERİ (Mavi-Siyah tonları)
local LogoColors = {
    LightBlue = Color3.fromRGB(135, 206, 250),    -- Açık Mavi
    MediumBlue = Color3.fromRGB(30, 144, 255),    -- Orta Mavi
    DarkBlue = Color3.fromRGB(0, 0, 139),         -- Koyu Mavi
    Black = Color3.fromRGB(20, 20, 30),           -- Siyah
    AccentBlue = Color3.fromRGB(70, 130, 180)     -- Vurgu Mavisi
}

-- Theme Configuration (V logo renkleri entegre edilmiş)
local Themes = {
    Default = {
        Background = Color3.fromRGB(20, 20, 30),
        BackgroundTransparency = 0.15,
        Container = Color3.fromRGB(30, 30, 45),
        ContainerTransparency = 0.25,
        Element = Color3.fromRGB(40, 40, 60),
        ElementTransparency = 0.3,
        ElementHover = Color3.fromRGB(50, 50, 75),
        Accent = LogoColors.MediumBlue,  -- V logosunun mavisi
        AccentDark = LogoColors.DarkBlue,
        AccentGlow = LogoColors.LightBlue,
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 200),
        TextMuted = Color3.fromRGB(120, 120, 150),
        Border = Color3.fromRGB(80, 80, 120),
        BorderTransparency = 0.5,
        Success = Color3.fromRGB(80, 220, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Error = Color3.fromRGB(255, 80, 80),
        GradientStart = LogoColors.MediumBlue,
        GradientEnd = LogoColors.DarkBlue,
        LogoPrimary = LogoColors.LightBlue,
        LogoSecondary = LogoColors.MediumBlue,
        LogoAccent = LogoColors.DarkBlue
    },
    -- Diğer temalar aynı kalacak, sadece accent renkleri V logosu mavisiyle uyumlu
    Dark = {
        Background = Color3.fromRGB(10, 10, 15),
        BackgroundTransparency = 0.1,
        Container = Color3.fromRGB(18, 18, 25),
        ContainerTransparency = 0.2,
        Element = Color3.fromRGB(25, 25, 35),
        ElementTransparency = 0.25,
        ElementHover = Color3.fromRGB(35, 35, 50),
        Accent = LogoColors.MediumBlue,
        AccentDark = LogoColors.DarkBlue,
        AccentGlow = LogoColors.LightBlue,
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(160, 160, 180),
        TextMuted = Color3.fromRGB(100, 100, 130),
        Border = Color3.fromRGB(60, 60, 90),
        BorderTransparency = 0.6,
        Success = Color3.fromRGB(80, 220, 120),
        Warning = Color3.fromRGB(255, 180, 60),
        Error = Color3.fromRGB(255, 80, 80),
        GradientStart = LogoColors.MediumBlue,
        GradientEnd = Color3.fromRGB(15, 15, 25),
        LogoPrimary = LogoColors.LightBlue,
        LogoSecondary = LogoColors.MediumBlue,
        LogoAccent = LogoColors.DarkBlue
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 250),
        BackgroundTransparency = 0.1,
        Container = Color3.fromRGB(250, 250, 255),
        ContainerTransparency = 0.15,
        Element = Color3.fromRGB(235, 235, 245),
        ElementTransparency = 0.2,
        ElementHover = Color3.fromRGB(225, 225, 240),
        Accent = LogoColors.MediumBlue,
        AccentDark = LogoColors.DarkBlue,
        AccentGlow = LogoColors.LightBlue,
        Text = Color3.fromRGB(30, 30, 50),
        TextDark = Color3.fromRGB(80, 80, 110),
        TextMuted = Color3.fromRGB(130, 130, 160),
        Border = Color3.fromRGB(200, 200, 220),
        BorderTransparency = 0.3,
        Success = Color3.fromRGB(60, 180, 100),
        Warning = Color3.fromRGB(230, 160, 40),
        Error = Color3.fromRGB(220, 60, 60),
        GradientStart = Color3.fromRGB(255, 255, 255),
        GradientEnd = Color3.fromRGB(230, 230, 245),
        LogoPrimary = LogoColors.MediumBlue,
        LogoSecondary = LogoColors.DarkBlue,
        LogoAccent = LogoColors.LightBlue
    },
    Ocean = {
        Background = Color3.fromRGB(15, 25, 40),
        BackgroundTransparency = 0.15,
        Container = Color3.fromRGB(20, 35, 55),
        ContainerTransparency = 0.25,
        Element = Color3.fromRGB(25, 45, 70),
        ElementTransparency = 0.3,
        ElementHover = Color3.fromRGB(35, 55, 85),
        Accent = LogoColors.LightBlue,
        AccentDark = Color3.fromRGB(40, 150, 190),
        AccentGlow = Color3.fromRGB(90, 210, 250),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(170, 200, 220),
        TextMuted = Color3.fromRGB(120, 150, 180),
        Border = Color3.fromRGB(60, 100, 140),
        BorderTransparency = 0.5,
        Success = Color3.fromRGB(80, 220, 150),
        Warning = Color3.fromRGB(255, 190, 80),
        Error = Color3.fromRGB(255, 100, 100),
        GradientStart = Color3.fromRGB(40, 80, 120),
        GradientEnd = Color3.fromRGB(20, 40, 60),
        LogoPrimary = LogoColors.LightBlue,
        LogoSecondary = LogoColors.MediumBlue,
        LogoAccent = LogoColors.DarkBlue
    }
}

-- Utility Functions
local Utility = {}

function Utility:Create(instanceType, properties, children)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties or {}) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    for _, child in pairs(children or {}) do
        child.Parent = instance
    end
    if properties and properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

function Utility:Tween(instance, properties, duration, easingStyle, easingDirection)
    if not instance then return end
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quart,
        easingDirection or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function Utility:Ripple(button, theme, config)
    if not config.RippleEnabled then return end
    
    local ripple = Utility:Create("Frame", {
        Name = "Ripple",
        Parent = button,
        BackgroundColor3 = theme.AccentGlow,
        BackgroundTransparency = 0.6,
        BorderSizePixel = 0,
        Position = UDim2.new(0, Mouse.X - button.AbsolutePosition.X, 0, Mouse.Y - button.AbsolutePosition.Y),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = button.ZIndex + 5
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(1, 0) })
    })
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
    
    Utility:Tween(ripple, {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1
    }, config.RippleSpeed).Completed:Connect(function()
        ripple:Destroy()
    end)
end

function Utility:MakeDraggable(frame, handle, config)
    local dragging, dragInput, dragStart, startPos
    handle = handle or frame
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Utility:Tween(frame, {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }, config.AnimationSpeed * 0.5)
        end
    end)
end

-- V Logosu oluşturma fonksiyonu
function Utility:CreateVLogo(parent, theme, size)
    local LogoContainer = Utility:Create("Frame", {
        Name = "VLogo",
        Parent = parent,
        BackgroundTransparency = 1,
        Size = size or UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 10, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5)
    })
    
    -- V harfi şeklinde özel logo
    local LeftLine = Utility:Create("Frame", {
        Name = "LeftLine",
        Parent = LogoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        Position = UDim2.new(0.2, 0, 0, 0),
        Size = UDim2.new(0, 4, 1, 0),
        Rotation = -20,
        AnchorPoint = Vector2.new(0.5, 0)
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
        Utility:Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, theme.LogoPrimary),
                ColorSequenceKeypoint.new(0.5, theme.LogoSecondary),
                ColorSequenceKeypoint.new(1, theme.LogoAccent)
            }),
            Rotation = 90
        })
    })
    
    local RightLine = Utility:Create("Frame", {
        Name = "RightLine",
        Parent = LogoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        Position = UDim2.new(0.8, 0, 0, 0),
        Size = UDim2.new(0, 4, 1, 0),
        Rotation = 20,
        AnchorPoint = Vector2.new(0.5, 0)
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
        Utility:Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, theme.LogoPrimary),
                ColorSequenceKeypoint.new(0.5, theme.LogoSecondary),
                ColorSequenceKeypoint.new(1, theme.LogoAccent)
            }),
            Rotation = 90
        })
    })
    
    -- Logo parıltısı
    local Glow = Utility:Create("Frame", {
        Name = "LogoGlow",
        Parent = LogoContainer,
        BackgroundColor3 = theme.LogoPrimary,
        BackgroundTransparency = 0.8,
        Size = UDim2.new(1.5, 0, 1.5, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = -1
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(1, 0) })
    })
    
    -- Logo animasyonu
    coroutine.wrap(function()
        while LogoContainer and LogoContainer.Parent do
            Utility:Tween(LeftLine, {Rotation = -25}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            Utility:Tween(RightLine, {Rotation = 25}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            wait(1)
            Utility:Tween(LeftLine, {Rotation = -15}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            Utility:Tween(RightLine, {Rotation = 15}, 1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            wait(1)
        end
    end)()
    
    return LogoContainer
end

-- Configuration Manager
local ConfigManager = {}

function ConfigManager:GetSaveFolder(folderName)
    local success, result = pcall(function()
        if isfolder and writefile and readfile then
            if not isfolder(folderName) then
                makefolder(folderName)
            end
            return true
        end
        return false
    end)
    return success and result
end

function ConfigManager:Save(folderName, fileName, data)
    pcall(function()
        if writefile then
            writefile(folderName .. "/" .. fileName .. ".json", HttpService:JSONEncode(data))
        end
    end)
end

function ConfigManager:Load(folderName, fileName)
    local success, result = pcall(function()
        if readfile and isfile then
            local path = folderName .. "/" .. fileName .. ".json"
            if isfile(path) then
                return HttpService:JSONDecode(readfile(path))
            end
        end
        return nil
    end)
    return success and result or nil
end

-- Main Library
function AlexchadLibrary:CreateWindow(options)
    options = options or {}
    
    -- Cleanup
    CleanupAllBlur()
    if GuiParent:FindFirstChild("AlexchadUI") then
        GuiParent:FindFirstChild("AlexchadUI"):Destroy()
    end
    
    -- Options
    local windowName = options.Name or "SHOW"  -- SHOW yazısı
    local windowSubtitle = options.Subtitle or "Interface Suite"
    local windowVersion = options.Version or "v3.2"
    local loadingTitle = options.LoadingTitle or "SHOW Interface"  -- SHOW ile başlık
    local loadingSubtitle = options.LoadingSubtitle or "Loading..."
    local themeName = options.Theme or "Default"
    local configSaving = options.ConfigurationSaving or {}
    local configEnabled = configSaving.Enabled or false
    local configFolder = configSaving.FolderName or "AlexchadConfig"
    local configFile = configSaving.FileName or "config"
    
    -- Config
    local Config = {
        AnimationSpeed = options.AnimationSpeed or 0.25,
        RippleEnabled = options.RippleEnabled ~= false,
        RippleSpeed = options.RippleSpeed or 0.4,
        CornerRadius = options.CornerRadius or 12,
        ElementCornerRadius = options.ElementCornerRadius or 10,
        BlurEnabled = options.BlurEnabled ~= false
    }
    
    -- Window State
    local Window = {
        Tabs = {},
        CurrentTab = nil,
        Theme = Themes[themeName] or Themes.Default,
        ThemeName = themeName,
        Config = Config,
        Minimized = false,
        Elements = {},
        ConfigData = {},
        Connections = {},
        ElementRefs = {}
    }
    
    -- Load saved config
    if configEnabled then
        ConfigManager:GetSaveFolder(configFolder)
        local savedData = ConfigManager:Load(configFolder, configFile)
        if savedData then
            Window.ConfigData = savedData
            if savedData.Theme and Themes[savedData.Theme] then
                Window.Theme = Themes[savedData.Theme]
                Window.ThemeName = savedData.Theme
            end
        end
    end
    
    local theme = Window.Theme
    
    -- ScreenGui
    local ScreenGui = Utility:Create("ScreenGui", {
        Name = "AlexchadUI",
        Parent = GuiParent,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        IgnoreGuiInset = true
    })
    
    -- Blur
    local Blur
    if Config.BlurEnabled then
        Blur = Utility:Create("BlurEffect", {
            Name = "AlexchadBlur",
            Parent = Lighting,
            Size = 0
        })
    end
    
    -- Loading Screen
    local LoadingFrame = Utility:Create("Frame", {
        Name = "LoadingFrame",
        Parent = ScreenGui,
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = theme.BackgroundTransparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 320, 0, 160),
        AnchorPoint = Vector2.new(0.5, 0.5)
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius + 4) }),
        Utility:Create("UIStroke", { Color = theme.Border, Transparency = theme.BorderTransparency, Thickness = 1.5 }),
        Utility:Create("UIGradient", {
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.GradientStart), ColorSequenceKeypoint.new(1, theme.GradientEnd) }),
            Rotation = 135,
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 0.3) })
        })
    })
    
    -- Loading ekranında V logosu
    local LoadingLogo = Utility:CreateVLogo(LoadingFrame, theme, UDim2.new(0, 60, 0, 60))
    LoadingLogo.Position = UDim2.new(0.5, 0, 0.3, 0)
    LoadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local LoadingTitle = Utility:Create("TextLabel", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 100),
        Size = UDim2.new(1, 0, 0, 30),
        Font = Enum.Font.GothamBold,
        Text = loadingTitle,
        TextColor3 = theme.Text,
        TextSize = 22,
        TextTransparency = 1
    })
    
    local LoadingSubtitle = Utility:Create("TextLabel", {
        Parent = LoadingFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 130),
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.Gotham,
        Text = loadingSubtitle,
        TextColor3 = theme.TextDark,
        TextSize = 14,
        TextTransparency = 1
    })
    
    -- Animate loading
    if Blur then Utility:Tween(Blur, {Size = 10}, Config.AnimationSpeed) end
    Utility:Tween(LoadingLogo, {Size = UDim2.new(0, 80, 0, 80)}, Config.AnimationSpeed * 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    task.wait(Config.AnimationSpeed * 0.5)
    Utility:Tween(LoadingTitle, {TextTransparency = 0}, Config.AnimationSpeed)
    task.wait(Config.AnimationSpeed * 0.3)
    Utility:Tween(LoadingSubtitle, {TextTransparency = 0}, Config.AnimationSpeed)
    
    task.wait(1.5)
    
    -- Fade out loading
    Utility:Tween(LoadingFrame, {BackgroundTransparency = 1}, Config.AnimationSpeed)
    Utility:Tween(LoadingLogo, {BackgroundTransparency = 1}, Config.AnimationSpeed)
    Utility:Tween(LoadingTitle, {TextTransparency = 1}, Config.AnimationSpeed)
    Utility:Tween(LoadingSubtitle, {TextTransparency = 1}, Config.AnimationSpeed)
    for _, child in pairs(LoadingFrame:GetDescendants()) do
        if child:IsA("UIStroke") then
            Utility:Tween(child, {Transparency = 1}, Config.AnimationSpeed)
        end
    end
    task.wait(Config.AnimationSpeed + 0.1)
    LoadingFrame:Destroy()
    
    -- Main Container
    local MainContainer = Utility:Create("Frame", {
        Name = "MainContainer",
        Parent = ScreenGui,
        BackgroundColor3 = theme.Background,
        BackgroundTransparency = theme.BackgroundTransparency,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius + 6) }),
        Utility:Create("UIStroke", { Name = "MainStroke", Color = theme.Border, Transparency = theme.BorderTransparency, Thickness = 1.5 }),
        Utility:Create("UIGradient", {
            Name = "MainGradient",
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.GradientStart), ColorSequenceKeypoint.new(1, theme.GradientEnd) }),
            Rotation = 135,
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 0.3) })
        })
    })
    
    -- Glow
    local Glow = Utility:Create("ImageLabel", {
        Name = "Glow",
        Parent = MainContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 50, 1, 50),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = "rbxassetid://5028857084",
        ImageColor3 = theme.Accent,
        ImageTransparency = 0.85,
        ZIndex = 0,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(24, 24, 276, 276)
    })
    
    -- Animate open
    Utility:Tween(MainContainer, {Size = UDim2.new(0, 700, 0, 480)}, Config.AnimationSpeed * 1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    task.wait(Config.AnimationSpeed * 0.8)
    
    -- Header
    local Header = Utility:Create("Frame", {
        Name = "Header",
        Parent = MainContainer,
        BackgroundColor3 = theme.Container,
        BackgroundTransparency = theme.ContainerTransparency + 0.1,
        Position = UDim2.new(0, 15, 0, 15),
        Size = UDim2.new(1, -30, 0, 65)  -- Daha yüksek header
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius) }),
        Utility:Create("UIStroke", { Color = theme.Border, Transparency = theme.BorderTransparency + 0.2, Thickness = 1 })
    })
    
    -- Logo ve Başlık Container
    local TitleContainer = Utility:Create("Frame", {
        Name = "TitleContainer",
        Parent = Header,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0.6, 0, 1, 0)
    })
    
    -- V Logosu
    local TitleLogo = Utility:CreateVLogo(TitleContainer, theme, UDim2.new(0, 40, 0, 40))
    TitleLogo.Position = UDim2.new(0, 0, 0.5, 0)
    TitleLogo.AnchorPoint = Vector2.new(0, 0.5)
    
    -- Başlık (SHOW yazısı)
    local TitleLabel = Utility:Create("TextLabel", {
        Name = "Title",
        Parent = TitleContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 10),
        Size = UDim2.new(1, -50, 0, 25),
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = theme.Text,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextStrokeColor3 = theme.Accent,
        TextStrokeTransparency = 0.7
    })
    
    local SubtitleLabel = Utility:Create("TextLabel", {
        Name = "Subtitle",
        Parent = TitleContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0, 35),
        Size = UDim2.new(1, -50, 0, 18),
        Font = Enum.Font.Gotham,
        Text = windowSubtitle .. " | " .. windowVersion,
        TextColor3 = theme.TextMuted,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Kontroller Container (DEĞİŞTİRİLDİ: Soldan sağa Küçültme (-) sonra Kapatma (X))
    local ControlsContainer = Utility:Create("Frame", {
        Name = "Controls",
        Parent = Header,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -115, 0, 0),  -- Daha geniş
        Size = UDim2.new(0, 100, 1, 0)
    }, {
        Utility:Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 8)
        })
    })
    
    local function CreateControlButton(name, text, hoverColor, callback, order)
        local btn = Utility:Create("TextButton", {
            Name = name,
            Parent = ControlsContainer,
            BackgroundColor3 = theme.Element,
            BackgroundTransparency = theme.ElementTransparency,
            Size = UDim2.new(0, 36, 0, 36),  -- Biraz daha büyük
            Font = Enum.Font.GothamBold,
            Text = text,
            TextColor3 = theme.TextDark,
            TextSize = 18,
            AutoButtonColor = false,
            LayoutOrder = order
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.ElementCornerRadius) }),
            Utility:Create("UIStroke", { Color = theme.Border, Transparency = theme.BorderTransparency + 0.2, Thickness = 1 })
        })
        
        btn.MouseEnter:Connect(function()
            Utility:Tween(btn, {BackgroundColor3 = hoverColor, BackgroundTransparency = 0, TextColor3 = theme.Text, Size = UDim2.new(0, 38, 0, 38)}, Config.AnimationSpeed * 0.5)
        end)
        btn.MouseLeave:Connect(function()
            Utility:Tween(btn, {BackgroundColor3 = theme.Element, BackgroundTransparency = theme.ElementTransparency, TextColor3 = theme.TextDark, Size = UDim2.new(0, 36, 0, 36)}, Config.AnimationSpeed * 0.5)
        end)
        btn.MouseButton1Click:Connect(function()
            Utility:Ripple(btn, theme, Config)
            callback()
        end)
        
        return btn
    end
    
    -- DEĞİŞTİRİLDİ: Önce Küçültme (-) butonu
    CreateControlButton("Minimize", "-", theme.Warning, function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            Utility:Tween(MainContainer, {Size = UDim2.new(0, 700, 0, 95)}, Config.AnimationSpeed)
            if Blur then Utility:Tween(Blur, {Size = 5}, Config.AnimationSpeed) end
        else
            Utility:Tween(MainContainer, {Size = UDim2.new(0, 700, 0, 480)}, Config.AnimationSpeed)
            if Blur then Utility:Tween(Blur, {Size = 10}, Config.AnimationSpeed) end
        end
    end, 1)
    
    -- Sonra Kapatma (X) butonu
    CreateControlButton("Close", "X", theme.Error, function()
        for _, conn in pairs(Window.Connections) do
            if conn and conn.Connected then conn:Disconnect() end
        end
        if Blur then Utility:Tween(Blur, {Size = 0}, Config.AnimationSpeed) end
        Utility:Tween(MainContainer, {Size = UDim2.new(0, 0, 0, 0)}, Config.AnimationSpeed, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(Config.AnimationSpeed + 0.1)
        CleanupAllBlur()
        ScreenGui:Destroy()
    end, 2)
    
    Utility:MakeDraggable(MainContainer, Header, Config)
    
    -- Content Area
    local ContentArea = Utility:Create("Frame", {
        Name = "ContentArea",
        Parent = MainContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 90),  -- Header daha yüksek olduğu için
        Size = UDim2.new(1, -30, 1, -105)
    })
    
    -- Tab Container
    local TabContainer = Utility:Create("Frame", {
        Name = "TabContainer",
        Parent = ContentArea,
        BackgroundColor3 = theme.Container,
        BackgroundTransparency = theme.ContainerTransparency,
        Size = UDim2.new(0, 150, 1, 0)
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius) }),
        Utility:Create("UIStroke", { Color = theme.Border, Transparency = theme.BorderTransparency + 0.2, Thickness = 1 })
    })
    
    local TabList = Utility:Create("ScrollingFrame", {
        Name = "TabList",
        Parent = TabContainer,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 1, -20),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = theme.Accent,
        ScrollBarImageTransparency = 0.5,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true
    }, {
        Utility:Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
    })
    
    -- Main Content
    local MainContent = Utility:Create("Frame", {
        Name = "MainContent",
        Parent = ContentArea,
        BackgroundColor3 = theme.Container,
        BackgroundTransparency = theme.ContainerTransparency,
        Position = UDim2.new(0, 160, 0, 0),
        Size = UDim2.new(1, -160, 1, 0),
        ClipsDescendants = true
    }, {
        Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius) }),
        Utility:Create("UIStroke", { Color = theme.Border, Transparency = theme.BorderTransparency + 0.2, Thickness = 1 })
    })
    
    -- Save Config
    local function SaveConfig()
        if not configEnabled then return end
        local data = { Theme = Window.ThemeName, Elements = {} }
        for id, el in pairs(Window.Elements) do
            if el.Value ~= nil then data.Elements[id] = el.Value end
        end
        Window.ConfigData = data
        ConfigManager:Save(configFolder, configFile, data)
    end
    
    -- Apply Theme
    local function ApplyTheme(newThemeName, animate)
        local newTheme = Themes[newThemeName]
        if not newTheme then return end
        
        Window.Theme = newTheme
        Window.ThemeName = newThemeName
        theme = newTheme
        
        local dur = animate and Config.AnimationSpeed or 0
        
        -- Main Container
        Utility:Tween(MainContainer, {BackgroundColor3 = newTheme.Background, BackgroundTransparency = newTheme.BackgroundTransparency}, dur)
        local mainStroke = MainContainer:FindFirstChild("MainStroke")
        if mainStroke then Utility:Tween(mainStroke, {Color = newTheme.Border, Transparency = newTheme.BorderTransparency}, dur) end
        local mainGrad = MainContainer:FindFirstChild("MainGradient")
        if mainGrad then
            mainGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, newTheme.GradientStart), ColorSequenceKeypoint.new(1, newTheme.GradientEnd) })
        end
        Utility:Tween(Glow, {ImageColor3 = newTheme.Accent}, dur)
        
        -- Header
        Utility:Tween(Header, {BackgroundColor3 = newTheme.Container, BackgroundTransparency = newTheme.ContainerTransparency + 0.1}, dur)
        Utility:Tween(TitleLabel, {TextColor3 = newTheme.Text, TextStrokeColor3 = newTheme.Accent}, dur)
        Utility:Tween(SubtitleLabel, {TextColor3 = newTheme.TextMuted}, dur)
        
        -- Containers
        Utility:Tween(TabContainer, {BackgroundColor3 = newTheme.Container, BackgroundTransparency = newTheme.ContainerTransparency}, dur)
        Utility:Tween(MainContent, {BackgroundColor3 = newTheme.Container, BackgroundTransparency = newTheme.ContainerTransparency}, dur)
        
        -- Tab buttons
        for _, tab in pairs(Window.Tabs) do
            local isCurrent = tab == Window.CurrentTab
            Utility:Tween(tab.Button, {
                BackgroundColor3 = isCurrent and newTheme.Accent or newTheme.Element,
                BackgroundTransparency = isCurrent and 0 or newTheme.ElementTransparency
            }, dur)
            Utility:Tween(tab.Label, {TextColor3 = isCurrent and newTheme.Text or newTheme.TextDark}, dur)
            Utility:Tween(tab.Icon, {TextColor3 = isCurrent and newTheme.Text or newTheme.TextDark}, dur)
            Utility:Tween(tab.Indicator, {BackgroundColor3 = newTheme.Accent}, dur)
            
            local btnStroke = tab.Button:FindFirstChildOfClass("UIStroke")
            if btnStroke then Utility:Tween(btnStroke, {Color = newTheme.Border, Transparency = newTheme.BorderTransparency + 0.3}, dur) end
        end
        
        -- Update all registered elements (önceki gibi)
        -- ... [önceki tema güncelleme kodu buraya gelecek]
        
        SaveConfig()
    end
    
    Window.ApplyTheme = ApplyTheme
    
    -- DEĞİŞTİRİLDİ: ÜSTTE Bildirim Sistemi
    function Window:Notify(notifyOptions)
        notifyOptions = notifyOptions or {}
        local title = notifyOptions.Title or "Notification"
        local content = notifyOptions.Content or ""
        local duration = notifyOptions.Duration or 5
        local notifyType = notifyOptions.Type or "Info"
        local showButtons = notifyOptions.Buttons ~= false
        
        local typeColors = {
            Info = theme.Accent,
            Success = theme.Success,
            Warning = theme.Warning,
            Error = theme.Error
        }
        local typeColor = typeColors[notifyType] or theme.Accent
        
        -- DEĞİŞTİRİLDİ: Bildirimler üstte
        local NotifHolder = ScreenGui:FindFirstChild("NotificationHolder")
        if not NotifHolder then
            NotifHolder = Utility:Create("Frame", {
                Name = "NotificationHolder",
                Parent = ScreenGui,
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -20, 0, 20),  -- Üst sağ köşe
                Size = UDim2.new(0, 340, 0, 0),
                AnchorPoint = Vector2.new(1, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            }, {
                Utility:Create("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    Padding = UDim.new(0, 12)
                })
            })
        end
        
        local NotifFrame = Utility:Create("Frame", {
            Name = "Notification",
            Parent = NotifHolder,
            BackgroundColor3 = theme.Background,
            BackgroundTransparency = theme.BackgroundTransparency - 0.05,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(1, 50, 0, 0),  -- Sağdan girecek
            ClipsDescendants = true
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(0, Config.CornerRadius) }),
            Utility:Create("UIStroke", { Color = typeColor, Transparency = 0.3, Thickness = 1.5 }),
            Utility:Create("UIGradient", {
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, theme.GradientStart), ColorSequenceKeypoint.new(1, theme.GradientEnd) }),
                Rotation = 135,
                Transparency = NumberSequence.new(0.2)
            })
        })
        
        -- Accent bar on left
        local AccentBar = Utility:Create("Frame", {
            Name = "AccentBar",
            Parent = NotifFrame,
            BackgroundColor3 = typeColor,
            Size = UDim2.new(0, 4, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(0, 4) })
        })
        
        -- Content container
        local ContentContainer = Utility:Create("Frame", {
            Name = "ContentContainer",
            Parent = NotifFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 16, 0, 0),
            Size = UDim2.new(1, -20, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }, {
            Utility:Create("UIPadding", { PaddingTop = UDim.new(0, 14), PaddingBottom = UDim.new(0, 14), PaddingRight = UDim.new(0, 10) }),
            Utility:Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8) })
        })
        
        -- Header with icon and title
        local HeaderFrame = Utility:Create("Frame", {
            Name = "Header",
            Parent = ContentContainer,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 24)
        })
        
        local TypeIcon = Utility:Create("TextLabel", {
            Name = "Icon",
            Parent = HeaderFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(0, 24, 0, 24),
            Font = Enum.Font.GothamBold,
            Text = notifyType == "Success" and "✓" or notifyType == "Warning" and "!" or notifyType == "Error" and "✗" or "i",
            TextColor3 = typeColor,
            TextSize = 16
        })
        
        local NotifTitle = Utility:Create("TextLabel", {
            Name = "Title",
            Parent = HeaderFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 30, 0, 0),
            Size = UDim2.new(1, -70, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = theme.Text,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
        
        -- Close button
        local CloseBtn = Utility:Create("TextButton", {
            Name = "Close",
            Parent = HeaderFrame,
            BackgroundColor3 = theme.Element,
            BackgroundTransparency = 0.5,
            Position = UDim2.new(1, -24, 0, 0),
            Size = UDim2.new(0, 24, 0, 24),
            Font = Enum.Font.GothamBold,
            Text = "X",
            TextColor3 = theme.TextDark,
            TextSize = 12,
            AutoButtonColor = false
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(0, 6) })
        })
        
        -- Content text
        local NotifContent = Utility:Create("TextLabel", {
            Name = "Content",
            Parent = ContentContainer,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = Enum.Font.Gotham,
            Text = content,
            TextColor3 = theme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })
        
        -- Progress bar
        local ProgressContainer = Utility:Create("Frame", {
            Name = "ProgressContainer",
            Parent = ContentContainer,
            BackgroundColor3 = theme.Element,
            BackgroundTransparency = 0.5,
            Size = UDim2.new(1, 0, 0, 4)
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(1, 0) })
        })
        
        local ProgressFill = Utility:Create("Frame", {
            Name = "Fill",
            Parent = ProgressContainer,
            BackgroundColor3 = typeColor,
            Size = UDim2.new(1, 0, 1, 0)
        }, {
            Utility:Create("UICorner", { CornerRadius = UDim.new(1, 0) })
        })
        
        -- Buttons row (optional)
        if showButtons then
            local ButtonsRow = Utility:Create("Frame", {
                Name = "Buttons",
                Parent = ContentContainer,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 32)
            }, {
                Utility:Create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 8)
                })
            })
            
            local OkButton = Utility:Create("TextButton", {
                Name = "OK",
                Parent = ButtonsRow,
                BackgroundColor3 = typeColor,
                Size = UDim2.new(0, 70, 0, 28),
                Font = Enum.Font.GothamBold,
                Text = "OK",
                TextColor3 = theme.Text,
                TextSize = 12,
                AutoButtonColor = false
            }, {
                Utility:Create("UICorner", { CornerRadius = UDim.new(0, 6) })
            })
            
            OkButton.MouseEnter:Connect(function()
                Utility:Tween(OkButton, {BackgroundColor3 = theme.AccentDark}, Config.AnimationSpeed * 0.5)
            end)
            OkButton.MouseLeave:Connect(function()
                Utility:Tween(OkButton, {BackgroundColor3 = typeColor}, Config.AnimationSpeed * 0.5)
            end)
        end
        
        -- Animation (üstten giriş)
        Utility:Tween(NotifFrame, {Position = UDim2.new(0, 0, 0, 0)}, Config.AnimationSpeed, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Utility:Tween(ProgressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
        
        local function CloseNotification()
            Utility:Tween(NotifFrame, {Position = UDim2.new(1, 50, 0, 0)}, Config.AnimationSpeed)
            task.wait(Config.AnimationSpeed + 0.1)
            if NotifFrame then NotifFrame:Destroy() end
        end
        
        CloseBtn.MouseButton1Click:Connect(CloseNotification)
        if showButtons then
            local okBtn = ContentContainer:FindFirstChild("Buttons") and ContentContainer.Buttons:FindFirstChild("OK")
            if okBtn then okBtn.MouseButton1Click:Connect(CloseNotification) end
        end
        
        task.delay(duration, function()
            if NotifFrame and NotifFrame.Parent then
                CloseNotification()
            end
        end)
    end
    
    -- Tab ve diğer fonksiyonlar önceki gibi kalacak
    -- ... [önceki tab, button, toggle vs. fonksiyonları buraya gelecek]
    
    -- Tab oluşturma fonksiyonu ve diğer UI elementleri
    -- Bunlar orijinal koddan aynen alınabilir
    
    return {
        CreateTab = function(tabOptions)
            -- Tab oluşturma kodu buraya
            local Tab = {}
            -- ... tab oluşturma işlemleri
            return Tab
        end,
        
        Notify = function(notifyOptions)
            Window:Notify(notifyOptions)
        end,
        
        Destroy = function()
            Window:Destroy()
        end,
        
        Toggle = function(visible)
            Window:Toggle(visible)
        end,
        
        SetTheme = function(themeName)
            ApplyTheme(themeName, true)
        end,
        
        GetTheme = function()
            return Window.ThemeName
        end
    }
end

-- Kütüphaneyi döndür
return AlexchadLibrary
