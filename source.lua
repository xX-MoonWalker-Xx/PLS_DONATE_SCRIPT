---@diagnostic disable: undefined-global, deprecated
repeat
    wait(); print("Waiting For Load")
until game:IsLoaded()

repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("MapUIContainer"):FindFirstChild("MapUI").BoothUI
repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport

if _G.hopAtPlayerAmount > 0 then
    spawn(function()
        while wait() do
            if #game.Players:GetChildren() <= _G.hopAtPlayerAmount then
                teleportFunc([[
                    _G.autoUpdateGoal = ]] .. tostring(_G.autoUpdateGoal).. [[
                    _G.increaseGoalBy = ]] ..tostring(_G.increaseGoalBy) .. [[
                    _G.goal = ]] ..'"'.._G.goal ..'"'.. [[
                    _G.Text = ]] .. '[[' .. _G.Text ..']]'.. [[
        
                    _G.saythanks = ]] .. tostring(_G.saythanks).. [[
                    _G.thanksText = ]] ..'"'.._G.thanksText ..'"'.. [[
                    _G.thanksWaitTime = ]] .. tostring(_G.thanksWaitTime) .. [[
                    _G.beg = ]] ..tostring(_G.beg).. [[
                    _G.begInterval = ]] ..tostring(_G.begInterval).. [[
                    _G.begText = ]] .. '"' .._G.begText..'"' .. [[
        
                    _G.hopAtPlayerAmount = ]]..tostring(_G.hopAtPlayerAmount).. [[
                    _G.hopInterval = ]].. tostring(_G.hopInterval) .. [[
                    
                    _G.boardUpdateInterval = ]] .. tostring(_G.boardUpdateInterval) .. [[ -- as you can guess, in seconds
                    
                    -- DONT Change! (or do if yk what you're doing)
                    _G.loadstr = ]].. '"' .._G.loadstr..'"' .. [[
        
                    loadstring(game:HttpGet(_G.loadstr, true))()]])
    


                local GUIDs = {}
                local maxPlayers = 0
                local pagesToSearch = 100
                function Search()
                local Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="))
                   for i = 1,pagesToSearch do
                    for _,v in pairs(Http.data) do
                        if v.playing ~= v.maxPlayers and v.id ~= game.JobId then
                            maxPlayers = v.maxPlayers
                            table.insert(GUIDs, {id = v.id, users = v.playing})
                        end
                    end
                    print("Searched! i=", i)
                    if Http.nextPageCursor ~= null then Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..Http.nextPageCursor)) else break end
                end 
                end

                local highest = {id = "", users=0}
                function findHighest()
                local suc = pcall(function()
                    for i,v in ipairs(GUIDs) do
                        if v.users > highest.users and not (v.users > (maxPlayers - 4)) then
                            highest = v
                        end
                    end 
                end)

                if not suc then
                   Search()
                   findHighest()
                end
                end

                function tp()
                   local suc = pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, highest.id, game.Players.LocalPlayer) end)
                   if not suc then 
                        Search()
                        findHighest()
                        tp()
                    end
                end

                Search()
                findHighest()
                tp()
            end
        end
    end)
end

if _G.hopInterval > 0 then
    spawn(function()
        wait(_G.hopInterval)
        teleportFunc([[
            _G.autoUpdateGoal = ]] .. tostring(_G.autoUpdateGoal).. [[
            _G.increaseGoalBy = ]] ..tostring(_G.increaseGoalBy) .. [[
            _G.goal = ]] ..'"'.._G.goal ..'"'.. [[
            _G.Text = ]] .. '[[' .. _G.Text ..']]'.. [[
            _G.saythanks = ]] .. tostring(_G.saythanks).. [[
            _G.thanksText = ]] ..'"'.._G.thanksText ..'"'.. [[
            _G.thanksWaitTime = ]] .. tostring(_G.thanksWaitTime) .. [[
            _G.beg = ]] ..tostring(_G.beg).. [[
            _G.begInterval = ]] ..tostring(_G.begInterval).. [[
            _G.begText = ]] .. '"' .._G.begText..'"' .. [[
            _G.hopAtPlayerAmount = ]]..tostring(_G.hopAtPlayerAmount).. [[
            _G.hopInterval = ]].. tostring(_G.hopInterval) .. [[
            
            _G.boardUpdateInterval = ]] .. tostring(_G.boardUpdateInterval) .. [[ -- as you can guess, in seconds
            
            -- DONT Change! (or do if yk what you're doing)
            _G.loadstr = ]].. '"' .._G.loadstr..'"' .. [[
            _G.onDonateLoadString =]] .. '"' .._G.onDonateLoadString..'"' .. [[
            loadstring(game:HttpGet(_G.loadstr, true))()]])
    
        local GUIDs = {}
        local maxPlayers = 0
        local pagesToSearch = 100
        function Search()
        local Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="))
           for i = 1,pagesToSearch do
            for _,v in pairs(Http.data) do
                if v.playing ~= v.maxPlayers and v.id ~= game.JobId then
                    maxPlayers = v.maxPlayers
                    table.insert(GUIDs, {id = v.id, users = v.playing})
                end
            end
            print("Searched! i=", i)
            if Http.nextPageCursor ~= null then Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..Http.nextPageCursor)) else break end
        end 
        end
    
        local highest = {id = "", users=0}
        function findHighest()
        local suc = pcall(function()
            for i,v in ipairs(GUIDs) do
                if v.users > highest.users and not (v.users > (maxPlayers - 4)) then
                    highest = v
                end
            end 
        end)
    
        if not suc then 
           Search()
           findHighest()
        end
        end
    
        function tp()
           local suc = pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, highest.id, game.Players.LocalPlayer) end)
           if not suc then 
                Search()
                findHighest()
                tp()
            end
        end
    
        Search()
        findHighest()
        tp()
    end)
end

print("Server Hop Interval Loaded")

local lib = require(game.ReplicatedStorage.Remotes)

old = hookfunction(lib.Event, function(name, ...)
    for i,v in ipairs(game.ReplicatedStorage.Remotes:GetChildren()) do
        if v.Name == name then return v end 
    end
    
    local event = old(name, ...)
    if event.Name then
       event.Name = name
       return event
    end
end)

local old2;

old2 = hookfunction(lib.Function, function(name, ...)
    for i,v in ipairs(game.ReplicatedStorage.Remotes:GetChildren()) do
        if v.Name == name then return v end
    end
    
    local event = old(name, ...)
    if event.Name then
       event.Name = name
       return event
    end
end)

local data = {"InsufficientGiftbux","NewPurchasedBooths","PurchaseBoothStarted","NewGiftbuxBalance","AlreadyOwned","AdminCommandResponse","GetOurTopDonated","GlobalDonationsDown","FireSmite","FireNuke","ChangeMusic","GiftSentAlert","NotifyDonationParticipants","ChatDonationAlert","UserInfo","UnclaimedDonationCount","UnclaimedDonations","CheckFiltered","SetSettings","GetSettings","GiftbuxBalance","ExclusiveBooths","PurchasedBooths","CurrentBooth","GetDonated","SetDonatedVisibility","GiftReceived","DonatedChanged","EditBoothModel","SetBoothText","RefreshItems","PreloadItems","ClaimBooth","UnclaimBooth","CancelPromptPurchase",}
for i,v in ipairs(data) do
    lib.Event(v)
    lib.Function(v)
end

print("Hooks Done")

-- Claim Board

for i,v in ipairs(game.Workspace.BoothInteractions:GetChildren()) do
    if game.Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI["BoothUI"..tostring(v:GetAttribute("BoothSlot"))].Details.Owner.Text == "unclaimed" then
        fireproximityprompt(v.Claim, 0)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.CFrame.x+3, v.CFrame.y+3, v.CFrame.z+3)
        break
    end
end

print("Done Claiming Booth")
-- Setup Board

local event = lib.Event("SetBoothText")

local boothui = game.Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI

local ourbooth

function getOurBooth()
for i,v in ipairs(boothui:GetChildren()) do
   if v.Details.Owner.Text:split("'")[1] == game.Players.LocalPlayer.DisplayName  then
       ourbooth = v
       print("Our Booth: " .. v.Name)
       break
    end
end
end

repeat getOurBooth(); print("Wating For Booth!"); wait(); until ourbooth

print("Got Our Booth")

if _G.beg then
    spawn(function()
        while wait(_G.begInterval) do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.begText, "all")
        end
    end) 
end

print("Begging Loop Done")

local plast = string.gsub(ourbooth.Details.Raised.Text:split(" ")[1], ",", "")
local last = tonumber(plast)
local llast

if _G.autoUpdateGoal then
    print("Auto Updating Goal....")
    event:FireServer(_G.Text .. plast .. " / " .. tostring(tonumber(plast) + _G.increaseGoalBy), "booth")
else
    event:FireServer(_G.Text .. plast .. " / " .. _G.goal, "booth")
end

while wait(_G.boardUpdateInterval) do
    plast = string.gsub(ourbooth.Details.Raised.Text:split(" ")[1], ",", "")
    if tonumber(plast) > last then
        if _G.saythanks then
            llast = last
            spawn(function()
                wait(_G.thanksWaitTime)
                local num, occ = string.gsub(ourbooth.Details.Raised.Text:split(" ")[1], ",", "")
                num = tonumber(num)
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(string.format(_G.thanksText, tostring(tonumber(num)) - llast),"All")            
            end)
        end

        if _G.autoUpdateGoal then
            print("Auto Updating Goal....")
            event:FireServer(_G.Text .. plast .. " / " .. tostring(tonumber(plast) + _G.increaseGoalBy), "booth")
            loadstring(_G.onDonateLoadString)()
        else
            event:FireServer(_G.Text .. plast .. " / " .. _G.goal, "booth")
            loadstring(_G.onDonateLoadString)()
        end
        last = tonumber(plast)
    end
end
