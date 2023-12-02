local RSGCore = exports['rsg-core']:GetCoreObject()


-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/RetryR1v2/mms-drugs/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

      
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('Current Version: %s'):format(currentVersion))
            versionCheckPrint('success', ('Latest Version: %s'):format(text))
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

------------------------------------WEED-----------------------------------

-- Weed Erenten

RegisterNetEvent('mms-drugs:server:giveweed', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('weed', Config.amountweed)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['weed'], "add")
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountweed .. ' Weed', description =  'Geerntet', type = 'Weed' })
end)

--- Weed Verarbeiter

RegisterNetEvent('mms-drugs:server:weedworker', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('weed') and Player.Functions.GetItemByName('weed').amount >= 1 then
    local weedamount = Player.Functions.GetItemByName('weed').amount
    if weedamount >= 5 then
        TriggerClientEvent('mms-drugs:client:weedworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('weed', 5)
        Player.Functions.AddItem('Joint', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['weed'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Weed zu 1 Joint verarbeitet', description =  'Verarbeitet', type = 'Joint' })
    elseif weedamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. weedamount .. ' Weed', description =  'Weed Fehlt', type = 'Weed' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Weed zum Verarbeiten', description =  'Weed Fehlt', type = 'Weed' }) 
end

end)

RegisterNetEvent('mms-drugs:server:weedworker5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('weed') and Player.Functions.GetItemByName('weed').amount >= 1 then
    local weedamount = Player.Functions.GetItemByName('weed').amount
    if weedamount >= 25 then
        TriggerClientEvent('mms-drugs:client:weedworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('weed', 25)
        Player.Functions.AddItem('Joint', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['weed'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Weed zu 5 Joints verarbeitet', description =  'Verarbeitet', type = 'Joint' })
    elseif weedamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. weedamount .. ' Weed', description =  'Weed Fehlt', type = 'Weed' }) 
    end
else
    print(hasweed)
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Weed zum Verarbeiten', description =  'Weed Fehlt', type = 'Weed' }) 
end
end)

RegisterNetEvent('mms-drugs:server:weedworker10', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('weed') and Player.Functions.GetItemByName('weed').amount >= 1 then
    local weedamount = Player.Functions.GetItemByName('weed').amount
    if weedamount >= 50 then
        TriggerClientEvent('mms-drugs:client:weedworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('weed', 50)
        Player.Functions.AddItem('Joint', 10)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['weed'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Weed zu 10 Joints verarbeitet', description =  'Verarbeitet', type = 'Joint' })
    elseif weedamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. weedamount .. ' Weed', description =  'Weed Fehlt', type = 'Weed' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Weed zum Verarbeiten', description =  'Weed Fehlt', type = 'Weed' }) 
end
end)

-- Joints Verkaufen

RegisterNetEvent('mms-drugs:server:weedseller1', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('joint') and Player.Functions.GetItemByName('joint').amount >= 1 then
    local jointamount = Player.Functions.GetItemByName('joint').amount
    if jointamount >= 1 then
        TriggerClientEvent('mms-drugs:client:weedsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('joint', 1)
        Player.Functions.AddMoney('cash',Config.sellprice)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 1 Joint für ' .. Config.sellprice ..' $ Verkauft', description =  'Verkauft', type = 'Joints' })
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Joints zum Verkaufen', description =  'Joints Fehlen', type = 'Joints' }) 
end
end)

RegisterNetEvent('mms-drugs:server:weedseller5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('joint') and Player.Functions.GetItemByName('joint').amount >= 1 then
    local jointamount = Player.Functions.GetItemByName('joint').amount
    if jointamount >= 5 then
        TriggerClientEvent('mms-drugs:client:weedsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('joint', 5)
        Player.Functions.AddMoney('cash',Config.sellprice * 5)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Joints für ' .. Config.sellprice * 5 ..' $ Verkauft', description =  'Verkauft', type = 'Joints' })
    elseif jointamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. jointamount .. ' Joints', description =  'Joints Fehlen', type = 'Joints' }) 
    
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Joints zum Verkaufen', description =  'Joints Fehlen', type = 'Joints' }) 
end
end)

RegisterNetEvent('mms-drugs:server:weedseller25', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('joint') and Player.Functions.GetItemByName('joint').amount >= 1 then
    local jointamount = Player.Functions.GetItemByName('joint').amount
    if jointamount >= 25 then
        TriggerClientEvent('mms-drugs:client:weedsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('joint', 25)
        Player.Functions.AddMoney('cash',Config.sellprice * 25)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Joints für ' .. Config.sellprice * 25 ..' $ Verkauft', description =  'Verkauft', type = 'Joints' })
    elseif jointamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. jointamount .. ' Joints', description =  'Joints Fehlen', type = 'Joints' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Joints zum Verkaufen', description =  'Joints Fehlen', type = 'Joints' }) 
end
end)

RegisterNetEvent('mms-drugs:server:weedseller50', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('joint') and Player.Functions.GetItemByName('joint').amount >= 1 then
    local jointamount = Player.Functions.GetItemByName('joint').amount
    if jointamount >= 50 then
        TriggerClientEvent('mms-drugs:client:weedsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('joint', 50)
        Player.Functions.AddMoney('cash',Config.sellprice * 50)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Joints für ' .. Config.sellprice * 50 ..' $ Verkauft', description =  'Verkauft', type = 'Joints' })
    elseif jointamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. jointamount .. ' Joints', description =  'Joints Fehlen', type = 'Joints' }) 
    end
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Joints zum Verkaufen', description =  'Joints Fehlen', type = 'Joints' }) 
    end
end)

-------------------------------OPIUM----------------------------------------------

-- Opium Erenten

RegisterNetEvent('mms-drugs:server:giveopium', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('opium', Config.amountopium)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "add")
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountweed .. ' Opium', description =  'Geerntet', type = 'Opium' })
end)

--- Opium Verarbeiter

RegisterNetEvent('mms-drugs:server:opiumworker', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opium') and Player.Functions.GetItemByName('opium').amount >= 1 then
    local opiumamount = Player.Functions.GetItemByName('opium').amount
    if opiumamount >= 5 then
        TriggerClientEvent('mms-drugs:client:opiumworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opium', 5)
        Player.Functions.AddItem('opiat', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Opium zu 1 Opiat verarbeitet', description =  'Verarbeitet', type = 'Opiat' })
    elseif opiumamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiumamount .. ' Opium', description =  'Opium Fehlt', type = 'Opium' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Opium zum Verarbeiten', description =  'Opium Fehlt', type = 'Opium' }) 
end
end)

RegisterNetEvent('mms-drugs:server:opiumworker5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opium') and Player.Functions.GetItemByName('opium').amount >= 1 then
    local opiumamount = Player.Functions.GetItemByName('opium').amount
    if opiumamount >= 25 then
        TriggerClientEvent('mms-drugs:client:opiumworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opium', 25)
        Player.Functions.AddItem('opiat', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Opium zu 5 Opiat verarbeitet', description =  'Verarbeitet', type = 'Opiat' })
    elseif opiumamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiumamount .. ' Opium', description =  'Opium Fehlt', type = 'Opium' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Opium zum Verarbeiten', description =  'Opium Fehlt', type = 'Opium' }) 
end
end)

RegisterNetEvent('mms-drugs:server:opiumworker10', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opium') and Player.Functions.GetItemByName('opium').amount >= 1 then
    local opiumamount = Player.Functions.GetItemByName('opium').amount
    if opiumamount >= 50 then
        TriggerClientEvent('mms-drugs:client:opiumworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opium', 50)
        Player.Functions.AddItem('opiat', 10)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Opium zu 10 Opiat verarbeitet', description =  'Verarbeitet', type = 'Opiat' })
    elseif opiumamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiumamount .. ' Opium', description =  'Opium Fehlt', type = 'Opium' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Opium zum Verarbeiten', description =  'Opium Fehlt', type = 'Opium' }) 
end
end)

-- Opiate Verkaufen

RegisterNetEvent('mms-drugs:server:opiatseller1', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opiat') and Player.Functions.GetItemByName('opiat').amount >= 1 then
    local opiatamount = Player.Functions.GetItemByName('opiat').amount
    if opiatamount >= 1 then
        TriggerClientEvent('mms-drugs:client:opiatsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opiat', 1)
        Player.Functions.AddMoney('cash',Config.sellpriceopiat)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 1 Opiat für ' .. Config.sellpriceopiat ..' $ Verkauft', description =  'Verkauft', type = 'Opiate' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "remove")
    end
    else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Opiate zum Verkaufen', description =  'Opiate Fehlen', type = 'Opiate' }) 
    end
end)

RegisterNetEvent('mms-drugs:server:opiatseller5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opiat') and Player.Functions.GetItemByName('opiat').amount >= 1 then
    local opiatamount = Player.Functions.GetItemByName('opiat').amount
    if opiatamount >= 5 then
        TriggerClientEvent('mms-drugs:client:opiatsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opiat', 5)
        Player.Functions.AddMoney('cash',Config.sellpriceopiat *5)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Opiate für ' .. Config.sellpriceopiat * 5 ..' $ Verkauft', description =  'Verkauft', type = 'Opiate' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "remove")
    elseif opiatamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiatamount .. ' Opiate', description =  'Opiate Fehlen', type = 'Opiate' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Opiate zum Verkaufen', description =  'Opiate Fehlen', type = 'Opiate' }) 
end

end)

RegisterNetEvent('mms-drugs:server:opiatseller25', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opiat') and Player.Functions.GetItemByName('opiat').amount >= 1 then
    local opiatamount = Player.Functions.GetItemByName('opiat').amount
    if opiatamount >= 25 then
        TriggerClientEvent('mms-drugs:client:opiatsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opiat', 25)
        Player.Functions.AddMoney('cash',Config.sellpriceopiat * 25)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Opiate für ' .. Config.sellpriceopiat * 25 ..' $ Verkauft', description =  'Verkauft', type = 'Opiate' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "remove")
    elseif opiatamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiatamount .. ' Opiate', description =  'Opiate Fehlen', type = 'Opiate' })
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Opiate zum Verkaufen', description =  'Opiate Fehlen', type = 'Opiate' }) 
end
end)

RegisterNetEvent('mms-drugs:server:opiatseller50', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opiat') and Player.Functions.GetItemByName('opiat').amount >= 1 then
    local opiatamount = Player.Functions.GetItemByName('opiat').amount
    if opiatamount >= 50 then
        TriggerClientEvent('mms-drugs:client:opiatsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('opiat', 50)
        Player.Functions.AddMoney('cash',Config.sellpriceopiat * 50)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Opiate für ' .. Config.sellpriceopiat * 50 ..' $ Verkauft', description =  'Verkauft', type = 'Opiate' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "remove")
    elseif opiatamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. opiatamount .. ' Opiate', description =  'Opiate Fehlen', type = 'Opiate' })
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Opiate zum Verkaufen', description =  'Opiate Fehlen', type = 'Opiate' }) 
end
end)

-------------------------------KOKAIN----------------------------------------------

-- Kokain Erenten

RegisterNetEvent('mms-drugs:server:givekokain', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('kokain', Config.amountkokain)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokain'], "add")
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountkokain .. ' Kokain', description =  'Geerntet', type = 'Kokain' })
end)

--- Kokain Verarbeiter

RegisterNetEvent('mms-drugs:server:kokainworker', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokain') and Player.Functions.GetItemByName('kokain').amount >= 1 then
    local kokainamount = Player.Functions.GetItemByName('kokain').amount
    if kokainamount >= 5 then
        TriggerClientEvent('mms-drugs:client:kokainworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('kokain', 5)
        Player.Functions.AddItem('kokainpulver', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokain'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Kokain zu 1 Kokain Pulver Verarbeitet', description =  'Verarbeitet', type = 'Kokain' })
    elseif kokainamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain', description =  'Kokain Fehlt', type = 'Kokain' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain zum Verarbeiten', description =  'Kokain Fehlt', type = 'Kokain' }) 
end
end)

RegisterNetEvent('mms-drugs:server:kokainworker5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokain') and Player.Functions.GetItemByName('kokain').amount >= 1 then
    local kokainamount = Player.Functions.GetItemByName('kokain').amount
    if kokainamount >= 25 then
        TriggerClientEvent('mms-drugs:client:kokainworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('kokain', 25)
        Player.Functions.AddItem('kokainpulver', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokain'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Kokain zu 5 Kokain Pulver Verarbeitet', description =  'Verarbeitet', type = 'Kokain' })
    elseif kokainamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain', description =  'Kokain Fehlt', type = 'Kokain' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain zum Verarbeiten', description =  'Kokain Fehlt', type = 'Opium' }) 
end
end)

RegisterNetEvent('mms-drugs:server:kokainworker10', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokain') and Player.Functions.GetItemByName('kokain').amount >= 1 then
    local kokainamount = Player.Functions.GetItemByName('kokain').amount
    if kokainamount >= 50 then
        TriggerClientEvent('mms-drugs:client:kokainworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('kokain', 50)
        Player.Functions.AddItem('kokainpulver', 10)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokain'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Kokain zu 10 Kokain Pulver Verarbeitet', description =  'Verarbeitet', type = 'Kokain' })
    elseif kokainamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain', description =  'Kokain Fehlt', type = 'Kokain' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain zum Verarbeiten', description =  'Kokain Fehlt', type = 'Opium' }) 
end
end)

-- Kokain Verkaufen

RegisterNetEvent('mms-drugs:server:kokainseller1', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokainpulver') and Player.Functions.GetItemByName('kokainpulver').amount >= 1 then
    local kokainamount = Player.Functions.GetItemByName('kokainpulver').amount
    if kokainamount >= 1 then
        TriggerClientEvent('mms-drugs:client:kokainsellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('kokainpulver', 1)
        Player.Functions.AddMoney('cash',Config.sellpricekokain)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 1 Kokain Pulver für ' .. Config.sellpricekokain ..' $ Verkauft', description =  'Verkauft', type = 'Kokain Pulver' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "remove")
    end
    else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain Pulver zum Verkaufen', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
    end
end)

RegisterNetEvent('mms-drugs:server:kokainseller5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokainpulver') and Player.Functions.GetItemByName('kokainpulver').amount >= 1 then
        local kokainamount = Player.Functions.GetItemByName('kokainpulver').amount
        if kokainamount >= 5 then
            TriggerClientEvent('mms-drugs:client:kokainsellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('kokainpulver', 5)
            Player.Functions.AddMoney('cash',Config.sellpricekokain *5)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Kokain Pulver für ' .. Config.sellpricekokain * 5 ..' $ Verkauft', description =  'Verkauft', type = 'Kokain Pulver' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "remove")
    elseif kokainamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain Pulver', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain Pulver zum Verkaufen', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
end

end)

RegisterNetEvent('mms-drugs:server:kokainseller25', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokainpulver') and Player.Functions.GetItemByName('kokainpulver').amount >= 1 then
        local kokainamount = Player.Functions.GetItemByName('kokainpulver').amount
        if kokainamount >= 25 then
            TriggerClientEvent('mms-drugs:client:kokainsellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('kokainpulver', 25)
            Player.Functions.AddMoney('cash',Config.sellpricekokain *25)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Kokain Pulver für ' .. Config.sellpricekokain * 25 ..' $ Verkauft', description =  'Verkauft', type = 'Kokain Pulver' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "remove")
    elseif kokainamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain Pulver', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain Pulver zum Verkaufen', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
end

end)

RegisterNetEvent('mms-drugs:server:kokainseller50', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokainpulver') and Player.Functions.GetItemByName('kokainpulver').amount >= 1 then
        local kokainamount = Player.Functions.GetItemByName('kokainpulver').amount
        if kokainamount >= 50 then
            TriggerClientEvent('mms-drugs:client:kokainsellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('kokainpulver', 50)
            Player.Functions.AddMoney('cash',Config.sellpricekokain *50)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Kokain Pulver für ' .. Config.sellpricekokain * 50 ..' $ Verkauft', description =  'Verkauft', type = 'Kokain Pulver' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "remove")
    elseif kokainamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. kokainamount .. ' Kokain Pulver', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain Pulver zum Verkaufen', description =  'Kokain Pulver Fehlt', type = 'Kokain Pulver' }) 
end

end)

-------------------------------Pilze----------------------------------------------

-- Pilzsporen Erenten

RegisterNetEvent('mms-drugs:server:givesporen', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('sporen', Config.amountsporen)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['sporen'], "add")
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountsporen .. ' Sporen', description =  'Geerntet', type = 'Sporen' })
end)

--- Sporen Verarbeiter

RegisterNetEvent('mms-drugs:server:sporenworker', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('sporen') and Player.Functions.GetItemByName('sporen').amount >= 1 then
    local sporenamount = Player.Functions.GetItemByName('sporen').amount
    if sporenamount >= 5 then
        TriggerClientEvent('mms-drugs:client:sporenworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('sporen', 5)
        Player.Functions.AddItem('pilze', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['sporen'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Sporen zu 1 Pilz Verarbeitet', description =  'Verarbeitet', type = 'Sporen' })
    elseif sporenamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. sporenamount .. ' Sporen', description =  'Sporen Fehlen', type = 'Sporen' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Sporen zum Verarbeiten', description =  'Sporen Fehlen', type = 'Sporen' }) 
end
end)

RegisterNetEvent('mms-drugs:server:sporenworker5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('sporen') and Player.Functions.GetItemByName('sporen').amount >= 1 then
    local sporenamount = Player.Functions.GetItemByName('sporen').amount
    if sporenamount >= 25 then
        TriggerClientEvent('mms-drugs:client:sporenworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('sporen', 25)
        Player.Functions.AddItem('pilze', 5)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['sporen'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Sporen zu 5 Pilze Verarbeitet', description =  'Verarbeitet', type = 'Sporen' })
    elseif sporenamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. sporenamount .. ' Sporen', description =  'Sporen Fehlen', type = 'Sporen' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Sporen zum Verarbeiten', description =  'Sporen Fehlen', type = 'Sporen' }) 
end
end)

RegisterNetEvent('mms-drugs:server:sporenworker10', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('sporen') and Player.Functions.GetItemByName('sporen').amount >= 1 then
    local sporenamount = Player.Functions.GetItemByName('sporen').amount
    if sporenamount >= 50 then
        TriggerClientEvent('mms-drugs:client:sporenworkercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('sporen', 50)
        Player.Functions.AddItem('pilze', 10)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['sporen'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Sporen zu 10 Pilze Verarbeitet', description =  'Verarbeitet', type = 'Sporen' })
    elseif sporenamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. sporenamount .. ' Sporen', description =  'Sporen Fehlen', type = 'Sporen' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Sporen zum Verarbeiten', description =  'Sporen Fehlen', type = 'Sporen' }) 
end
end)

-- Pilze Verkaufen

RegisterNetEvent('mms-drugs:server:pilzeseller1', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('pilze') and Player.Functions.GetItemByName('pilze').amount >= 1 then
    local pilzamount = Player.Functions.GetItemByName('pilze').amount
    if pilzamount >= 1 then
        TriggerClientEvent('mms-drugs:client:pilzesellercircle',src)
        Citizen.Wait(3000)
        Player.Functions.RemoveItem('pilze', 1)
        Player.Functions.AddMoney('cash',Config.sellpricepilze)
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 1 Pilz für ' .. Config.sellpricepilze ..' $ Verkauft', description =  'Verkauft', type = 'Pilze' })
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "remove")
    end
    else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Pilze zum Verkaufen', description =  'Pilze Fehlen.', type = 'Pilze' })
    end
end)

RegisterNetEvent('mms-drugs:server:pilzeseller5', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('pilze') and Player.Functions.GetItemByName('pilze').amount >= 1 then
        local pilzamount = Player.Functions.GetItemByName('pilze').amount
        if pilzamount >= 5 then
            TriggerClientEvent('mms-drugs:client:pilzesellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('pilze', 5)
            Player.Functions.AddMoney('cash',Config.sellpricepilze * 5)
            TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 5 Pilze für ' .. Config.sellpricepilze * 5 ..' $ Verkauft', description =  'Verkauft', type = 'Pilze' })
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "remove")
    elseif pilzamount < 5 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. pilzamount .. ' Pilze', description =  'Pilze Fehlen', type = 'Pilze' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Pilze zum Verkaufen', description =  'Pilze Fehlen.', type = 'Pilze' })
end

end)

RegisterNetEvent('mms-drugs:server:pilzeseller25', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('pilze') and Player.Functions.GetItemByName('pilze').amount >= 1 then
        local pilzamount = Player.Functions.GetItemByName('pilze').amount
        if pilzamount >= 25 then
            TriggerClientEvent('mms-drugs:client:pilzesellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('pilze', 25)
            Player.Functions.AddMoney('cash',Config.sellpricepilze * 5)
            TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 25 Pilze für ' .. Config.sellpricepilze * 25 ..' $ Verkauft', description =  'Verkauft', type = 'Pilze' })
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "remove")
    elseif pilzamount < 25 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. pilzamount .. ' Pilze', description =  'Pilze Fehlen', type = 'Pilze' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Pilze zum Verkaufen', description =  'Pilze Fehlen.', type = 'Pilze' })
end

end)

RegisterNetEvent('mms-drugs:server:pilzeseller50', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('pilze') and Player.Functions.GetItemByName('pilze').amount >= 1 then
        local pilzamount = Player.Functions.GetItemByName('pilze').amount
        if pilzamount >= 50 then
            TriggerClientEvent('mms-drugs:client:pilzesellercircle',src)
            Citizen.Wait(3000)
            Player.Functions.RemoveItem('pilze', 50)
            Player.Functions.AddMoney('cash',Config.sellpricepilze * 50)
            TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast 50 Pilze für ' .. Config.sellpricepilze * 50 ..' $ Verkauft', description =  'Verkauft', type = 'Pilze' })
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "remove")
    elseif pilzamount < 50 then
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nur ' .. pilzamount .. ' Pilze', description =  'Pilze Fehlen', type = 'Pilze' }) 
    end
else
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Pilze zum Verkaufen', description =  'Pilze Fehlen.', type = 'Pilze' })
end

end)


RSGCore.Functions.CreateUseableItem("joint", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('joint', 1) then
        TriggerClientEvent("mms-drugs:client:Smokeweed", source, 'joint')
        TriggerClientEvent("inventory:client:ItemBox", source, RSGCore.Shared.Items['joint'], "remove")
    end
end)

RSGCore.Functions.CreateUseableItem("pilze", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('pilze', 1) then
        TriggerClientEvent("mms-drugs:client:Eatpilz", source, 'pilze')
        TriggerClientEvent("inventory:client:ItemBox", source, RSGCore.Shared.Items['pilze'], "remove")
    end
end)

RSGCore.Functions.CreateUseableItem("kokainpulver", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('kokainpulver', 1) then
        TriggerClientEvent("mms-drugs:client:Takekokain", source, 'kokainpulver')
        TriggerClientEvent("inventory:client:ItemBox", source, RSGCore.Shared.Items['kokainpulver'], "remove")
    end
end)

RSGCore.Functions.CreateUseableItem("opiat", function(source, item)
    local Player = RSGCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('opiat', 1) then
        TriggerClientEvent("mms-drugs:client:Drinkopiat", source, 'opiat')
        TriggerClientEvent("inventory:client:ItemBox", source, RSGCore.Shared.Items['opiat'], "remove")
    end
end)


--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()