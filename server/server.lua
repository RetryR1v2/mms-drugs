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
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountweed .. ' Weed', description =  'Geerntet', type = 'success', duration = 5000 })
end)

--- Weed Verarbeiter

RegisterNetEvent('mms-drugs:server:weedworker', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('weed') and Player.Functions.GetItemByName('weed').amount >= Config.ReciepeWeedNeeded * anzahl then
        TriggerClientEvent('mms-drugs:client:weedworkercircle',src,anzahl)
        Citizen.Wait(Config.WorktimeWeedWorker * anzahl)
        Player.Functions.RemoveItem('weed', Config.ReciepeWeedNeeded * anzahl)
        Player.Functions.AddItem('joint', Config.ReciepeJointReward * anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['weed'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '..Config.ReciepeWeedNeeded * anzahl .. ' Weed zu '..Config.ReciepeJointReward * anzahl..' Joint verarbeitet!', description =  'Verarbeitet', type = 'success', duration = 5000 })
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nicht genug Weed!', description =  'Weed Fehlt', type = 'error' }) 
    end
end)



-- Joints Verkaufen

RegisterNetEvent('mms-drugs:server:weedseller', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('joint') and Player.Functions.GetItemByName('joint').amount >= Config.SellJointAmount * anzahl then
        TriggerClientEvent('mms-drugs:client:weedsellercircle',src,anzahl)
        Citizen.Wait(Config.SellJointTime * anzahl)
        Player.Functions.RemoveItem('joint', Config.SellJointAmount*anzahl)
        Player.Functions.AddMoney('cash',Config.SellJointPrice*anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['joint'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '.. Config.SellJointAmount*anzahl .. ' Joints für '  ..Config.SellJointPrice*anzahl..'$ Verkauft', description =  'Verkauft', type = 'success', duration = 5000 }) 
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Joints zum Verkaufen', description =  'Joints Fehlen', type = 'error', duration = 5000 })
    end
end)



-------------------------------OPIUM----------------------------------------------

-- Opium Erenten

RegisterNetEvent('mms-drugs:server:giveopium', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('opium', Config.amountopium)
    TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "add")
    TriggerClientEvent('ox_lib:notify', src, {title = 'Du Erntest ' .. Config.amountopium .. ' Opium', description =  'Geerntet', type = 'Opium' })
end)

--- Opium Verarbeiter

RegisterNetEvent('mms-drugs:server:opiumworker', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opium') and Player.Functions.GetItemByName('opium').amount >= Config.ReciepeOpiumNeeded * anzahl then
        TriggerClientEvent('mms-drugs:client:opiumworkercircle',src,anzahl)
        Citizen.Wait(Config.WorktimeOpiumWorker * anzahl)
        Player.Functions.RemoveItem('opium', Config.ReciepeOpiumNeeded * anzahl)
        Player.Functions.AddItem('opiat', Config.ReciepeOpiatReward * anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opium'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '..Config.ReciepeOpiumNeeded * anzahl .. ' Opium zu '..Config.ReciepeJointReward * anzahl..' Joint verarbeitet!', description =  'Verarbeitet', type = 'success', duration = 5000 })
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nicht genug Opium!', description =  'Opium Fehlt', type = 'error' }) 
    end
end)


-- Opiate Verkaufen

RegisterNetEvent('mms-drugs:server:opiatseller', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('opiat') and Player.Functions.GetItemByName('opiat').amount >= Config.SellOpiatAmount * anzahl then
        TriggerClientEvent('mms-drugs:client:opiatsellercircle',src,anzahl)
        Citizen.Wait(Config.SellOpiatTime * anzahl)
        Player.Functions.RemoveItem('opiat', Config.SellOpiatAmount*anzahl)
        Player.Functions.AddMoney('cash',Config.SellOpiatPrice*anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['opiat'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '.. Config.SellOpiatAmount*anzahl .. ' Opiate für '  ..Config.SellOpiatPrice*anzahl..'$ Verkauft', description =  'Verkauft', type = 'success', duration = 5000 }) 
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Opiate zum Verkaufen', description =  'Opiate Fehlen', type = 'error', duration = 5000 })
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

RegisterNetEvent('mms-drugs:server:kokainworker', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokain') and Player.Functions.GetItemByName('kokain').amount >= Config.ReciepeKokainNeeded * anzahl then
        TriggerClientEvent('mms-drugs:client:kokainworkercircle',src,anzahl)
        Citizen.Wait(Config.WorktimeKokainWorker * anzahl)
        Player.Functions.RemoveItem('kokain', Config.ReciepeKokainNeeded * anzahl)
        Player.Functions.AddItem('kokainpulver', Config.ReciepeKokainReward * anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokain'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '..Config.ReciepeKokainNeeded * anzahl .. ' Kokain zu '..Config.ReciepeKokainReward * anzahl..' Kokain Pulver verarbeitet!', description =  'Verarbeitet', type = 'success', duration = 5000 })
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nicht genug Kokain!', description =  'Kokain Fehlt', type = 'error' }) 
    end
end)

-- Kokain Verkaufen

RegisterNetEvent('mms-drugs:server:kokainseller', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('kokainpulver') and Player.Functions.GetItemByName('kokainpulver').amount >= Config.SellKokainAmount * anzahl then
        TriggerClientEvent('mms-drugs:client:kokainsellercircle',src,anzahl)
        Citizen.Wait(Config.SellKokainTime * anzahl)
        Player.Functions.RemoveItem('kokainpulver', Config.SellKokainAmount*anzahl)
        Player.Functions.AddMoney('cash',Config.SellKokainPrice*anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['kokainpulver'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '.. Config.SellKokainAmount*anzahl .. ' Kokainpulver für '  ..Config.SellKokainPrice*anzahl..'$ Verkauft', description =  'Verkauft', type = 'success', duration = 5000 }) 
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast kein Kokain Pulver zum Verkaufen', description =  'Kokain Pulver Fehlt!', type = 'error', duration = 5000 })
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

RegisterNetEvent('mms-drugs:server:sporenworker', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('sporen') and Player.Functions.GetItemByName('sporen').amount >= Config.ReciepeSporenNeeded * anzahl then
        TriggerClientEvent('mms-drugs:client:sporenworkercircle',src,anzahl)
        Citizen.Wait(Config.WorktimeSporenWorker * anzahl)
        Player.Functions.RemoveItem('sporen', Config.ReciepeSporenNeeded * anzahl)
        Player.Functions.AddItem('pilze', Config.ReciepeSporenReward * anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['sporen'], "remove")
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "add")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '..Config.ReciepeSporenNeeded * anzahl .. ' Sporen zu '..Config.ReciepeSporenReward * anzahl..' Pilzen verarbeitet!', description =  'Verarbeitet', type = 'success', duration = 5000 })
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast nicht genug Sporen!', description =  'Kokain Fehlt', type = 'error' }) 
    end
end)



-- Pilze Verkaufen

RegisterNetEvent('mms-drugs:server:pilzeseller', function(anzahl)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('pilze') and Player.Functions.GetItemByName('pilze').amount >= Config.SellPilzAmount * anzahl then
        TriggerClientEvent('mms-drugs:client:pilzsellercircle',src,anzahl)
        Citizen.Wait(Config.SellPilzTime * anzahl)
        Player.Functions.RemoveItem('pilze', Config.SellPilzAmount*anzahl)
        Player.Functions.AddMoney('cash',Config.SellPilzPrice*anzahl)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pilze'], "remove")
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast '.. Config.SellPilzAmount*anzahl .. ' Pilze für '  ..Config.SellPilzPrice*anzahl..'$ Verkauft', description =  'Verkauft', type = 'success', duration = 5000 }) 
    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Du hast keine Pilze zum Verkaufen!', description =  'Pilze Fehlen!', type = 'error', duration = 5000 })
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