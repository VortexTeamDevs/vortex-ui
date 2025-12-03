--[[
    VORTEX LOGO - Bağımsız Buton
    Ekranın sol üst köşesinde, UI'dan bağımsız
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse

-- Ana Vortex UI Fonksiyonu
local Vortex = {}

function Vortex:CreateWindow(options)
    options = options or {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VortexUI"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- 📌 BAĞIMSIZ V LOGO BUTONU
    local logoButton = Instance.new("TextButton")
    logoButton.Name = "VortexLogo"
    logoButton.Size = UDim2.new(0, 47, 0, 42)
    logoButton.Position = UDim2.new(0, 15, 0, 15)  -- Sol üst köşe
    logoButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    logoButton.Text = "V"
    logoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    logoButton.TextSize = 18  -- Biraz büyük
    logoButton.Font = Enum.Font.GothamBlack
    logoButton.AutoButtonColor = false
    logoButton.ZIndex = 100
    logoButton.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = logoButton
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(200, 230, 255)
    stroke.Thickness = 1.6
    stroke.Parent = logoButton
    
    -- Logo parıltısı
    local glow = Instance.new("Frame")
    glow.Name = "LogoGlow"
    glow.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    glow.BackgroundTransparency = 0.8
    glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ZIndex = 99
    glow.Parent = logoButton
    
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(1, 0)
    glowCorner.Parent = glow
    
    -- Logo animasyonu
    coroutine.wrap(function()
        while logoButton and logoButton.Parent do
            TweenService:Create(glow, TweenInfo.new(1.5), {
                Size = UDim2.new(2, 0, 2, 0),
                BackgroundTransparency = 0.7
            }):Play()
            wait(1.5)
            TweenService:Create(glow, TweenInfo.new(1.5), {
                Size = UDim2.new(1.5, 0, 1.5, 0),
                BackgroundTransparency = 0.8
            }):Play()
            wait(1.5)
        end
    end)()
    
    -- Logo hover efekti
    logoButton.MouseEnter:Connect(function()
        TweenService:Create(logoButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 140, 255),
            Size = UDim2.new(0, 50, 0, 45)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 2
        }):Play()
    end)
    
    logoButton.MouseLeave:Connect(function()
        TweenService:Create(logoButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 255),
            Size = UDim2.new(0, 47, 0, 42)
        }):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {
            Color = Color3.fromRGB(200, 230, 255),
            Thickness = 1.6
        }):Play()
    end)
    
    -- 🎯 ANA PENCERE (Logo butonu ile kontrol edilecek)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(0, 120, 255)
    mainStroke.Thickness = 2
    mainStroke.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "Vortex UI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamSemibold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    -- Content
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- 📱 LOGO İLE UI KONTROLÜ
    local uiVisible = false
    
    logoButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        
        if uiVisible then
            -- UI'yi aç
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            
            TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 500, 0, 400)
            }):Play()
            
            TweenService:Create(logoButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(0, 180, 255),
                TextColor3 = Color3.fromRGB(0, 0, 0)
            }):Play()
        else
            -- UI'yi kapat
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            TweenService:Create(logoButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(0, 120, 255),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            
            wait(0.35)
            mainFrame.Visible = false
        end
    end)
    
    -- 🎮 TUŞ İLE KONTROL (Opsiyonel)
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.RightShift then
            uiVisible = not uiVisible
            
            if uiVisible then
                mainFrame.Visible = true
                TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
                    Size = UDim2.new(0, 500, 0, 400)
                }):Play()
            else
                TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()
                wait(0.35)
                mainFrame.Visible = false
            end
        end
    end)
    
    -- 📍 SÜRÜKLENEBİLİR LOGO
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
    
    -- 📍 SÜRÜKLENEBİLİR PENCERE
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
    
    -- 📁 TAB SİSTEMİ
    local window = {}
    window.Tabs = {}
    window.CurrentTab = nil
    
    -- Tabs Container
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Name = "Tabs"
    tabsContainer.Size = UDim2.new(0, 130, 1, 0)
    tabsContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    tabsContainer.Parent = content
    
    local tabsCorner = Instance.new("UICorner")
    tabsCorner.CornerRadius = UDim.new(0, 8)
    tabsCorner.Parent = tabsContainer
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentArea"
    contentContainer.Size = UDim2.new(1, -140, 1, 0)
    contentContainer.Position = UDim2.new(0, 140, 0, 0)
    contentContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    contentContainer.Parent = content
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentContainer
    
    -- Scroll Container
    local scrollContainer = Instance.new("ScrollingFrame")
    scrollContainer.Name = "Scroll"
    scrollContainer.Size = UDim2.new(1, -10, 1, -10)
    scrollContainer.Position = UDim2.new(0, 5, 0, 5)
    scrollContainer.BackgroundTransparency = 1
    scrollContainer.ScrollBarThickness = 4
    scrollContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
    scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scrollContainer.Parent = contentContainer
    
    local scrollLayout = Instance.new("UIListLayout")
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    scrollLayout.Padding = UDim.new(0, 8)
    scrollLayout.Parent = scrollContainer
    
    -- Tab List
    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.Size = UDim2.new(1, -10, 1, -10)
    tabList.Position = UDim2.new(0, 5, 0, 5)
    tabList.BackgroundTransparency = 1
    tabList.ScrollBarThickness = 3
    tabList.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.Parent = tabsContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabList
    
    -- Tab Oluşturma Fonksiyonu
    function window:CreateTab(name)
        local tab = {}
        
        -- Tab Butonu
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Size = UDim2.new(1, 0, 0, 35)
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(180, 180, 200)
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.AutoButtonColor = false
        tabButton.Parent = tabList
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        -- Tab Content
        local tabContent = Instance.new("Frame")
        tabContent.Name = name .. "Content"
        tabContent.Size = UDim2.new(1, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.AutomaticSize = Enum.AutomaticSize.Y
        tabContent.Visible = false
        tabContent.Parent = scrollContainer
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 8)
        contentLayout.Parent = tabContent
        
        -- Tab Seçimi
        local function SelectTab()
            if window.CurrentTab then
                window.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                window.CurrentTab.Button.TextColor3 = Color3.fromRGB(180, 180, 200)
                window.CurrentTab.Content.Visible = false
            end
            
            window.CurrentTab = tab
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabContent.Visible = true
        end
        
        tabButton.MouseButton1Click:Connect(SelectTab)
        
        -- İlk tab'ı seç
        if #tabList:GetChildren() == 1 then
            SelectTab()
        end
        
        tab.Button = tabButton
        tab.Content = tabContent
        
        -- ELEMENT FONKSİYONLARI
        
        -- Button
        function tab:CreateButton(options)
            options = options or {}
            local btnName = options.Name or "Button"
            local callback = options.Callback or function() end
            
            local btnFrame = Instance.new("Frame")
            btnFrame.Name = btnName .. "Button"
            btnFrame.Size = UDim2.new(1, 0, 0, 38)
            btnFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            btnFrame.Parent = tabContent
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btnFrame
            
            local btnLabel = Instance.new("TextLabel")
            btnLabel.Size = UDim2.new(1, -20, 1, 0)
            btnLabel.Position = UDim2.new(0, 10, 0, 0)
            btnLabel.BackgroundTransparency = 1
            btnLabel.Text = btnName
            btnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            btnLabel.TextSize = 14
            btnLabel.Font = Enum.Font.Gotham
            btnLabel.TextXAlignment = Enum.TextXAlignment.Left
            btnLabel.Parent = btnFrame
            
            local btnClick = Instance.new("TextButton")
            btnClick.Size = UDim2.new(1, 0, 1, 0)
            btnClick.BackgroundTransparency = 1
            btnClick.Text = ""
            btnClick.AutoButtonColor = false
            btnClick.Parent = btnFrame
            
            btnClick.MouseEnter:Connect(function()
                TweenService:Create(btnFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 70)
                }):Play()
            end)
            
            btnClick.MouseLeave:Connect(function()
                TweenService:Create(btnFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                }):Play()
            end)
            
            btnClick.MouseButton1Click:Connect(function()
                TweenService:Create(btnFrame, TweenInfo.new(0.1), {
                    Size = UDim2.new(0.98, 0, 0, 36)
                }):Play()
                wait(0.1)
                TweenService:Create(btnFrame, TweenInfo.new(0.1), {
                    Size = UDim2.new(1, 0, 0, 38)
                }):Play()
                callback()
            end)
            
            return {
                SetText = function(text)
                    btnLabel.Text = text
                end
            }
        end
        
        -- Toggle
        function tab:CreateToggle(options)
            options = options or {}
            local toggleName = options.Name or "Toggle"
            local defaultValue = options.Default or false
            local callback = options.Callback or function() end
            
            local value = defaultValue
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = toggleName .. "Toggle"
            toggleFrame.Size = UDim2.new(1, 0, 0, 38)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            toggleFrame.Parent = tabContent
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.7, -10, 1, 0)
            toggleLabel.Position = UDim2.new(0, 10, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = toggleName
            toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleLabel.TextSize = 14
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggleSwitch = Instance.new("Frame")
            toggleSwitch.Name = "Switch"
            toggleSwitch.Size = UDim2.new(0, 48, 0, 22)
            toggleSwitch.Position = UDim2.new(1, -58, 0.5, 0)
            toggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
            toggleSwitch.BackgroundColor3 = value and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(60, 60, 80)
            toggleSwitch.Parent = toggleFrame
            
            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(1, 0)
            switchCorner.Parent = toggleSwitch
            
            local toggleCircle = Instance.new("Frame")
            toggleCircle.Size = UDim2.new(0, 16, 0, 16)
            toggleCircle.Position = value and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
            toggleCircle.AnchorPoint = Vector2.new(0, 0.5)
            toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            toggleCircle.Parent = toggleSwitch
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = toggleCircle
            
            local toggleClick = Instance.new("TextButton")
            toggleClick.Size = UDim2.new(1, 0, 1, 0)
            toggleClick.BackgroundTransparency = 1
            toggleClick.Text = ""
            toggleClick.AutoButtonColor = false
            toggleClick.Parent = toggleFrame
            
            local function UpdateToggle()
                if value then
                    TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                    }):Play()
                    TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(1, -18, 0.5, 0)
                    }):Play()
                else
                    TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                    }):Play()
                    TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 3, 0.5, 0)
                    }):Play()
                end
                callback(value)
            end
            
            toggleClick.MouseButton1Click:Connect(function()
                value = not value
                UpdateToggle()
            end)
            
            UpdateToggle()
            
            return {
                Set = function(val)
                    value = val
                    UpdateToggle()
                end,
                Get = function()
                    return value
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
