local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Save = require(ReplicatedStorage.Library.Client.Save).Get()
local Directory = require(ReplicatedStorage.Library.Directory)
local Network = ReplicatedStorage:WaitForChild("Network")


local Inventory = Save.Inventory
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
local TextLabel = Instance.new("TextLabel", Frame)
local TextLabel1 = Instance.new("TextLabel", Frame)
local TextButton = Instance.new("TextButton", Frame)
local UICorner = Instance.new("UICorner", Frame)
local UICorner = Instance.new("UICorner", TextButton)
local UICorner = Instance.new("UICorner", TextBox)
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 350, 0, 199)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.2, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Titanic Hunter"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true

TextLabel1.Parent = Frame
TextLabel1.BackgroundTransparency = 1
TextLabel1.Position = UDim2.new(0.15, 0, 0.3, 0)
TextLabel1.Size = UDim2.new(0, 249, 0, 50)
TextLabel1.Font = Enum.Font.FredokaOne
TextLabel1.Text = "Made By RAYZ HUB"
TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel1.TextSize = 20

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(42, 145, 255)
TextButton.Position = UDim2.new(0.15, 0, 0.65, 0)
TextButton.Size = UDim2.new(0, 249, 0, 50)
TextButton.Font = Enum.Font.FredokaOne
TextButton.Text = "Activate"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 35

TextButton.MouseButton1Click:Connect(function()
        local message = require(game.ReplicatedStorage.Library.Client.Message)
    message.Error("Titanic Hunter Script activated! | Made By RAYZ HUB")
Directory = require(game:GetService("ReplicatedStorage").Library.Directory)
function changePetAttributes()
    local from = "Rose Garden Cat"
    local to = "Titanic Loveserker"

    if Directory.Pets[from] and Directory.Pets[to] then
        for i, v in pairs(Directory.Pets[from]) do
            Directory.Pets[from][i] = nil
        end

        for i, v in pairs(Directory.Pets[to]) do
            Directory.Pets[from][i] = v
        end
    end
end

changePetAttributes()
end)
