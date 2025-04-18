--[[
  ALADIA SCRIPT LOADER - PREMIUM VERSION
  - Modern dark theme with soft purple accents
  - Sleek glassmorphism design elements
  - Smooth animations and transitions
  - Improved visual hierarchy
  - Enhanced readability
]]

local function CreateMainGUI()
    -- Color scheme - Dark theme with soft purple accents
    local colors = {
        darkBackground = Color3.fromRGB(15, 15, 20),
        darkerPanel = Color3.fromRGB(25, 25, 35),
        darkestPanel = Color3.fromRGB(20, 20, 30),
        textColor = Color3.fromRGB(240, 240, 245),
        accentColor = Color3.fromRGB(150, 110, 220),  -- Soft purple
        accentLight = Color3.fromRGB(180, 140, 240),  -- Lighter purple
        errorRed = Color3.fromRGB(220, 90, 100),
        successGreen = Color3.fromRGB(100, 220, 140),
        warningYellow = Color3.fromRGB(240, 190, 80),
        buttonHover = Color3.fromRGB(45, 40, 60),     -- Purple-tinged hover
        lightOff = Color3.fromRGB(50, 45, 65),
        glassEffect = Color3.fromRGB(30, 25, 45),
        trafficLight = {
            red = Color3.fromRGB(220, 90, 100),
            yellow = Color3.fromRGB(240, 190, 80),
            green = Color3.fromRGB(100, 220, 140)
        }
    }

    -- Main GUI with ZIndex handling
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "REP//GKDD | Aladia"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999

    -- Parent GUI safely
    local success, err = pcall(function()
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end)
    if not success then
        warn("Failed to parent GUI: "..tostring(err))
        return
    end

    -- Current Username
    local currentUsername = game.Players.LocalPlayer.Name

    -- Function to check user status from GitHub
    local function GetUserStatus()
        local success, whitelist = pcall(function()
            local response = game:HttpGet("https://raw.githubusercontent.com/CuneoTop/reposhi/refs/heads/main/list.lua", true)
            
            if not response or type(response) ~= "string" or response:len() < 5 then
                error("Invalid whitelist response")
            end
            
            if response:find("<html") or response:find("<!DOCTYPE") then
                error("Whitelist not found")
            end
            
            return response
        end)

        if not success then
            warn("[ALADIA LOADER] Whitelist fetch error: "..tostring(whitelist))
            return {
                blacklisted = false,
                needsPurchase = false,
                note = "",
                expirationDate = "UNKNOWN"
            }
        end

        local status = {
            blacklisted = false,
            needsPurchase = false,
            note = "",
            expirationDate = "NOT FOUND"
        }
        
        for line in whitelist:gmatch("[^\r\n]+") do
            local user, blacklistStatus = line:match("Usn:%s*(.-)%s*|%s*Blacklist:%s*(%S+)")
            if user and blacklistStatus then
                if string.lower(user) == string.lower(currentUsername) and string.lower(blacklistStatus) == "true" then
                    status.blacklisted = true
                end
            end
            
            local user, needsBuy = line:match("Usn:%s*(.-)%s*|%s*Nbuy:%s*(%S+)")
            if user and needsBuy then
                if string.lower(user) == string.lower(currentUsername) and string.lower(needsBuy) == "true" then
                    status.needsPurchase = true
                end
            end
            
            local user, note = line:match("Usn:%s*(.-)%s*|%s*Note:%s*(.+)")
            if user and note then
                if string.lower(user) == string.lower(currentUsername) then
                    status.note = note
                end
            end
            
            local user, key, exp = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Exp:%s*(.+)")
            if user and key and exp then
                if string.lower(user) == string.lower(currentUsername) then
                    status.expirationDate = exp
                end
            end
        end
        
        return status
    end

    -- Check user status
    local userStatus = GetUserStatus()

    -- Modern glassmorphism effect function
    local function CreateGlassEffect(parent, size, position, transparency)
        local glassFrame = Instance.new("Frame")
        glassFrame.Name = "GlassEffect"
        glassFrame.BackgroundColor3 = colors.glassEffect
        glassFrame.BackgroundTransparency = transparency or 0.7
        glassFrame.Size = size
        glassFrame.Position = position
        glassFrame.Parent = parent
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = glassFrame
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = colors.accentColor
        UIStroke.Thickness = 1
        UIStroke.Transparency = 0.8
        UIStroke.Parent = glassFrame
        
        return glassFrame
    end

    -- Main container with glassmorphism design
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = colors.darkerPanel
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 400, 0, 350)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.ClipsDescendants = true

    -- Add glass effect
    CreateGlassEffect(MainFrame, UDim2.new(1, -10, 1, -10), UDim2.new(0, 5, 0, 5), 0.8)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Header with gradient
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundColor3 = colors.darkestPanel
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 60)
    
    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Rotation = 90
    HeaderGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, colors.darkestPanel),
        ColorSequenceKeypoint.new(1, colors.accentColor:lerp(colors.darkestPanel, 0.7))
    })
    HeaderGradient.Parent = Header
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 12)
    HeaderCorner.Parent = Header

    -- Close button (modern X)
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Header
    CloseButton.BackgroundTransparency = 1
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Position = UDim2.new(1, -32, 0.5, -12)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(924, 724)
    CloseButton.ImageRectSize = Vector2.new(36, 36)
    CloseButton.ImageColor3 = Color3.fromRGB(180, 180, 180)
    CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)

    -- Close button hover effect
    CloseButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
            ImageColor3 = colors.errorRed,
            Rotation = 90
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(180, 180, 180),
            Rotation = 0
        }):Play()
    end)
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        task.wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Traffic light container with modern design
    local TrafficLight = Instance.new("Frame")
    TrafficLight.Name = "TrafficLight"
    TrafficLight.Parent = Header
    TrafficLight.BackgroundColor3 = colors.darkestPanel
    TrafficLight.Size = UDim2.new(0, 80, 0, 24)
    TrafficLight.Position = UDim2.new(0, 15, 0.5, -12)
    TrafficLight.AnchorPoint = Vector2.new(0, 0.5)
    
    local TrafficLightCorner = Instance.new("UICorner")
    TrafficLightCorner.CornerRadius = UDim.new(1, 0)
    TrafficLightCorner.Parent = TrafficLight
    
    local LightContainer = Instance.new("Frame")
    LightContainer.Name = "LightContainer"
    LightContainer.Parent = TrafficLight
    LightContainer.BackgroundTransparency = 1
    LightContainer.Size = UDim2.new(1, -16, 1, -8)
    LightContainer.Position = UDim2.new(0, 8, 0, 4)
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = LightContainer
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    
    -- Red light
    local RedLight = Instance.new("Frame")
    RedLight.Name = "RedLight"
    RedLight.Parent = LightContainer
    RedLight.BackgroundColor3 = colors.lightOff
    RedLight.Size = UDim2.new(0, 16, 0, 16)
    RedLight.LayoutOrder = 1
    
    local UICornerRed = Instance.new("UICorner")
    UICornerRed.CornerRadius = UDim.new(1, 0)
    UICornerRed.Parent = RedLight
    
    -- Yellow light
    local YellowLight = Instance.new("Frame")
    YellowLight.Name = "YellowLight"
    YellowLight.Parent = LightContainer
    YellowLight.BackgroundColor3 = colors.lightOff
    YellowLight.Size = UDim2.new(0, 16, 0, 16)
    YellowLight.LayoutOrder = 2
    
    local UICornerYellow = Instance.new("UICorner")
    UICornerYellow.CornerRadius = UDim.new(1, 0)
    UICornerYellow.Parent = YellowLight
    
    -- Green light
    local GreenLight = Instance.new("Frame")
    GreenLight.Name = "GreenLight"
    GreenLight.Parent = LightContainer
    GreenLight.BackgroundColor3 = colors.lightOff
    GreenLight.Size = UDim2.new(0, 16, 0, 16)
    GreenLight.LayoutOrder = 3
    
    local UICornerGreen = Instance.new("UICorner")
    UICornerGreen.CornerRadius = UDim.new(1, 0)
    UICornerGreen.Parent = GreenLight
    
    -- Animated startup sequence for traffic lights
    task.spawn(function()
        -- Initial delay
        task.wait(0.5)
        
        -- Turn on red
        game:GetService("TweenService"):Create(RedLight, TweenInfo.new(0.3), {
            BackgroundColor3 = colors.trafficLight.red
        }):Play()
        task.wait(3.5)
        
        -- Turn on yellow
        game:GetService("TweenService"):Create(YellowLight, TweenInfo.new(0.3), {
            BackgroundColor3 = colors.trafficLight.yellow
        }):Play()
        task.wait(3.5)
        
        -- Turn on green
        game:GetService("TweenService"):Create(GreenLight, TweenInfo.new(0.3), {
            BackgroundColor3 = colors.trafficLight.green
        }):Play()
        task.wait(15)
        
        -- Final state based on user status
        if userStatus.blacklisted then
            game:GetService("TweenService"):Create(YellowLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
            game:GetService("TweenService"):Create(GreenLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
        elseif userStatus.needsPurchase then
            game:GetService("TweenService"):Create(RedLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
            game:GetService("TweenService"):Create(GreenLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
        else
            game:GetService("TweenService"):Create(RedLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
            game:GetService("TweenService"):Create(YellowLight, TweenInfo.new(0.3), {
                BackgroundColor3 = colors.lightOff
            }):Play()
        end
    end)

    -- Title with subtle glow
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 130, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "REP//GKDD | Aladia"
    Title.TextColor3 = colors.textColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Color = colors.accentLight
    TitleStroke.Thickness = 0.5
    TitleStroke.Transparency = 0.7
    TitleStroke.Parent = Title

    -- Notification function with modern design
    local function ShowNotification(message, color)
        color = color or colors.accentColor
        
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Parent = ScreenGui
        Notification.BackgroundColor3 = colors.darkestPanel
        Notification.Size = UDim2.new(0, 300, 0, 60)
        Notification.Position = UDim2.new(0.5, -150, 1, 0)
        Notification.AnchorPoint = Vector2.new(0.5, 0)
        
        CreateGlassEffect(Notification, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.8)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Notification
        
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Color = color
        UIStroke.Thickness = 1
        UIStroke.Transparency = 0.5
        UIStroke.Parent = Notification
        
        local Icon = Instance.new("ImageLabel")
        Icon.Name = "Icon"
        Icon.Parent = Notification
        Icon.BackgroundTransparency = 1
        Icon.Size = UDim2.new(0, 24, 0, 24)
        Icon.Position = UDim2.new(0, 15, 0.5, -12)
        Icon.Image = "rbxassetid://3926305904"
        Icon.ImageRectOffset = Vector2.new(964, 324)
        Icon.ImageRectSize = Vector2.new(36, 36)
        Icon.ImageColor3 = color
        
        local NotifText = Instance.new("TextLabel")
        NotifText.Name = "NotifText"
        NotifText.Parent = Notification
        NotifText.BackgroundTransparency = 1
        NotifText.Size = UDim2.new(1, -50, 1, -20)
        NotifText.Position = UDim2.new(0, 50, 0, 10)
        NotifText.Font = Enum.Font.GothamMedium
        NotifText.Text = message
        NotifText.TextColor3 = colors.textColor
        NotifText.TextSize = 14
        NotifText.TextXAlignment = Enum.TextXAlignment.Left
        NotifText.TextWrapped = true
        
        Notification.BackgroundTransparency = 1
        NotifText.TextTransparency = 1
        Icon.ImageTransparency = 1
        
        game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -150, 1, -70),
            BackgroundTransparency = 0.2
        }):Play()
        
        game:GetService("TweenService"):Create(NotifText, TweenInfo.new(0.3), {
            TextTransparency = 0
        }):Play()
        
        game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.3), {
            ImageTransparency = 0
        }):Play()
        
        task.wait(3)
        
        game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -150, 1, 0),
            BackgroundTransparency = 1
        }):Play()
        
        game:GetService("TweenService"):Create(NotifText, TweenInfo.new(0.3), {
            TextTransparency = 1
        }):Play()
        
        game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.3), {
            ImageTransparency = 1
        }):Play()
        
        task.wait(0.3)
        Notification:Destroy()
    end

    -- Menu button (modern discord icon)
    local MenuButton = Instance.new("ImageButton")
    MenuButton.Name = "MenuButton"
    MenuButton.Parent = MainFrame
    MenuButton.BackgroundTransparency = 1
    MenuButton.Size = UDim2.new(0, 32, 0, 32)
    MenuButton.Position = UDim2.new(1, -40, 1.02, -40)
    MenuButton.Image = "rbxassetid://3926305904"
    MenuButton.ImageRectOffset = Vector2.new(964, 324)
    MenuButton.ImageRectSize = Vector2.new(36, 36)
    MenuButton.ImageColor3 = colors.accentColor
    MenuButton.ZIndex = 2

    MenuButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(MenuButton, TweenInfo.new(0.2), {
            ImageColor3 = colors.accentLight,
            Rotation = 15
        }):Play()
    end)
    
    MenuButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(MenuButton, TweenInfo.new(0.2), {
            ImageColor3 = colors.accentColor,
            Rotation = 0
        }):Play()
    end)
    
    MenuButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/eJ7zxVTq")
        ShowNotification("Discord link copied to clipboard!", colors.successGreen)
    end)

    -- If user is blacklisted, show message and return
    if userStatus.blacklisted then
        -- Warning container
        local WarningContainer = Instance.new("Frame")
        WarningContainer.Name = "WarningContainer"
        WarningContainer.Parent = MainFrame
        WarningContainer.BackgroundTransparency = 1
        WarningContainer.Size = UDim2.new(1, -40, 1, -100)
        WarningContainer.Position = UDim2.new(0, 20, 0, 80)
        
        -- Warning icon
        local WarningIcon = Instance.new("ImageLabel")
        WarningIcon.Name = "WarningIcon"
        WarningIcon.Parent = WarningContainer
        WarningIcon.BackgroundTransparency = 1
        WarningIcon.Size = UDim2.new(0, 64, 0, 64)
        WarningIcon.Position = UDim2.new(0.5, -32, 0, 0)
        WarningIcon.Image = "rbxassetid://3926305904"
        WarningIcon.ImageRectOffset = Vector2.new(364, 364)
        WarningIcon.ImageRectSize = Vector2.new(36, 36)
        WarningIcon.ImageColor3 = colors.errorRed
        
        -- Warning text
        local WarningText = Instance.new("TextLabel")
        WarningText.Name = "WarningText"
        WarningText.Parent = WarningContainer
        WarningText.BackgroundTransparency = 1
        WarningText.Size = UDim2.new(1, 0, 0, 40)
        WarningText.Position = UDim2.new(0, 0, 0, 80)
        WarningText.Font = Enum.Font.GothamBold
        WarningText.Text = "ACCOUNT BLACKLISTED"
        WarningText.TextColor3 = colors.errorRed
        WarningText.TextSize = 20
        WarningText.TextWrapped = true
        
        -- Blacklist message
        local BlacklistMessage = Instance.new("TextLabel")
        BlacklistMessage.Name = "BlacklistMessage"
        BlacklistMessage.Parent = WarningContainer
        BlacklistMessage.BackgroundTransparency = 1
        BlacklistMessage.Size = UDim2.new(1, 0, 0.5, 0)
        BlacklistMessage.Position = UDim2.new(0, 0, 0, 130)
        BlacklistMessage.Font = Enum.Font.Gotham
        BlacklistMessage.Text = "Your account has been blacklisted from using this script.\n\nContact support if you believe this is an error."
        BlacklistMessage.TextColor3 = colors.textColor
        BlacklistMessage.TextSize = 14
        BlacklistMessage.TextWrapped = true
        
        -- Disable all functionality
        return
    end

    -- Premium Button with hover effects
    local PremiumButton = Instance.new("TextButton")
    PremiumButton.Name = "PremiumButton"
    PremiumButton.Parent = MainFrame
    PremiumButton.BackgroundColor3 = colors.darkestPanel
    PremiumButton.Position = UDim2.new(0.5, 0, 0.3, 0)
    PremiumButton.Size = UDim2.new(0, 300, 0, 50)
    PremiumButton.Font = Enum.Font.GothamBold
    PremiumButton.Text = "PREMIUM ACCESS"
    PremiumButton.TextColor3 = colors.textColor
    PremiumButton.TextSize = 16
    PremiumButton.AutoButtonColor = false
    PremiumButton.AnchorPoint = Vector2.new(0.5, 0)

    CreateGlassEffect(PremiumButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)

    local PremiumCorner = Instance.new("UICorner")
    PremiumCorner.CornerRadius = UDim.new(0, 8)
    PremiumCorner.Parent = PremiumButton

    local PremiumStroke = Instance.new("UIStroke")
    PremiumStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    PremiumStroke.Color = colors.accentLight
    PremiumStroke.Thickness = 1
    PremiumStroke.Transparency = 0.7
    PremiumStroke.Parent = PremiumButton

    -- Hover effects
    PremiumButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.buttonHover,
            TextColor3 = colors.accentLight
        }):Play()
        game:GetService("TweenService"):Create(PremiumStroke, TweenInfo.new(0.2), {
            Transparency = 0.3
        }):Play()
    end)
    
    PremiumButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.darkestPanel,
            TextColor3 = colors.textColor
        }):Play()
        game:GetService("TweenService"):Create(PremiumStroke, TweenInfo.new(0.2), {
            Transparency = 0.7
        }):Play()
    end)

    -- Basic Button with hover effects
    local BasicButton = Instance.new("TextButton")
    BasicButton.Name = "BasicButton"
    BasicButton.Parent = MainFrame
    BasicButton.BackgroundColor3 = colors.darkestPanel
    BasicButton.Position = UDim2.new(0.5, 0, 0.5, 0)
    BasicButton.Size = UDim2.new(0, 300, 0, 50)
    BasicButton.Font = Enum.Font.GothamBold
    BasicButton.Text = "BASIC SCRIPT"
    BasicButton.TextColor3 = colors.textColor
    BasicButton.TextSize = 16
    BasicButton.AutoButtonColor = false
    BasicButton.AnchorPoint = Vector2.new(0.5, 0)

    CreateGlassEffect(BasicButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)

    local BasicCorner = Instance.new("UICorner")
    BasicCorner.CornerRadius = UDim.new(0, 8)
    BasicCorner.Parent = BasicButton

    local BasicStroke = Instance.new("UIStroke")
    BasicStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    BasicStroke.Color = colors.accentLight
    BasicStroke.Thickness = 1
    BasicStroke.Transparency = 0.7
    BasicStroke.Parent = BasicButton

    -- Hover effects
    BasicButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.buttonHover,
            TextColor3 = colors.accentLight
        }):Play()
        game:GetService("TweenService"):Create(BasicStroke, TweenInfo.new(0.2), {
            Transparency = 0.3
        }):Play()
    end)
    
    BasicButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.2), {
            BackgroundColor3 = colors.darkestPanel,
            TextColor3 = colors.textColor
        }):Play()
        game:GetService("TweenService"):Create(BasicStroke, TweenInfo.new(0.2), {
            Transparency = 0.7
        }):Play()
    end)

    -- Footer with subtle gradient
    local Footer = Instance.new("Frame")
    Footer.Name = "Footer"
    Footer.Parent = MainFrame
    Footer.BackgroundColor3 = colors.darkestPanel
    Footer.BorderSizePixel = 0
    Footer.Position = UDim2.new(0, 0, 0.9, 0)
    Footer.Size = UDim2.new(1, 0, 0, 35)
    
    local FooterGradient = Instance.new("UIGradient")
    FooterGradient.Rotation = 90
    FooterGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, colors.darkestPanel),
        ColorSequenceKeypoint.new(1, colors.accentColor:lerp(colors.darkestPanel, 0.7))
    })
    FooterGradient.Parent = Footer
    
    local FooterText = Instance.new("TextLabel")
    FooterText.Name = "FooterText"
    FooterText.Parent = Footer
    FooterText.BackgroundTransparency = 1
    FooterText.Size = UDim2.new(1, 0, 1, 0)
    FooterText.Font = Enum.Font.Gotham
    FooterText.Text = "XEL ON TOP MADAFAKA"
    FooterText.TextColor3 = Color3.fromRGB(150, 150, 150)
    FooterText.TextSize = 12

    -- Time-based expiration check
    local function IsKeyExpired(expDateTime)
        local day, month, year, hour, minute = expDateTime:match("(%d+)/(%d+)/(%d+)%s+(%d+):(%d+)")
        if not day or not month or not year or not hour or not minute then
            day, month, year = expDateTime:match("(%d+)/(%d+)/(%d+)")
            if not day or not month or not year then
                return true
            end
            hour = "23"
            minute = "59"
        end
        
        day = tonumber(day)
        month = tonumber(month)
        year = tonumber(year)
        hour = tonumber(hour)
        minute = tonumber(minute)
        
        local currentDateTime = os.date("*t")
        
        if year > currentDateTime.year then
            return false
        elseif year < currentDateTime.year then
            return true
        else
            if month > currentDateTime.month then
                return false
            elseif month < currentDateTime.month then
                return true
            else
                if day > currentDateTime.day then
                    return false
                elseif day < currentDateTime.day then
                    return true
                else
                    if hour > currentDateTime.hour then
                        return false
                    elseif hour < currentDateTime.hour then
                        return true
                    else
                        return minute < currentDateTime.min
                    end
                end
            end
        end
    end

    -- Full-screen note display with modern design
    local function ShowFullScreenNote(message)
        local NoteOverlay = Instance.new("Frame")
        NoteOverlay.Name = "NoteOverlay"
        NoteOverlay.Parent = ScreenGui
        NoteOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
        NoteOverlay.BackgroundTransparency = 0.7
        NoteOverlay.Size = UDim2.new(1, 0, 1, 0)
        NoteOverlay.ZIndex = 50
        
        local NoteContainer = Instance.new("Frame")
        NoteContainer.Name = "NoteContainer"
        NoteContainer.Parent = NoteOverlay
        NoteContainer.BackgroundColor3 = colors.darkerPanel
        NoteContainer.Size = UDim2.new(0.9, 0, 0.9, 0)
        NoteContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        NoteContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        NoteContainer.ZIndex = 51
        
        CreateGlassEffect(NoteContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.8)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = NoteContainer
        
        local TitleBar = Instance.new("Frame")
        TitleBar.Name = "TitleBar"
        TitleBar.Parent = NoteContainer
        TitleBar.BackgroundColor3 = colors.darkestPanel
        TitleBar.Size = UDim2.new(1, 0, 0, 60)
        TitleBar.Position = UDim2.new(0, 0, 0, 0)
        
        local TitleBarGradient = Instance.new("UIGradient")
        TitleBarGradient.Rotation = 90
        TitleBarGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, colors.darkestPanel),
            ColorSequenceKeypoint.new(1, colors.accentColor:lerp(colors.darkestPanel, 0.7))
        })
        TitleBarGradient.Parent = TitleBar
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Parent = TitleBar
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, -40, 1, 0)
        Title.Position = UDim2.new(0, 20, 0, 0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = "ALADIA SCRIPT NOTIFICATION"
        Title.TextColor3 = colors.textColor
        Title.TextSize = 20
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.ZIndex = 52
        
        local WarningIcon = Instance.new("ImageLabel")
        WarningIcon.Name = "WarningIcon"
        WarningIcon.Parent = TitleBar
        WarningIcon.BackgroundTransparency = 1
        WarningIcon.Size = UDim2.new(0, 32, 0, 32)
        WarningIcon.Position = UDim2.new(1, -40, 0.5, -16)
        WarningIcon.Image = "rbxassetid://3926305904"
        WarningIcon.ImageRectOffset = Vector2.new(364, 364)
        WarningIcon.ImageRectSize = Vector2.new(36, 36)
        WarningIcon.ImageColor3 = colors.warningYellow
        WarningIcon.ZIndex = 52
        
        local ScrollFrame = Instance.new("ScrollingFrame")
        ScrollFrame.Name = "ScrollFrame"
        ScrollFrame.Parent = NoteContainer
        ScrollFrame.BackgroundTransparency = 1
        ScrollFrame.Size = UDim2.new(1, -40, 0.7, 0)
        ScrollFrame.Position = UDim2.new(0, 20, 0.2, 0)
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollFrame.ScrollBarThickness = 8
        ScrollFrame.ScrollBarImageColor3 = colors.accentColor
        ScrollFrame.ZIndex = 52
        ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        
        local MessageText = Instance.new("TextLabel")
        MessageText.Name = "MessageText"
        MessageText.Parent = ScrollFrame
        MessageText.BackgroundTransparency = 1
        MessageText.Size = UDim2.new(1, 0, 0, 0)
        MessageText.Font = Enum.Font.Gotham
        MessageText.Text = message
        MessageText.TextColor3 = colors.textColor
        MessageText.TextSize = 16
        MessageText.TextWrapped = true
        MessageText.TextXAlignment = Enum.TextXAlignment.Left
        MessageText.TextYAlignment = Enum.TextYAlignment.Top
        MessageText.AutomaticSize = Enum.AutomaticSize.Y
        MessageText.ZIndex = 52
        
        MessageText:GetPropertyChangedSignal("TextBounds"):Connect(function()
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, MessageText.TextBounds.Y + 20)
        end)
        
        local CloseButton = Instance.new("TextButton")
        CloseButton.Name = "CloseButton"
        CloseButton.Parent = NoteContainer
        CloseButton.BackgroundColor3 = colors.darkestPanel
        CloseButton.Size = UDim2.new(0.6, 0, 0, 50)
        CloseButton.Position = UDim2.new(0.2, 0, 0.9, -25)
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.Text = "CLOSE MESSAGE"
        CloseButton.TextColor3 = colors.textColor
        CloseButton.TextSize = 16
        CloseButton.AutoButtonColor = false
        CloseButton.ZIndex = 52
        
        CreateGlassEffect(CloseButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0, 8)
        UICorner2.Parent = CloseButton
        
        CloseButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.buttonHover,
                TextColor3 = colors.accentLight
            }):Play()
        end)
        
        CloseButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.darkestPanel,
                TextColor3 = colors.textColor
            }):Play()
        end)
        
        CloseButton.MouseButton1Click:Connect(function()
            game:GetService("TweenService"):Create(NoteOverlay, TweenInfo.new(0.3), {
                BackgroundTransparency = 1
            }):Play()
            game:GetService("TweenService"):Create(NoteContainer, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.3)
            NoteOverlay:Destroy()
        end)
        
        NoteOverlay.BackgroundTransparency = 1
        NoteContainer.Size = UDim2.new(0, 0, 0, 0)
        
        game:GetService("TweenService"):Create(NoteOverlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.7
        }):Play()
        
        game:GetService("TweenService"):Create(NoteContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0.9, 0, 0.9, 0)
        }):Play()
    end

    -- Modern confirmation dialog
    local function CreateConfirmationDialog(title, message, confirmCallback)
        local Overlay = Instance.new("Frame")
        Overlay.Name = "ConfirmationOverlay"
        Overlay.Parent = ScreenGui
        Overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        Overlay.BackgroundTransparency = 0.8
        Overlay.Size = UDim2.new(1, 0, 1, 0)
        Overlay.ZIndex = 10
        
        local DialogFrame = Instance.new("Frame")
        DialogFrame.Name = "DialogFrame"
        DialogFrame.Parent = Overlay
        DialogFrame.BackgroundColor3 = colors.darkerPanel
        DialogFrame.Size = UDim2.new(0, 350, 0, 220)
        DialogFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
        DialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DialogFrame.ZIndex = 11
        
        CreateGlassEffect(DialogFrame, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.8)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = DialogFrame
        
        local DialogTitle = Instance.new("TextLabel")
        DialogTitle.Name = "DialogTitle"
        DialogTitle.Parent = DialogFrame
        DialogTitle.BackgroundTransparency = 1
        DialogTitle.Size = UDim2.new(1, -20, 0, 50)
        DialogTitle.Position = UDim2.new(0, 20, 0, 10)
        DialogTitle.Font = Enum.Font.GothamBold
        DialogTitle.Text = title
        DialogTitle.TextColor3 = colors.accentColor
        DialogTitle.TextSize = 20
        DialogTitle.TextXAlignment = Enum.TextXAlignment.Left
        DialogTitle.ZIndex = 12
        
        local DialogMessage = Instance.new("TextLabel")
        DialogMessage.Name = "DialogMessage"
        DialogMessage.Parent = DialogFrame
        DialogMessage.BackgroundTransparency = 1
        DialogMessage.Size = UDim2.new(1, -40, 0, 80)
        DialogMessage.Position = UDim2.new(0, 20, 0, 70)
        DialogMessage.Font = Enum.Font.Gotham
        DialogMessage.Text = message
        DialogMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
        DialogMessage.TextSize = 14
        DialogMessage.TextWrapped = true
        DialogMessage.ZIndex = 12
        
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = "ButtonContainer"
        ButtonContainer.Parent = DialogFrame
        ButtonContainer.BackgroundTransparency = 1
        ButtonContainer.Size = UDim2.new(1, -40, 0, 50)
        ButtonContainer.Position = UDim2.new(0, 20, 1, -60)
        ButtonContainer.ZIndex = 12
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = ButtonContainer
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 15)
        
        local NoButton = Instance.new("TextButton")
        NoButton.Name = "NoButton"
        NoButton.Parent = ButtonContainer
        NoButton.BackgroundColor3 = colors.darkestPanel
        NoButton.Size = UDim2.new(0.4, 0, 1, 0)
        NoButton.Font = Enum.Font.GothamMedium
        NoButton.Text = "NO"
        NoButton.TextColor3 = colors.textColor
        NoButton.TextSize = 14
        NoButton.AutoButtonColor = false
        NoButton.LayoutOrder = 1
        NoButton.ZIndex = 13
        
        CreateGlassEffect(NoButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        local YesButton = Instance.new("TextButton")
        YesButton.Name = "YesButton"
        YesButton.Parent = ButtonContainer
        YesButton.BackgroundColor3 = colors.darkestPanel
        YesButton.Size = UDim2.new(0.4, 0, 1, 0)
        YesButton.Font = Enum.Font.GothamMedium
        YesButton.Text = "YES"
        YesButton.TextColor3 = colors.textColor
        YesButton.TextSize = 14
        YesButton.AutoButtonColor = false
        YesButton.LayoutOrder = 2
        YesButton.ZIndex = 13
        
        CreateGlassEffect(YesButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        -- Button hover effects
        NoButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(NoButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.buttonHover,
                TextColor3 = colors.errorRed
            }):Play()
        end)
        
        NoButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(NoButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.darkestPanel,
                TextColor3 = colors.textColor
            }):Play()
        end)
        
        YesButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(YesButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.buttonHover,
                TextColor3 = colors.successGreen
            }):Play()
        end)
        
        YesButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(YesButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.darkestPanel,
                TextColor3 = colors.textColor
            }):Play()
        end)
        
        local function CloseDialog()
            game:GetService("TweenService"):Create(DialogFrame, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            game:GetService("TweenService"):Create(Overlay, TweenInfo.new(0.2), {
                BackgroundTransparency = 1
            }):Play()
            
            task.wait(0.2)
            Overlay:Destroy()
        end
        
        YesButton.MouseButton1Click:Connect(function()
            CloseDialog()
            confirmCallback(true)
        end)
        
        NoButton.MouseButton1Click:Connect(function()
            CloseDialog()
            confirmCallback(false)
        end)
        
        DialogFrame.Size = UDim2.new(0, 0, 0, 0)
        DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        game:GetService("TweenService"):Create(DialogFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 350, 0, 220),
            Position = UDim2.new(0.5, -175, 0.5, -110)
        }):Play()
    end

    -- Premium Button Functionality with modern design
    PremiumButton.MouseButton1Click:Connect(function()
        
        -- Animate button press
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 290, 0, 45)
        }):Play()
        game:GetService("TweenService"):Create(PremiumButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 300, 0, 50)
        }):Play()
        
        PremiumButton.Visible = false
        BasicButton.Visible = false
        Title.Text = "ENTER LICENSE KEY"
        
        local LicenseFrame = Instance.new("Frame")
        LicenseFrame.Name = "LicenseFrame"
        LicenseFrame.Parent = MainFrame
        LicenseFrame.BackgroundTransparency = 1
        LicenseFrame.Size = UDim2.new(1, 0, 1, -60)
        LicenseFrame.Position = UDim2.new(0, 0, 0, 60)
        
        -- Account info with expiration date
        local AccountInfo = Instance.new("Frame")
        AccountInfo.Name = "AccountInfo"
        AccountInfo.Parent = LicenseFrame
        AccountInfo.BackgroundTransparency = 1
        AccountInfo.Size = UDim2.new(1, -40, 0, 40)
        AccountInfo.Position = UDim2.new(0, 20, 0, 10)
        
        local UsernameLabel = Instance.new("TextLabel")
        UsernameLabel.Name = "UsernameLabel"
        UsernameLabel.Parent = AccountInfo
        UsernameLabel.BackgroundTransparency = 1
        UsernameLabel.Size = UDim2.new(0.5, 0, 1, 0)
        UsernameLabel.Font = Enum.Font.GothamBold
        UsernameLabel.Text = "ACCOUNT: "..string.upper(currentUsername)
        UsernameLabel.TextColor3 = colors.accentColor
        UsernameLabel.TextSize = 14
        UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local ExpirationLabel = Instance.new("TextLabel")
        ExpirationLabel.Name = "ExpirationLabel"
        ExpirationLabel.Parent = AccountInfo
        ExpirationLabel.BackgroundTransparency = 1
        ExpirationLabel.Size = UDim2.new(0.5, 0, 1, 0)
        ExpirationLabel.Position = UDim2.new(0.5, 0, 0, 0)
        ExpirationLabel.Font = Enum.Font.GothamBold
        ExpirationLabel.Text = "EXP: "..userStatus.expirationDate
        ExpirationLabel.TextColor3 = colors.accentLight
        ExpirationLabel.TextSize = 14
        ExpirationLabel.TextXAlignment = Enum.TextXAlignment.Right
        
        local StatusLabel = Instance.new("TextLabel")
        StatusLabel.Name = "StatusLabel"
        StatusLabel.Parent = LicenseFrame
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 20, 0.2, 0)
        StatusLabel.Size = UDim2.new(1, -40, 0, 20)
        StatusLabel.Font = Enum.Font.GothamBold
        StatusLabel.Text = ""
        StatusLabel.TextColor3 = colors.errorRed
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        local KeyInputContainer = Instance.new("Frame")
        KeyInputContainer.Name = "KeyInputContainer"
        KeyInputContainer.Parent = LicenseFrame
        KeyInputContainer.BackgroundColor3 = colors.darkestPanel
        KeyInputContainer.Position = UDim2.new(0.5, 0, 0.3, 0)
        KeyInputContainer.Size = UDim2.new(0, 280, 0, 50)
        KeyInputContainer.AnchorPoint = Vector2.new(0.5, 0)
        
        CreateGlassEffect(KeyInputContainer, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = KeyInputContainer
        
        local KeyInput = Instance.new("TextBox")
        KeyInput.Name = "KeyInput"
        KeyInput.Parent = KeyInputContainer
        KeyInput.BackgroundTransparency = 1
        KeyInput.Size = UDim2.new(1, 0, 1, 0)
        KeyInput.Position = UDim2.new(0, 0, 0, 0)
        KeyInput.Font = Enum.Font.Gotham
        KeyInput.PlaceholderText = "ENTER YOUR LICENSE KEY"
        KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        KeyInput.Text = ""
        KeyInput.TextColor3 = colors.textColor
        KeyInput.TextSize = 14
        KeyInput.ClearTextOnFocus = false
        
        local VerifyButton = Instance.new("TextButton")
        VerifyButton.Name = "VerifyButton"
        VerifyButton.Parent = LicenseFrame
        VerifyButton.BackgroundColor3 = colors.darkestPanel
        VerifyButton.Position = UDim2.new(0.5, 0, 0.5, 0)
        VerifyButton.Size = UDim2.new(0, 280, 0, 50)
        VerifyButton.Font = Enum.Font.GothamBold
        VerifyButton.Text = "VERIFY KEY"
        VerifyButton.TextColor3 = colors.textColor
        VerifyButton.TextSize = 16
        VerifyButton.AutoButtonColor = false
        VerifyButton.AnchorPoint = Vector2.new(0.5, 0)
        
        CreateGlassEffect(VerifyButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        local UICorner2 = Instance.new("UICorner")
        UICorner2.CornerRadius = UDim.new(0, 8)
        UICorner2.Parent = VerifyButton
        
        local BackButton = Instance.new("TextButton")
        BackButton.Name = "BackButton"
        BackButton.Parent = LicenseFrame
        BackButton.BackgroundColor3 = colors.darkestPanel
        BackButton.Position = UDim2.new(0.5, 0, 0.7, 0)
        BackButton.Size = UDim2.new(0, 280, 0, 50)
        BackButton.Font = Enum.Font.GothamBold
        BackButton.Text = "BACK"
        BackButton.TextColor3 = colors.textColor
        BackButton.TextSize = 16
        BackButton.AutoButtonColor = false
        BackButton.AnchorPoint = Vector2.new(0.5, 0)
        
        CreateGlassEffect(BackButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
        
        local UICorner3 = Instance.new("UICorner")
        UICorner3.CornerRadius = UDim.new(0, 8)
        UICorner3.Parent = BackButton
        
        -- Button hover effects
        VerifyButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.buttonHover,
                TextColor3 = colors.accentLight
            }):Play()
        end)
        
        VerifyButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.darkestPanel,
                TextColor3 = colors.textColor
            }):Play()
        end)
        
        BackButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.buttonHover,
                TextColor3 = colors.accentLight
            }):Play()
        end)
        
        BackButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                BackgroundColor3 = colors.darkestPanel,
                TextColor3 = colors.textColor
            }):Play()
        end)
        
        local isVerifying = false
        
        VerifyButton.MouseButton1Click:Connect(function()
            if isVerifying then return end
            isVerifying = true
            
            -- Animate button press
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 270, 0, 45)
            }):Play()
            game:GetService("TweenService"):Create(VerifyButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 280, 0, 50)
            }):Play()
            
            VerifyButton.Text = "VERIFYING..."
            VerifyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            
            local enteredKey = KeyInput.Text
            enteredKey = string.upper(enteredKey:gsub("%s+", ""))
            
            if enteredKey == "" then
                StatusLabel.Text = "PLEASE ENTER A VALID KEY"
                isVerifying = false
                VerifyButton.Text = "VERIFY KEY"
                VerifyButton.BackgroundColor3 = colors.darkestPanel
                return
            end

            local success, whitelist = pcall(function()
                local response = game:HttpGet("https://raw.githubusercontent.com/CuneoTop/reposhi/refs/heads/main/list.lua", true)
                
                if not response or type(response) ~= "string" or response:len() < 5 then
                    error("Invalid whitelist response")
                end
                
                if response:find("<html") or response:find("<!DOCTYPE") then
                    error("Whitelist not found")
                end
                
                return response
            end)
            
            if not success then
                StatusLabel.Text = "FAILED TO LOAD WHITELIST"
                StatusLabel.TextColor3 = colors.errorRed
                isVerifying = false
                VerifyButton.Text = "VERIFY KEY"
                VerifyButton.BackgroundColor3 = colors.darkestPanel
                warn("[ALADIA LOADER] Whitelist fetch error: "..tostring(whitelist))
                return
            end

            local isValid = false
            local isPremium = false
            local isExpired = false
            local expirationDate = ""
            local note = ""
            
            for line in whitelist:gmatch("[^\r\n]+") do
                local user, key, foundNote = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Note:%s*(.+)")
                if user and key and foundNote then
                    if string.lower(user) == string.lower(currentUsername) 
                       and string.upper(key) == enteredKey then
                        isValid = true
                        isPremium = true
                        note = foundNote
                        isExpired = false
                        break
                    end
                else
                    local user, key, exp = line:match("Usn:%s*(.-)%s*|%s*Key:%s*(%S+)%s*|%s*Exp:%s*(.+)")
                    if user and key and exp then
                        if string.lower(user) == string.lower(currentUsername) 
                           and string.upper(key) == enteredKey then
                            isValid = true
                            isPremium = true
                            expirationDate = exp
                            isExpired = IsKeyExpired(exp)
                            break
                        end
                    end
                end
            end

            if isValid then
                if isExpired then
                    StatusLabel.Text = "LICENSE EXPIRED ("..expirationDate..")"
                    StatusLabel.TextColor3 = colors.errorRed
                else
                    StatusLabel.Text = "VERIFICATION SUCCESSFUL!"
                    StatusLabel.TextColor3 = colors.successGreen
                    
                    -- Wait 5 seconds before loading premium script
                    VerifyButton.Text = "LOADING IN 3 SECONDS..."
                    
                    for i = 4, 1, -1 do
                        task.wait(1)
                        VerifyButton.Text = "LOADING IN "..i.." SECONDS..."
                    end
                    
                    task.wait(1)
                    
                    -- Load premium script
                    local LoadingFrame = Instance.new("Frame")
                    LoadingFrame.Name = "LoadingFrame"
                    LoadingFrame.Parent = MainFrame
                    LoadingFrame.BackgroundColor3 = colors.darkestPanel
                    LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                    LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                    LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                    
                    CreateGlassEffect(LoadingFrame, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
                    
                    local LoadingBar = Instance.new("Frame")
                    LoadingBar.Name = "LoadingBar"
                    LoadingBar.Parent = LoadingFrame
                    LoadingBar.BackgroundColor3 = colors.accentColor
                    LoadingBar.Size = UDim2.new(0, 0, 1, 0)

                    local LoadingText = Instance.new("TextLabel")
                    LoadingText.Name = "LoadingText"
                    LoadingText.Parent = LoadingFrame
                    LoadingText.BackgroundTransparency = 1
                    LoadingText.Size = UDim2.new(1, 0, 1, 0)
                    LoadingText.Font = Enum.Font.GothamBold
                    LoadingText.Text = "LOADING PREMIUM: 0%"
                    LoadingText.TextColor3 = colors.textColor
                    LoadingText.TextSize = 14

                    local duration = 1
                    local startTime = tick()
                    
                    local function update()
                        local elapsed = tick() - startTime
                        local progress = math.min(elapsed/duration, 1)
                        
                        LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
                        LoadingText.Text = "LOADING PREMIUM: "..math.floor(progress*100).."%"
                        
                        if progress < 1 then
                            task.wait()
                            update()
                        else
                            task.wait(0.5)
                            ScreenGui:Destroy()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/CuneoTop/reposhi/refs/heads/main/ngga.lua"))()
                        end
                    end
                    
                    update()
                end
            else
                StatusLabel.Text = "INVALID LICENSE KEY"
                StatusLabel.TextColor3 = colors.errorRed
            end
            
            -- Reset button state
            isVerifying = false
            VerifyButton.Text = "VERIFY KEY"
            VerifyButton.BackgroundColor3 = colors.darkestPanel
        end)
        
        -- Back Button Functionality
        BackButton.MouseButton1Click:Connect(function()
            
            -- Animate button press
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 270, 0, 45)
            }):Play()
            game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 280, 0, 50)
            }):Play()
            
            LicenseFrame:Destroy()
            Title.Text = "REP//GKDD| Aladia"
            PremiumButton.Visible = true
            BasicButton.Visible = true
        end)
    end)

    -- Basic Button Functionality
    local isConfirming = false

    BasicButton.MouseButton1Click:Connect(function()
        if isConfirming then return end
        isConfirming = true
        
        -- Animate button press
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 290, 0, 45)
        }):Play()
        game:GetService("TweenService"):Create(BasicButton, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 300, 0, 50)
        }):Play()
    
        -- If user needs to purchase (Nbuy:true)
        if userStatus.needsPurchase then
            -- Clear the main display
            PremiumButton.Visible = false
            BasicButton.Visible = false
            Title.Text = ""
        
            -- Create a blank frame that will contain ALL elements
            local BlankFrame = Instance.new("Frame")
            BlankFrame.Name = "BlankFrame"
            BlankFrame.Parent = MainFrame
            BlankFrame.BackgroundTransparency = 1
            BlankFrame.Size = UDim2.new(1, 0, 1, -60)
            BlankFrame.Position = UDim2.new(0, 0, 0, 60)
        
            -- Warning icon
            local WarningIcon = Instance.new("ImageLabel")
            WarningIcon.Name = "WarningIcon"
            WarningIcon.Parent = BlankFrame
            WarningIcon.BackgroundTransparency = 1
            WarningIcon.Size = UDim2.new(0, 64, 0, 64)
            WarningIcon.Position = UDim2.new(0.5, -32, 0, 0)
            WarningIcon.Image = "rbxassetid://3926305904"
            WarningIcon.ImageRectOffset = Vector2.new(364, 364)
            WarningIcon.ImageRectSize = Vector2.new(36, 36)
            WarningIcon.ImageColor3 = colors.warningYellow
        
            -- Add the warning text INSIDE BlankFrame
            local WarningText = Instance.new("TextLabel")
            WarningText.Name = "WarningText"
            WarningText.Parent = BlankFrame
            WarningText.BackgroundTransparency = 1
            WarningText.Size = UDim2.new(1, -40, 0, 40)
            WarningText.Position = UDim2.new(0, 20, 0.23, 0)
            WarningText.Font = Enum.Font.GothamBold
            WarningText.Text = "UPGRADE REQUIRED"
            WarningText.TextColor3 = colors.warningYellow
            WarningText.TextSize = 20
            WarningText.TextWrapped = true
            WarningText.TextXAlignment = Enum.TextXAlignment.Center

            -- Add the purchase message INSIDE BlankFrame
            local PurchaseText = Instance.new("TextLabel")
            PurchaseText.Name = "PurchaseText"
            PurchaseText.Parent = BlankFrame
            PurchaseText.BackgroundTransparency = 1
            PurchaseText.Size = UDim2.new(1, -40, 0, 80)
            PurchaseText.Position = UDim2.new(0, 20, 0.34, 0)
            PurchaseText.Font = Enum.Font.Gotham
            PurchaseText.Text = "Your free script access has expired.\n\nUpgrade to premium for 180k - 7 Days to continue using the script."
            PurchaseText.TextColor3 = colors.textColor
            PurchaseText.TextSize = 14
            PurchaseText.TextWrapped = true
            PurchaseText.TextXAlignment = Enum.TextXAlignment.Center
        
            -- Add back button INSIDE BlankFrame
            local BackButton = Instance.new("TextButton")
            BackButton.Name = "BackButton"
            BackButton.Parent = BlankFrame
            BackButton.BackgroundColor3 = colors.darkestPanel
            BackButton.Size = UDim2.new(0.6, 0, 0, 40)
            BackButton.Position = UDim2.new(0.2, 0, 0.65, 0)
            BackButton.Font = Enum.Font.GothamBold
            BackButton.Text = "BACK"
            BackButton.TextColor3 = colors.textColor
            BackButton.TextSize = 14
            BackButton.AutoButtonColor = false
        
            CreateGlassEffect(BackButton, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 8)
            UICorner.Parent = BackButton
            
            -- Button hover effect
            BackButton.MouseEnter:Connect(function()
                game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = colors.buttonHover,
                    TextColor3 = colors.accentLight
                }):Play()
            end)
            
            BackButton.MouseLeave:Connect(function()
                game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = colors.darkestPanel,
                    TextColor3 = colors.textColor
                }):Play()
            end)
        
            BackButton.MouseButton1Click:Connect(function()
                
                -- Animate button press
                game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.1), {
                    Size = UDim2.new(0, 240, 0, 36)
                }):Play()
                game:GetService("TweenService"):Create(BackButton, TweenInfo.new(0.1), {
                    Size = UDim2.new(0, 250, 0, 40)
                }):Play()
                
                BlankFrame:Destroy()
                Title.Text = "REP//GKDD | Aladia"
                PremiumButton.Visible = true
                BasicButton.Visible = true
                isConfirming = false
            end)
        
            return
        end
        
        -- If user doesn't need to purchase (Nbuy:false)
        CreateConfirmationDialog(
            "BASIC SCRIPT", 
            "Are you sure you want to load the basic script?\n\nFeatures may be limited compared to premium.",
            function(confirmed)
                isConfirming = false
                
                if confirmed then
                    PremiumButton.Visible = false
                    BasicButton.Visible = false
                    Title.Text = "LOADING BASIC..."
                    
                    -- Loading animation
                    local LoadingFrame = Instance.new("Frame")
                    LoadingFrame.Name = "LoadingFrame"
                    LoadingFrame.Parent = MainFrame
                    LoadingFrame.BackgroundColor3 = colors.darkestPanel
                    LoadingFrame.Size = UDim2.new(1, 0, 0, 30)
                    LoadingFrame.Position = UDim2.new(0, 0, 1, -30)
                    LoadingFrame.AnchorPoint = Vector2.new(0, 1)
                    
                    CreateGlassEffect(LoadingFrame, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.9)
                    
                    local LoadingBar = Instance.new("Frame")
                    LoadingBar.Name = "LoadingBar"
                    LoadingBar.Parent = LoadingFrame
                    LoadingBar.BackgroundColor3 = colors.accentColor
                    LoadingBar.Size = UDim2.new(0, 0, 1, 0)

                    local LoadingText = Instance.new("TextLabel")
                    LoadingText.Name = "LoadingText"
                    LoadingText.Parent = LoadingFrame
                    LoadingText.BackgroundTransparency = 1
                    LoadingText.Size = UDim2.new(1, 0, 1, 0)
                    LoadingText.Font = Enum.Font.GothamBold
                    LoadingText.Text = "LOADING BASIC: 0%"
                    LoadingText.TextColor3 = colors.textColor
                    LoadingText.TextSize = 14

                    local duration = 3
                    local startTime = tick()
                    
                    local function update()
                        local elapsed = tick() - startTime
                        local progress = math.min(elapsed/duration, 1)
                        
                        LoadingBar.Size = UDim2.new(progress, 0, 1, 0)
                        LoadingText.Text = "LOADING BASIC: "..math.floor(progress*100).."%"
                        
                        if progress < 1 then
                            task.wait()
                            update()
                        else
                            task.wait(0.5)
                            ScreenGui:Destroy()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/CuneoTop/reposhi/refs/heads/main/ngga.lua"))()
                        end
                    end
                    
                    update()
                end
            end
        )
    end)

    -- Initial animation for the main frame
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 400, 0, 350),
        Position = UDim2.new(0.5, -200, 0.5, -175)
    }):Play()
end

-- Error handling with modern design
local success, err = pcall(CreateMainGUI)
if not success then
    warn("ALADIA LOADER ERROR: "..tostring(err))
    
    local ErrorGui = Instance.new("ScreenGui")
    ErrorGui.Name = "ErrorGui"
    ErrorGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    ErrorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local ErrorOverlay = Instance.new("Frame")
    ErrorOverlay.Name = "ErrorOverlay"
    ErrorOverlay.Parent = ErrorGui
    ErrorOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    ErrorOverlay.BackgroundTransparency = 0.7
    ErrorOverlay.Size = UDim2.new(1, 0, 1, 0)
    
    local ErrorFrame = Instance.new("Frame")
    ErrorFrame.Name = "ErrorFrame"
    ErrorFrame.Parent = ErrorOverlay
    ErrorFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    ErrorFrame.Size = UDim2.new(0, 350, 0, 200)
    ErrorFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    ErrorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    CreateGlassEffect(ErrorFrame, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 0.8)
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = ErrorFrame
    
    local ErrorIcon = Instance.new("ImageLabel")
    ErrorIcon.Name = "ErrorIcon"
    ErrorIcon.Parent = ErrorFrame
    ErrorIcon.BackgroundTransparency = 1
    ErrorIcon.Size = UDim2.new(0, 64, 0, 64)
    ErrorIcon.Position = UDim2.new(0.5, -32, 0, 20)
    ErrorIcon.Image = "rbxassetid://3926305904"
    ErrorIcon.ImageRectOffset = Vector2.new(324, 364)
    ErrorIcon.ImageRectSize = Vector2.new(36, 36)
    ErrorIcon.ImageColor3 = Color3.fromRGB(255, 90, 90)
    
    local ErrorTitle = Instance.new("TextLabel")
    ErrorTitle.Name = "ErrorTitle"
    ErrorTitle.Parent = ErrorFrame
    ErrorTitle.BackgroundTransparency = 1
    ErrorTitle.Size = UDim2.new(1, -40, 0, 30)
    ErrorTitle.Position = UDim2.new(0, 20, 0, 90)
    ErrorTitle.Font = Enum.Font.GothamBold
    ErrorTitle.Text = "LOADER ERROR"
    ErrorTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
    ErrorTitle.TextSize = 18
    
    local ErrorMsg = Instance.new("TextLabel")
    ErrorMsg.Name = "ErrorMsg"
    ErrorMsg.Parent = ErrorFrame
    ErrorMsg.BackgroundTransparency = 1
    ErrorMsg.Size = UDim2.new(1, -40, 0, 60)
    ErrorMsg.Position = UDim2.new(0, 20, 0, 120)
    ErrorMsg.Font = Enum.Font.Gotham
    ErrorMsg.Text = "Failed to initialize loader:\n"..tostring(err)
    ErrorMsg.TextColor3 = Color3.fromRGB(220, 220, 220)
    ErrorMsg.TextSize = 14
    ErrorMsg.TextWrapped = true
    
    -- Initial animation
    ErrorFrame.Size = UDim2.new(0, 0, 0, 0)
    ErrorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    game:GetService("TweenService"):Create(ErrorFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 350, 0, 200),
        Position = UDim2.new(0.5, -175, 0.5, -100)
    }):Play()
    
    task.delay(5, function()
        game:GetService("TweenService"):Create(ErrorFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        game:GetService("TweenService"):Create(ErrorOverlay, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.3)
        ErrorGui:Destroy()
    end)
end
