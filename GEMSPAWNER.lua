local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local UICorner_3 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.11102172, 0, 0.325419009, 0)
Frame.Size = UDim2.new(0, 367, 0, 222)
Frame.Draggable = true
Frame.Active = true

UICorner.Parent = Frame

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(72, 153, 204)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.174386919, 0, 0.666666687, 0)
TextButton.Size = UDim2.new(0, 239, 0, 50)
TextButton.ZIndex = 2
TextButton.Font = Enum.Font.FredokaOne
TextButton.Text = "Spawn"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 25.000
TextButton.TextWrapped = true

UICorner_2.Parent = TextButton

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.174386919, 0, 0.333333343, 0)
TextBox.Size = UDim2.new(0, 239, 0, 50)
TextBox.Font = Enum.Font.FredokaOne
TextBox.PlaceholderText = "Enter Gem Amount"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextSize = 20.000

UICorner_3.Parent = TextBox

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.226158038, 0, 0.0360360369, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Gem Spawner | Made By RAYZ HUB"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

local function formatNumber(num)
    if num >= 1e9 then
        return string.format("%.1fb", num / 1e9)
    elseif num >= 1e6 then
        return string.format("%.1fm", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.1fk", num / 1e3)
    else
        return tostring(num)
    end
end

local function parseInput(input)
    input = input:lower()
    if input:find("b") then
        return tonumber(input:gsub("b", "")) * 1e9
    elseif input:find("m") then
        return tonumber(input:gsub("m", "")) * 1e6
    elseif input:find("k") then
        return tonumber(input:gsub("k", "")) * 1e3
    else
        return tonumber(input)
    end
end

local function smoothUpdateText(targetTextObject, targetValue, duration)
    local currentValue = tonumber(targetTextObject.Text:match("%d+") or "0")
    local steps = 60
    local increment = (targetValue - currentValue) / steps
    local stepDuration = duration / steps

    for i = 1, steps do
        currentValue = currentValue + increment
        if currentValue > targetValue then
            currentValue = targetValue
        end
        targetTextObject.Text = formatNumber(math.floor(currentValue + 0.5))
        task.wait(stepDuration)
    end

    targetTextObject.Text = formatNumber(targetValue)
end

TextButton.MouseButton1Click:Connect(function()
    local input = parseInput(TextBox.Text)
    if input then
        local cappedInput = math.min(input, 25e9)
        if input > 25e9 then
            TextBox.Text = "Max 25b Gems"
        end

        local diamondsAmount = game:GetService("Players").LocalPlayer.PlayerGui.MainLeft.Left.Currency.Diamonds.Diamonds.Amount
        if diamondsAmount then
            smoothUpdateText(diamondsAmount, cappedInput, 2)
        end

        local leaderstats = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            local diamondsStat = leaderstats:FindFirstChild("💎 Diamonds")
            if diamondsStat then
                diamondsStat.Value = cappedInput
            end
        end
    else
        TextBox.Text = "Invalid Number"
    end
end)
