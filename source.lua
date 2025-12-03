--[[
    VORTEX UI - Tam Fonksiyonel
    Bağımsız V Logosu + Modern UI
    TEST EDİLMİŞ VERSİYON
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

-- Utility Functions
local function Create(className, props)
    local obj = Instance.new(className)
    for prop, val in pairs(props) do
        if prop ~= "Parent" then
            pcall(function()
                obj[prop] = val
            end)
        end
    end
    return obj
end

local function Tween(obj, props, duration, easing)
    local tweenInfo = TweenInfo.new(duration or 0.3, easing or Enum.EasingStyle.Quart)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
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

-- VORTEX UI LIBRARY
local Vortex = {}

function Vortex:CreateWindow(options)
    if not options then options = {} end
    
    -- Main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VortexUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = CoreGui
    
    -- Loading Screen
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Name = "Loading"
    loadingFrame.BackgroundColor3 = Colors.Background
    loadingFrame.Size = UDim2.new(1, 0, 1, 0)
    loadingFrame.ZIndex = 1000
    loadingFrame.Parent = screenGui
    
    local loadingContent = Instance.new("Frame")
    loadingContent.Name = "LoadingContent"
    loadingContent.BackgroundColor3 = Colors.Container
    loadingContent.Size = UDim2.new(0, 300, 0, 150)
    loadingContent.Position = UDim2.new(0.5, 0, 0.5, 0)
    loadingContent.AnchorPoint = Vector2.new(0.5, 0.5)
    loadingContent.Parent = loadingFrame
    
    local loadingCorner = Instance.new("UICorner")
    loadingCorner.CornerRadius = UDim.new(0, 8)
    loadingCorner.Parent = loadingContent
    
    local loadingStroke = Instance.new("UIStroke")
    loadingStroke.Color = Colors.Border
    loadingStroke.Thickness = 2
    loadingStroke.Parent = loadingContent
    
    -- Loading V Logo
    local loadingLogo = Instance.new("TextButton")
    loadingLogo.Name = "LoadingLogo"
    loadingLogo.Size = UDim2.new(0, 50, 0, 50)
    loadingLogo.Position = UDim2.new(0.5, 0, 0.3, 0)
    loadingLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    loadingLogo.BackgroundColor3 = Colors.Accent
    loadingLogo.Text = "V"
    loadingLogo.TextColor3 = Colors.Text
    loadingLogo.TextSize = 20
    loadingLogo.Font = Enum.Font.GothamBlack
    loadingLogo.AutoButtonColor = false
    loadingLogo.Parent = loadingContent
    
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = loadingLogo
    
    local logoStroke = Instance.new("UIStroke")
    logoStroke.Color = Color3.fromRGB(200, 230, 255)
    logoStroke.Thickness = 1.6
    logoStroke.Parent = loadingLogo
    
    local loadingTitle = Instance.new("TextLabel")
    loadingTitle.Name = "LoadingTitle"
    loadingTitle.BackgroundTransparency = 1
    loadingTitle.Position = UDim2.new(0, 0, 0.65, 0)
    loadingTitle.Size = UDim2.new(1, 0, 0, 30)
    loadingTitle.Font = Enum.Font.GothamBold
    loadingTitle.Text = "VORTEX UI"
    loadingTitle.TextColor3 = Colors.Text
    loadingTitle.TextSize = 20
    loadingTitle.Parent = loadingContent
    
    local loadingSubtitle = Instance.new("TextLabel")
    loadingSubtitle.Name = "LoadingSubtitle"
    loadingSubtitle.BackgroundTransparency = 1
    loadingSubtitle.Position = UDim2.new(0, 0, 0.8, 0)
    loadingSubtitle.Size = UDim2.new(1, 0, 0, 20)
    loadingSubtitle.Font = Enum.Font.Gotham
    loadingSubtitle.Text = "Loading..."
    loadingSubtitle.TextColor3 = Colors.SubText
    loadingSubtitle.TextSize = 14
    loadingSubtitle.Parent = loadingContent
    
    -- Loading bar
    local barBg = Instance.new("Frame")
    barBg.Name = "LoadingBarBg"
    barBg.BackgroundColor3 = Colors.Element
    barBg.Position = UDim2.new(0.1, 0, 0.9, 0)
    barBg.Size = UDim2.new(0.8, 0, 0, 4)
    barBg.Parent = loadingContent
    
    local barBgCorner = Instance.new("UICorner")
    barBgCorner.CornerRadius = UDim.new(1, 0)
    barBgCorner.Parent = barBg
    
    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.BackgroundColor3 = Colors.Accent
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.Parent = barBg
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = loadingBar
    
    -- Bağımsız V Logo Butonu
    local logoButton = Instance.new("TextButton")
    logoButton.Name = "VortexLogo"
    logoButton.Size = UDim2.new(0, 47, 0, 42)
    logoButton.Position = UDim2.new(0, 15, 0, 15)
    logoButton.BackgroundColor3 = Colors.Accent
    logoButton.Text = "V"
    logoButton.TextColor3 = Colors.Text
    logoButton.TextSize = 18
    logoButton.Font = Enum.Font.GothamBlack
    logoButton.AutoButtonColor = false
    logoButton.ZIndex = 100
    logoButton.Parent = screenGui
    
    local logoButtonCorner = Instance.new("UICorner")
    logoButtonCorner.CornerRadius = UDim.new(1, 0)
    logoButtonCorner.Parent = logoButton
    
    local logoButtonStroke = Instance.new("UIStroke")
    logoButtonStroke.Color = Color3.fromRGB(200, 230, 255)
    logoButtonStroke.Thickness = 1.6
    logoButtonStroke.Parent = logoButton
    
    -- Logo glow
    local logoGlow = Instance.new("Frame")
    logoGlow.Name = "LogoGlow"
    logoGlow.BackgroundColor3 = Colors.Accent
    logoGlow.BackgroundTransparency = 0.8
    logoGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    logoGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    logoGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    logoGlow.ZIndex = 99
    logoGlow.Parent = logoButton
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(1, 0)
    glowCorner.Parent = logoGlow
    
    -- Ana Pencere
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 450)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Colors.Background
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Colors.Accent
    mainStroke.Thickness = 2
    mainStroke.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Colors.Container
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.Size = UDim2.new(1, -30, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = options.Name or "Vortex UI"
    titleLabel.TextColor3 = Colors.Text
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    -- Content Area
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, 0, 0, 55)
    content.Size = UDim2.new(1, 0, 1, -55)
    content.Parent = mainFrame
    
    -- Tabs
    local tabs = Instance.new("Frame")
    tabs.Name = "Tabs"
    tabs.Size = UDim2.new(0, 150, 1, 0)
    tabs.BackgroundColor3 = Colors.Container
    tabs.Parent = content
    
    local tabsCorner = Instance.new("UICorner")
    tabsCorner.CornerRadius = UDim.new(0, 8)
    tabsCorner.Parent = tabs
    
    local tabsStroke = Instance.new("UIStroke")
    tabsStroke.Color = Colors.Border
    tabsStroke.Thickness = 1
    tabsStroke.Parent = tabs
    
    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.BackgroundTransparency = 1
    tabList.Size = UDim2.new(1, -10, 1, -20)
    tabList.Position = UDim2.new(0, 5, 0, 10)
    tabList.ScrollBarThickness = 3
    tabList.ScrollBarImageColor3 = Colors.Accent
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.Parent = tabs
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabList
    
    -- Main Content
    local mainContent = Instance.new("Frame")
    mainContent.Name = "MainContent"
    mainContent.Size = UDim2.new(1, -160, 1, 0)
    mainContent.Position = UDim2.new(0, 160, 0, 0)
    mainContent.BackgroundColor3 = Colors.Container
    mainContent.Parent = content
    
    local mainContentCorner = Instance.new("UICorner")
    mainContentCorner.CornerRadius = UDim.new(0, 8)
    mainContentCorner.Parent = mainContent
    
    local mainContentStroke = Instance.new("UIStroke")
    mainContentStroke.Color = Colors.Border
    mainContentStroke.Thickness = 1
    mainContentStroke.Parent = mainContent
    
    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Name = "ContentScroll"
    contentScroll.BackgroundTransparency = 1
    contentScroll.Size = UDim2.new(1, -20, 1, -20)
    contentScroll.Position = UDim2.new(0, 10, 0, 10)
    contentScroll.ScrollBarThickness = 4
    contentScroll.ScrollBarImageColor3 = Colors.Accent
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentScroll.Parent = mainContent
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = contentScroll
    
    -- Loading animation
    Tween(loadingBar, {Size = UDim2.new(1, 0, 1, 0)}, 2)
    
    wait(2.2)
    
    Tween(loadingFrame, {BackgroundTransparency = 1}, 0.3)
    Tween(loadingContent, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    wait(0.4)
    loadingFrame:Destroy()
    
    -- Logo glow animation
    coroutine.wrap(function()
        while logoButton and logoButton.Parent do
            Tween(logoGlow, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 0.7}, 1.5)
            wait(1.5)
            Tween(logoGlow, {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 0.8}, 1.5)
            wait(1.5)
        end
    end)()
    
    -- Logo hover effects
    logoButton.MouseEnter:Connect(function()
        Tween(logoButton, {
            Size = UDim2.new(0, 50, 0, 45),
            BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        }, 0.2)
    end)
    
    logoButton.MouseLeave:Connect(function()
        Tween(logoButton, {
            Size = UDim2.new(0, 47, 0, 42),
            BackgroundColor3 = Colors.Accent
        }, 0.2)
    end)
    
    -- UI Toggle with Logo
    local uiVisible = false
    
    logoButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        
        if uiVisible then
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            Tween(mainFrame, {Size = UDim2.new(0, 600, 0, 450)}, 0.4, Enum.EasingStyle.Back)
            Tween(logoButton, {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}, 0.3)
        else
            Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
            Tween(logoButton, {BackgroundColor3 = Colors.Accent}, 0.3)
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
                Tween(mainFrame, {Size = UDim2.new(0, 600, 0, 450)}, 0.4, Enum.EasingStyle.Back)
            else
                Tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back)
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
                if input.UserInputState == Enum.UserInputState.End then
                    draggingLogo = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingLogo and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartLogo
            logoButton.Position = UDim2.new(
                startPosLogo.X.Scale,
                startPosLogo.X.Offset + delta.X,
                startPosLogo.Y.Scale,
                startPosLogo.Y.Offset + delta.Y
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
                if input.UserInputState == Enum.UserInputState.End then
                    draggingWindow = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingWindow and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStartWindow
            mainFrame.Position = UDim2.new(
                startPosWindow.X.Scale,
                startPosWindow.X.Offset + delta.X,
                startPosWindow.Y.Scale,
                startPosWindow.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Window Functions
    local window = {
        Tabs = {},
        CurrentTab = nil
    }
    
    function window:CreateTab(name)
        local tab = {
            Name = name,
            Button = nil,
            Content = nil
        }
        
        -- Tab Button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Size = UDim2.new(1, 0, 0, 38)
        tabButton.BackgroundColor3 = Colors.Element
        tabButton.Text = name
        tabButton.TextColor3 = Colors.SubText
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.AutoButtonColor = false
        tabButton.Parent = tabList
        
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 6)
        tabButtonCorner.Parent = tabButton
        
        -- Tab Content
        local tabContent = Instance.new("Frame")
        tabContent.Name = name .. "Content"
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 0, 0)
        tabContent.AutomaticSize = Enum.AutomaticSize.Y
        tabContent.Visible = false
        tabContent.Parent = contentScroll
        
        local tabContentLayout = Instance.new("UIListLayout")
        tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabContentLayout.Padding = UDim.new(0, 10)
        tabContentLayout.Parent = tabContent
        
        -- Tab Selection
        local function SelectTab()
            if window.CurrentTab then
                if window.CurrentTab.Button then
                    window.CurrentTab.Button.BackgroundColor3 = Colors.Element
                    window.CurrentTab.Button.TextColor3 = Colors.SubText
                end
                if window.CurrentTab.Content then
                    window.CurrentTab.Content.Visible = false
                end
            end
            
            window.CurrentTab = tab
            
            if tabButton then
                tabButton.BackgroundColor3 = Colors.Accent
                tabButton.TextColor3 = Colors.Text
            end
            
            if tabContent then
                tabContent.Visible = true
            end
        end
        
        tabButton.MouseButton1Click:Connect(SelectTab)
        
        -- Auto-select first tab
        if #tabList:GetChildren() == 1 then
            SelectTab()
        end
        
        tab.Button = tabButton
        tab.Content = tabContent
        
        -- Button Element
        function tab:CreateButton(options)
            if not options then options = {} end
            local btnName = options.Name or "Button"
            local callback = options.Callback or function() end
            
            local btnFrame = Instance.new("Frame")
            btnFrame.Name = btnName .. "Button"
            btnFrame.Size = UDim2.new(1, 0, 0, 40)
            btnFrame.BackgroundColor3 = Colors.Element
            btnFrame.Parent = tabContent
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btnFrame
            
            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = Colors.Border
            btnStroke.Thickness = 1
            btnStroke.Parent = btnFrame
            
            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 12, 0, 0)
            label.Size = UDim2.new(1, -24, 1, 0)
            label.Font = Enum.Font.Gotham
            label.Text = btnName
            label.TextColor3 = Colors.Text
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = btnFrame
            
            local click = Instance.new("TextButton")
            click.BackgroundTransparency = 1
            click.Size = UDim2.new(1, 0, 1, 0)
            click.Text = ""
            click.AutoButtonColor = false
            click.Parent = btnFrame
            
            click.MouseEnter:Connect(function()
                Tween(btnFrame, {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 65)
                }, 0.2)
            end)
            
            click.MouseLeave:Connect(function()
                Tween(btnFrame, {
                    BackgroundColor3 = Colors.Element
                }, 0.2)
            end)
            
            click.MouseButton1Click:Connect(function()
                Tween(btnFrame, {
                    Size = UDim2.new(0.98, 0, 0, 38)
                }, 0.1)
                wait(0.1)
                Tween(btnFrame, {
                    Size = UDim2.new(1, 0, 0, 40)
                }, 0.1)
                callback()
            end)
            
            local buttonObj = {}
            
            function buttonObj:SetText(text)
                label.Text = text
            end
            
            return buttonObj
        end
        
        -- Toggle Element
        function tab:CreateToggle(options)
            if not options then options = {} end
            local toggleName = options.Name or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local value = defaultValue
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = toggleName .. "Toggle"
            toggleFrame.Size = UDim2.new(1, 0, 0, 40)
            toggleFrame.BackgroundColor3 = Colors.Element
            toggleFrame.Parent = tabContent
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleFrame
            
            local toggleStroke = Instance.new("UIStroke")
            toggleStroke.Color = Colors.Border
            toggleStroke.Thickness = 1
            toggleStroke.Parent = toggleFrame
            
            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 12, 0, 0)
            label.Size = UDim2.new(1, -70, 1, 0)
            label.Font = Enum.Font.Gotham
            label.Text = toggleName
            label.TextColor3 = Colors.Text
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = toggleFrame
            
            local switch = Instance.new("Frame")
            switch.Name = "Switch"
            switch.Size = UDim2.new(0, 50, 0, 24)
            switch.Position = UDim2.new(1, -62, 0.5, 0)
            switch.AnchorPoint = Vector2.new(0, 0.5)
            switch.BackgroundColor3 = value and Colors.Accent or Colors.Element
            switch.Parent = toggleFrame
            
            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(1, 0)
            switchCorner.Parent = switch
            
            local switchStroke = Instance.new("UIStroke")
            switchStroke.Color = Colors.Border
            switchStroke.Thickness = 1
            switchStroke.Parent = switch
            
            local circle = Instance.new("Frame")
            circle.BackgroundColor3 = Colors.Text
            circle.Size = UDim2.new(0, 18, 0, 18)
            circle.Position = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
            circle.AnchorPoint = Vector2.new(0, 0.5)
            circle.Parent = switch
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = circle
            
            local click = Instance.new("TextButton")
            click.BackgroundTransparency = 1
            click.Size = UDim2.new(1, 0, 1, 0)
            click.Text = ""
            click.AutoButtonColor = false
            click.Parent = toggleFrame
            
            local function UpdateToggle()
                if value then
                    Tween(switch, {
                        BackgroundColor3 = Colors.Accent
                    }, 0.2)
                    Tween(circle, {
                        Position = UDim2.new(1, -20, 0.5, 0)
                    }, 0.2)
                else
                    Tween(switch, {
                        BackgroundColor3 = Colors.Element
                    }, 0.2)
                    Tween(circle, {
                        Position = UDim2.new(0, 3, 0.5, 0)
                    }, 0.2)
                end
                callback(value)
            end
            
            click.MouseButton1Click:Connect(function()
                value = not value
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            local toggleObj = {}
            
            function toggleObj:Set(val)
                value = val
                UpdateToggle()
            end
            
            function toggleObj:Get()
                return value
            end
            
            return toggleObj
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    function window:Destroy()
        screenGui:Destroy()
    end
    
    function window:Notify(title, message, duration)
        if not title then title = "Notification" end
        if not message then message = "" end
        if not duration then duration = 5 end
        
        local notifyFrame = Instance.new("Frame")
        notifyFrame.Name = "Notification"
        notifyFrame.Size = UDim2.new(0, 300, 0, 0)
        notifyFrame.Position = UDim2.new(1, -320, 0, 20)
        notifyFrame.BackgroundColor3 = Colors.Container
        notifyFrame.AutomaticSize = Enum.AutomaticSize.Y
        notifyFrame.ClipsDescendants = true
        notifyFrame.Parent = screenGui
        
        local notifyCorner = Instance.new("UICorner")
        notifyCorner.CornerRadius = UDim.new(0, 8)
        notifyCorner.Parent = notifyFrame
        
        local notifyStroke = Instance.new("UIStroke")
        notifyStroke.Color = Colors.Accent
        notifyStroke.Thickness = 1
        notifyStroke.Parent = notifyFrame
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.BackgroundTransparency = 1
        titleLabel.Position = UDim2.new(0, 12, 0, 12)
        titleLabel.Size = UDim2.new(1, -24, 0, 20)
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = title
        titleLabel.TextColor3 = Colors.Text
        titleLabel.TextSize = 16
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = notifyFrame
        
        local messageLabel = Instance.new("TextLabel")
        messageLabel.BackgroundTransparency = 1
        messageLabel.Position = UDim2.new(0, 12, 0, 38)
        messageLabel.Size = UDim2.new(1, -24, 0, 0)
        messageLabel.AutomaticSize = Enum.AutomaticSize.Y
        messageLabel.Font = Enum.Font.Gotham
        messageLabel.Text = message
        messageLabel.TextColor3 = Colors.SubText
        messageLabel.TextSize = 14
        messageLabel.TextXAlignment = Enum.TextXAlignment.Left
        messageLabel.TextWrapped = true
        messageLabel.Parent = notifyFrame
        
        Tween(notifyFrame, {
            Size = UDim2.new(0, 300, 0, notifyFrame.AbsoluteSize.Y)
        }, 0.3)
        
        task.delay(duration, function()
            if notifyFrame and notifyFrame.Parent then
                Tween(notifyFrame, {
                    Size = UDim2.new(0, 300, 0, 0)
                }, 0.3)
                wait(0.35)
                notifyFrame:Destroy()
            end
        end)
    end
    
    return window
end

return Vortex
