local RSGCore = exports['rsg-core']:GetCoreObject()
local spawnedweed = false
local spawnedopium = false
local spawnedkokain = false
local spawnedsporen = false
local busy = false
local cooldownSecondsRemaining = 0
local smoked = 0
local eaten = 0
local taken = 0
local drunken = 0

-----------------------------------------------------------------------------Utilities------------------------------------------------

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
	RequestAnimDict(dict)
	local dur = duration or -1
	local flag = flags or 1
	local intro = tonumber(introtiming) or 1.0
	local exit = tonumber(exittiming) or 1.0

	while not HasAnimDictLoaded(dict)  do
		RequestAnimDict(dict)
		Citizen.Wait(300)
	end
	TaskPlayAnim(actor, dict, body, intro, exit, dur, flag, 1, false, false, false, 0, true)
end


----- Smoke Joint  amb_wander@code_human_smoking_wander@cigar@male_a@base  base

RegisterNetEvent('mms-drugs:client:Smokeweed')
AddEventHandler('mms-drugs:client:Smokeweed', function(joint)

    local cigarette = CreateObject(GetHashKey('p_cigarette_cs02x'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    local mouth = GetEntityBoneIndexByName(PlayerPedId(), "skel_head")
	
    AttachEntityToEntity(cigarette, PlayerPedId(), mouth, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
    Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@stand_enter","enter_back_rf",9400,0)
    Wait(1000)
    AttachEntityToEntity(cigarette, PlayerPedId(), righthand, 0.03, -0.01, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)
    Wait(1000)
    AttachEntityToEntity(cigarette, PlayerPedId(), mouth, -0.017, 0.1, -0.01, 0.0, 90.0, -90.0, true, true, false, true, 1, true)
    Wait(3000)
    AttachEntityToEntity(cigarette, PlayerPedId(), righthand, 0.017, -0.01, -0.01, 0.0, 120.0, 10.0, true, true, false, true, 1, true)
    Wait(1000)
    Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_c@base","base",-1,30)
    RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
    Wait(2000)
	ClearPedTasks(PlayerPedId())
	Anim(PlayerPedId(), "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
	Wait(2800)
	DetachEntity(cigarette, true, true)
	SetEntityVelocity(cigarette, 0.0,0.0,-1.0)
	Wait(1500)
	ClearPedTasks(PlayerPedId())

    Stoned()
end)

function Stoned()
    if smoked <= 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('playerdrugshalluc01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('playerdrugshalluc01')
        smoked = smoked +1
    elseif smoked >= 2 then
        local passout = math.random(1,5)
        local ped = PlayerPedId()
        if passout == 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        SetPedToRagdoll(ped,Config.passouttime,Config.passouttime)
        AnimpostfxPlay('playerdrugshalluc01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('playerdrugshalluc01')
        smoked = 0
        elseif passout >= 2 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('playerdrugshalluc01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('playerdrugshalluc01')
        end
    end
end

----- Esse Pilze  amb_wander@code_human_smoking_wander@cigar@male_a@base  base

RegisterNetEvent('mms-drugs:client:Eatpilz')
AddEventHandler('mms-drugs:client:Eatpilz', function(joint)
    mushroom = CreateObject(GetHashKey('s_amedmush'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    AttachEntityToEntity(mushroom, PlayerPedId(), righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
	Anim(PlayerPedId(), "mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese", "quick_right_hand", -1, 30)
	Wait(3000)
	
	DeleteEntity(mushroom)
	ClearPedTasks(PlayerPedId())
    Pilz()
end)

function Pilz()
    if eaten <= 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrugsPoisonWell')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrugsPoisonWell')
        eaten = eaten +1
    elseif eaten >= 2 then
        local passout = math.random(1,5)
        local ped = PlayerPedId()
        if passout == 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        SetPedToRagdoll(ped,Config.passouttime,Config.passouttime)
        AnimpostfxPlay('PlayerDrugsPoisonWell')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrugsPoisonWell')
        eaten = 0
        elseif passout >= 2 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrugsPoisonWell')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrugsPoisonWell')
        end
    end
end

----- Nehme Kokain  amb_wander@code_human_smoking_wander@cigar@male_a@base  base

RegisterNetEvent('mms-drugs:client:Takekokain')
AddEventHandler('mms-drugs:client:Takekokain', function(joint)
    kokain = CreateObject(GetHashKey('p_garlic_02x'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    AttachEntityToEntity(kokain, PlayerPedId(), righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
	Anim(PlayerPedId(), "mech_inventory@eating@multi_bite@wedge_a4-2_b0-75_w8_h9-4_eat_cheese", "quick_right_hand", -1, 30)
	Wait(3000)
	
	DeleteEntity(kokain)
	ClearPedTasks(PlayerPedId())

    Koks()
end)

function Koks()
    if taken <= 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrunk01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunk01')
        taken = taken +1
    elseif taken >= 2 then
        local passout = math.random(1,5)
        local ped = PlayerPedId()
        if passout == 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        SetPedToRagdoll(ped,Config.passouttime,Config.passouttime)
        AnimpostfxPlay('PlayerDrunk01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunk01')
        taken = 0
        elseif passout >= 2 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrunk01')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunk01')
        end
    end
end

---- Trinke Opiate  amb_wander@code_human_smoking_wander@cigar@male_a@base  base

RegisterNetEvent('mms-drugs:client:Drinkopiat')
AddEventHandler('mms-drugs:client:Drinkopiat', function(joint)
    local pipe = CreateObject(GetHashKey('P_PIPE01X'), GetEntityCoords(PlayerPedId()), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_R_Finger13")
    AttachEntityToEntity(pipe, PlayerPedId(), righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
    Anim(PlayerPedId(),"amb_wander@code_human_smoking_wander@male_b@trans","nopipe_trans_pipe",-1,30)
    Wait(8000)
	Anim(PlayerPedId(), "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
	Wait(500)
	DeleteEntity(pipe)
	ClearPedTasks(PlayerPedId())
    Opiat()
end)

function Opiat()
    if drunken <= 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrunkAberdeen')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunkAberdeen')
        drunken = drunken +1
    elseif drunken >= 2 then
        local passout = math.random(1,5)
        local ped = PlayerPedId()
        if passout == 1 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        SetPedToRagdoll(ped,Config.passouttime,Config.passouttime)
        AnimpostfxPlay('PlayerDrunkAberdeen')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunkAberdeen')
        drunken = 0
        elseif passout >= 2 then
        TriggerServerEvent("RSGCore:Server:SetMetaData", "hunger", RSGCore.Functions.GetPlayerData().metadata["hunger"] - 10)
        TriggerServerEvent("RSGCore:Server:SetMetaData", "thirst", RSGCore.Functions.GetPlayerData().metadata["thirst"] - 10)
        AnimpostfxPlay('PlayerDrunkAberdeen')
        Citizen.Wait(Config.hightime)
        AnimpostfxStop('PlayerDrunkAberdeen')
        end
    end
end


--- Loading Circles for Crafting

RegisterNetEvent('mms-drugs:client:weedworkercircle')
AddEventHandler('mms-drugs:client:weedworkercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verarbeite Weed',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:weedsellercircle')
AddEventHandler('mms-drugs:client:weedsellercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verkaufe Joints',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:opiumworkercircle')
AddEventHandler('mms-drugs:client:opiumworkercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verarbeite Opium',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:opiatsellercircle')
AddEventHandler('mms-drugs:client:opiatsellercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verkaufe Opiate',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:kokainworkercircle')
AddEventHandler('mms-drugs:client:kokainworkercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verarbeite Kokain',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:kokainsellercircle')
AddEventHandler('mms-drugs:client:kokainsellercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verkaufe Kokain Pulver',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:sporenworkercircle')
AddEventHandler('mms-drugs:client:sporenworkercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verarbeite Sporen',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:pilzesellercircle')
AddEventHandler('mms-drugs:client:pilzesellercircle', function(weedworker)
    lib.progressCircle({
        duration = 2800, -- Adjust the duration as needed
        label = 'Verkaufe Pilze',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

-- ped crouch
function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

-- cooldown timer
function cooldownTimer()
    cooldownSecondsRemaining = Config.Cooldown
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
            --print(cooldownSecondsRemaining)
        end
    end)
end

-----------------------------------------------------------------------------Weed------------------------------------------------

-- prompt and blip for weed Plants
Citizen.CreateThread(function()
    for weed,v in pairs(Config.weedplant) do
        exports['rsg-core']:createPrompt(v.name, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checkweedplant',
            args = { v.name },
        })
        if v.showblip == true then
            local weedblip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(weedblip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(weedblip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, weedblip, Config.Blip.blipName)
        end
    end
end)

-- spawn weed plant
Citizen.CreateThread(function()
    while true do
    Wait(0)
        local hash = GetHashKey('s_hummingbirdsage01x')
        while not HasModelLoaded(hash) do
            Wait(10)
            RequestModel(hash)
        end
        if spawnedweed == false then
            for weed,v in pairs(Config.weedplant) do
                RequestModel(hash)
                weedplant = CreateObject(hash, v.coords -1, true, false, false) 
                SetEntityAsMissionEntity(weedplant, true)
                PlaceObjectOnGroundProperly(weedplant, true)
                FreezeEntityPosition(weedplant, true)
                spawnedweed = true
            end
        end
    end
end)

-- trigger haverest
RegisterNetEvent('mms-drugs:client:checkweedplant')
AddEventHandler('mms-drugs:client:checkweedplant', function(weedplant)
    local ped = PlayerPedId()
    if busy == false and cooldownSecondsRemaining == 0 then
        busy = true
        CrouchAnim()
        lib.progressCircle({
            duration = 5000, -- Adjust the duration as needed
            label = 'Ernte Weed',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:giveweed')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'Wachstum')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for weedworker,v in pairs(Config.weedworker) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:menu',
            args = {},
        })
        if v.showblipworker == true then
            local weedworker = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(weedworker, GetHashKey(Config.BlipWorker.blipSprite), true)
            SetBlipScale(weedworker, Config.BlipWorker.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, weedworker, Config.BlipWorker.blipName)
        end
    end
end)



-- Verarbeiter Menü

RegisterNetEvent('mms-drugs:client:menu', function()
    lib.registerContext(
        {
            id = 'weedworker',
            title = ('Weed Verarbeiter Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Weed Verarbeiten'),
                    description = ('5 Weed = 1 Joint'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:worker',
                },
                {
                    title = ('Weed Verarbeiten'),
                    description = ('25 Weed = 5 Joint'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:worker5',
                },
                {
                    title = ('Weed Verarbeiten'),
                    description = ('50 Weed = 10 Joint'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:worker10',
                },
            }
        }
    )
    lib.showContext('weedworker')
end)

RegisterNetEvent('mms-drugs:client:worker')
AddEventHandler('mms-drugs:client:worker', function(weedworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedworker' ,1)

end)

RegisterNetEvent('mms-drugs:client:worker5')
AddEventHandler('mms-drugs:client:worker5', function(weedworker5)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedworker5' ,1)

end)

RegisterNetEvent('mms-drugs:client:worker10')
AddEventHandler('mms-drugs:client:worker10', function(weedworker10)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedworker10' ,1)

end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for weedseller,v in pairs(Config.weedseller) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:sellermenu',
            args = {},
        })
        if v.showblipseller == true then
            local weedseller = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(weedseller, GetHashKey(Config.BlipSeller.blipSprite), true)
            SetBlipScale(weedseller, Config.BlipSeller.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, weedseller, Config.BlipSeller.blipName)
        end
    end
end)



-- Verkäufer Menü

RegisterNetEvent('mms-drugs:client:sellermenu', function()
    lib.registerContext(
        {
            id = 'weedseller',
            title = ('Weed Verkäufer Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Weed Verkäufer 1 Joint'),
                    description = ('1 Joint = ' .. Config.sellprice .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:seller1',
                },
                {
                    title = ('Weed Verkäufer 5 Joints'),
                    description = ('5 Joints = ' .. Config.sellprice * 5 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:seller5',
                },
                {
                    title = ('Weed Verkäufer 25 Joints'),
                    description = ('25 Joints = ' .. Config.sellprice * 25 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:seller25',
                },
                {
                    title = ('Weed Verkäufer 50 Joints'),
                    description = ('50 Joints = ' .. Config.sellprice * 50 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:seller50',
                },
            }
        }
    )
    lib.showContext('weedseller')
end)

RegisterNetEvent('mms-drugs:client:seller1')
AddEventHandler('mms-drugs:client:seller1', function(weedworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedseller1' ,1)
end)

RegisterNetEvent('mms-drugs:client:seller5')
AddEventHandler('mms-drugs:client:seller5', function(weedworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedseller5' ,1)
end)

RegisterNetEvent('mms-drugs:client:seller25')
AddEventHandler('mms-drugs:client:seller25', function(weedworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedseller25' ,1)
end)

RegisterNetEvent('mms-drugs:client:seller50')
AddEventHandler('mms-drugs:client:seller50', function(weedworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:weedseller50' ,1)
end)

-----------------------------------------------------------------------------OPIUM------------------------------------------------

-- prompt and blip for Opium Plants

Citizen.CreateThread(function()
    for weed,v in pairs(Config.opiumplant) do
        exports['rsg-core']:createPrompt(v.name, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checkopiumplant',
            args = { v.name },
        })
        if v.showblipopium == true then
            local opiumblip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(opiumblip, GetHashKey(Config.Blipopiumplant.blipSprite), true)
            SetBlipScale(opiumblip, Config.Blipopiumplant.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, opiumblip, Config.Blipopiumplant.blipName)
        end
    end
end)

-- spawn Opium plant
Citizen.CreateThread(function()
    while true do
    Wait(0)
        local hashopium = GetHashKey('redsage_p')
        while not HasModelLoaded(hashopium) do
            Wait(10)
            RequestModel(hashopium)
        end
        if spawnedopium == false then
            for opium,v in pairs(Config.opiumplant) do
                RequestModel(hashopium)
                opiumplant = CreateObject(hashopium, v.coords -1, true, false, false) 
                SetEntityAsMissionEntity(opiumplant, true)
                PlaceObjectOnGroundProperly(opiumplant, true)
                FreezeEntityPosition(opiumplant, true)
                spawnedopium = true
            end
        end
    end
end)

-- trigger ernte
RegisterNetEvent('mms-drugs:client:checkopiumplant')
AddEventHandler('mms-drugs:client:checkopiumplant', function(opiumplant)
    local ped = PlayerPedId()
    if busy == false and cooldownSecondsRemaining == 0 then
        busy = true
        CrouchAnim()
        lib.progressCircle({
            duration = 5000, -- Adjust the duration as needed
            label = 'Ernte Opium',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:giveopium')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'Wachstum')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for opiumworker,v in pairs(Config.opiumworker) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:opiummenu',
            args = {},
        })
        if v.showblipopiumworker == true then
            local opiumworker = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(opiumworker, GetHashKey(Config.BlipOpiumWorker.blipSprite), true)
            SetBlipScale(opiumworker, Config.BlipOpiumWorker.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, opiumworker, Config.BlipOpiumWorker.blipName)
        end
    end
end)



-- Verarbeiter Menü

RegisterNetEvent('mms-drugs:client:opiummenu', function()
    lib.registerContext(
        {
            id = 'opiumworker',
            title = ('Opium Verarbeiter Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Opium Verarbeiten'),
                    description = ('5 Opium = 1 Opiat'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiumworker',
                },
                {
                    title = ('Opium Verarbeiten'),
                    description = ('25 Opium = 5 Opiat'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiumworker5',
                },
                {
                    title = ('Opium Verarbeiten'),
                    description = ('50 Opium = 10 Opiat'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiumworker10',
                },
            }
        }
    )
    lib.showContext('opiumworker')
end)

RegisterNetEvent('mms-drugs:client:opiumworker')
AddEventHandler('mms-drugs:client:opiumworker', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiumworker' ,1)
end)

RegisterNetEvent('mms-drugs:client:opiumworker5')
AddEventHandler('mms-drugs:client:opiumworker5', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiumworker5' ,1)
end)

RegisterNetEvent('mms-drugs:client:opiumworker10')
AddEventHandler('mms-drugs:client:opiumworker10', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiumworker10' ,1)
end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for opiatseller,v in pairs(Config.opiatseller) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:opiatsellermenu',
            args = {},
        })
        if v.showblipseller == true then
            local opiatseller = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(opiatseller, GetHashKey(Config.BlipOpiatSeller.blipSprite), true)
            SetBlipScale(opiatseller, Config.BlipOpiatSeller.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, opiatseller, Config.BlipOpiatSeller.blipName)
        end
    end
end)



-- Verkäufer Menü

RegisterNetEvent('mms-drugs:client:opiatsellermenu', function()
    lib.registerContext(
        {
            id = 'opiatseller',
            title = ('Opiat Verkäufer Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Opiat Verkäufer'),
                    description = ('1 Opiat = ' .. Config.sellpriceopiat .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiatseller1',
                },
                {
                    title = ('Opiat Verkäufer'),
                    description = ('5 Opiate = ' .. Config.sellpriceopiat * 5 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiatseller5',
                },
                {
                    title = ('Opiat Verkäufer'),
                    description = ('25 Opiate = ' .. Config.sellpriceopiat * 25 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiatseller25',
                },
                {
                    title = ('Opiat Verkäufer'),
                    description = ('50 Opiate = ' .. Config.sellpriceopiat * 50 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:opiatseller50',
                },
            }
        }
    )
    lib.showContext('opiatseller')
end)

RegisterNetEvent('mms-drugs:client:opiatseller1')
AddEventHandler('mms-drugs:client:opiatseller1', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiatseller1' ,1)
end)

RegisterNetEvent('mms-drugs:client:opiatseller5')
AddEventHandler('mms-drugs:client:opiatseller5', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiatseller5' ,1)
end)

RegisterNetEvent('mms-drugs:client:opiatseller25')
AddEventHandler('mms-drugs:client:opiatseller25', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiatseller25' ,1)
end)

RegisterNetEvent('mms-drugs:client:opiatseller50')
AddEventHandler('mms-drugs:client:opiatseller50', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:opiatseller50' ,1)
end)

-----------------------------------------------------------------------------Kokain------------------------------------------------

-- prompt and blip for Kokain Plants

Citizen.CreateThread(function()
    for kokain,v in pairs(Config.kokainplant) do
        exports['rsg-core']:createPrompt(v.name, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checkkokainplant',
            args = { v.name },
        })
        if v.showblipkokain == true then
            local kokainblip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(kokainblip, GetHashKey(Config.Blipkokainlant.blipSprite), true)
            SetBlipScale(kokainblip, Config.Blipkokainplant.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, kokainblip, Config.Blipkokainplant.blipName)
        end
    end
end)

-- spawn Kokain plant
Citizen.CreateThread(function()
    while true do
    Wait(0)
        local hashkokain = GetHashKey('s_inv_raspberry01x')
        while not HasModelLoaded(hashkokain) do
            Wait(10)
            RequestModel(hashkokain)
        end
        if spawnedkokain == false then
            for kokain,v in pairs(Config.kokainplant) do
                RequestModel(hashkokain)
                kokainplant = CreateObject(hashkokain, v.coords -1, true, false, false) 
                SetEntityAsMissionEntity(kokainplant, true)
                PlaceObjectOnGroundProperly(kokainplant, true)
                FreezeEntityPosition(kokainplant, true)
                spawnedkokain = true
            end
        end
    end
end)

-- trigger ernte
RegisterNetEvent('mms-drugs:client:checkkokainplant')
AddEventHandler('mms-drugs:client:checkkokainplant', function(kokainplant)
    local ped = PlayerPedId()
    if busy == false and cooldownSecondsRemaining == 0 then
        busy = true
        CrouchAnim()
        lib.progressCircle({
            duration = 5000, -- Adjust the duration as needed
            label = 'Ernte Kokain',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:givekokain')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'Wachstum')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for kokainworker,v in pairs(Config.kokainworker) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:kokainmenu',
            args = {},
        })
        if v.showblipkokainworker == true then
            local kokainworker = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(kokainworker, GetHashKey(Config.BlipKokainWorker.blipSprite), true)
            SetBlipScale(kokainworker, Config.BlipKokainWorker.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, kokainworker, Config.BlipKokainWorker.blipName)
        end
    end
end)



-- Verarbeiter Menü

RegisterNetEvent('mms-drugs:client:kokainmenu', function()
    lib.registerContext(
        {
            id = 'kokainworker',
            title = ('Kokain Verarbeiter Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Kokain Verarbeiten'),
                    description = ('5 Kokain = 1 Kokain Pulver'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainworker',
                },
                {
                    title = ('Kokain Verarbeiten'),
                    description = ('25 Kokain = 5 Kokain Pulver'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainworker5',
                },
                {
                    title = ('Kokain Verarbeiten'),
                    description = ('50 Kokain = 10 Kokain Pulver'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainworker10',
                },
            }
        }
    )
    lib.showContext('kokainworker')
end)

RegisterNetEvent('mms-drugs:client:kokainworker')
AddEventHandler('mms-drugs:client:kokainworker', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainworker' ,1)
end)

RegisterNetEvent('mms-drugs:client:kokainworker5')
AddEventHandler('mms-drugs:client:kokainworker5', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainworker5' ,1)
end)

RegisterNetEvent('mms-drugs:client:kokainworker10')
AddEventHandler('mms-drugs:client:kokainworker10', function(opiumworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainworker10' ,1)
end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for kokainseller,v in pairs(Config.kokainseller) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:kokainsellermenu',
            args = {},
        })
        if v.showblipseller == true then
            local kokainseller = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(kokainseller, GetHashKey(Config.BlipKokainSeller.blipSprite), true)
            SetBlipScale(kokainseller, Config.BlipKokainSeller.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, kokainseller, Config.BlipKokainSeller.blipName)
        end
    end
end)



-- Verkäufer Menü

RegisterNetEvent('mms-drugs:client:kokainsellermenu', function()
    lib.registerContext(
        {
            id = 'kokainseller',
            title = ('Kokain Verkäufer Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Kokain Verkäufer'),
                    description = ('1 Kokain Pulver = ' .. Config.sellpricekokain .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainseller1',
                },
                {
                    title = ('Kokain Verkäufer'),
                    description = ('5 Kokain Pulver = ' .. Config.sellpricekokain * 5 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainseller5',
                },
                {
                    title = ('Kokain Verkäufer'),
                    description = ('25 Kokain Pulver = ' .. Config.sellpricekokain * 25 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainseller25',
                },
                {
                    title = ('Kokain Verkäufer'),
                    description = ('50 Kokain Pulver = ' .. Config.sellpricekokain * 50 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:kokainseller50',
                },
            }
        }
    )
    lib.showContext('kokainseller')
end)

RegisterNetEvent('mms-drugs:client:kokainseller1')
AddEventHandler('mms-drugs:client:kokainseller1', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainseller1' ,1)
end)

RegisterNetEvent('mms-drugs:client:kokainseller5')
AddEventHandler('mms-drugs:client:kokainseller5', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainseller5' ,1)
end)

RegisterNetEvent('mms-drugs:client:kokainseller25')
AddEventHandler('mms-drugs:client:kokainseller25', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainseller25' ,1)
end)

RegisterNetEvent('mms-drugs:client:kokainseller50')
AddEventHandler('mms-drugs:client:kokainseller50', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:kokainseller50' ,1)
end)

-----------------------------------------------------------------------------Pilze------------------------------------------------

-- prompt and blip for Sporen Plants

Citizen.CreateThread(function()
    for sporen,v in pairs(Config.sporenplant) do
        exports['rsg-core']:createPrompt(v.name, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checksporenplant',
            args = { v.name },
        })
        if v.showblipsporen == true then
            local sporenblip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(sporenblip, GetHashKey(Config.Blipsporenplant.blipSprite), true)
            SetBlipScale(sporenblip, Config.Blipsporenplant.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, sporenblip, Config.Blipsporenplant.blipName)
        end
    end
end)

-- spawn Sporen plant
Citizen.CreateThread(function()
    while true do
    Wait(0)
        local hashpilze = GetHashKey('s_inv_baybolete01bx')
        while not HasModelLoaded(hashpilze) do
            Wait(10)
            RequestModel(hashpilze)
        end
        if spawnedsporen == false then
            for sporen,v in pairs(Config.sporenplant) do
                RequestModel(hashpilze)
                sporenplant = CreateObject(hashpilze, v.coords -1, true, false, false) 
                SetEntityAsMissionEntity(sporenplant, true)
                PlaceObjectOnGroundProperly(sporenplant, true)
                FreezeEntityPosition(sporenplant, true)
                spawnedsporen = true
            end
        end
    end
end)

-- trigger ernte
RegisterNetEvent('mms-drugs:client:checksporenplant')
AddEventHandler('mms-drugs:client:checksporenplant', function(sporenplant)
    local ped = PlayerPedId()
    if busy == false and cooldownSecondsRemaining == 0 then
        busy = true
        CrouchAnim()
        lib.progressCircle({
            duration = 5000, -- Adjust the duration as needed
            label = 'Ernte Sporen',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:givesporen')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'Wachstum')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for sporenworker,v in pairs(Config.sporenworker) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:sporenmenu',
            args = {},
        })
        if v.showblipsporenworker == true then
            local sporenworker = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(sporenworker, GetHashKey(Config.BlipSporenWorker.blipSprite), true)
            SetBlipScale(sporenworker, Config.BlipSporenWorker.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, sporenworker, Config.BlipSporenWorker.blipName)
        end
    end
end)



-- Verarbeiter Menü

RegisterNetEvent('mms-drugs:client:sporenmenu', function()
    lib.registerContext(
        {
            id = 'sporenworker',
            title = ('Sporen Verarbeiter Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Sporen Verarbeiten'),
                    description = ('5 Sporen = 1 Pilze'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:sporenworker',
                },
                {
                    title = ('Sporen Verarbeiten'),
                    description = ('25 Sporen = 5 Pilze'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:sporenworker5',
                },
                {
                    title = ('Sporen Verarbeiten'),
                    description = ('50 Sporen = 10 Pilze'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:sporenworker10',
                },
            }
        }
    )
    lib.showContext('sporenworker')
end)

RegisterNetEvent('mms-drugs:client:sporenworker')
AddEventHandler('mms-drugs:client:sporenworker', function(sporenworker)
        TriggerServerEvent('mms-drugs:server:sporenworker' ,1)
end)

RegisterNetEvent('mms-drugs:client:sporenworker5')
AddEventHandler('mms-drugs:client:sporenworker5', function(sporenworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:sporenworker5' ,1)
end)

RegisterNetEvent('mms-drugs:client:sporenworker10')
AddEventHandler('mms-drugs:client:sporenworker10', function(sporenworker)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:sporenworker10' ,1)
end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for pilzeseller,v in pairs(Config.pilzeseller) do
        exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:pilzesellermenu',
            args = {},
        })
        if v.showblipseller == true then
            local pilzeseller = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(pilzeseller, GetHashKey(Config.BlipPilzeSeller.blipSprite), true)
            SetBlipScale(pilzeseller, Config.BlipPilzeSeller.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, pilzeseller, Config.BlipPilzeSeller.blipName)
        end
    end
end)



-- Verkäufer Menü

RegisterNetEvent('mms-drugs:client:pilzesellermenu', function()
    lib.registerContext(
        {
            id = 'pilzeseller',
            title = ('Pilz Verkäufer Menu'),
            position = 'top-right',
            options = {
                {
                    title = ('Pilz Verkäufer'),
                    description = ('1 Pilz = ' .. Config.sellpricepilze .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:pilzeseller1',
                },
                {
                    title = ('Pilz Verkäufer'),
                    description = ('5 Pilze = ' .. Config.sellpricepilze * 5 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:pilzeseller5',
                },
                {
                    title = ('Pilz Verkäufer'),
                    description = ('25 Pilze = ' .. Config.sellpricepilze * 25 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:pilzeseller25',
                },
                {
                    title = ('Pilz Verkäufer'),
                    description = ('50 Pilze = ' .. Config.sellpricepilze * 50 .. ' $'),
                    icon = 'fas fa-paw',
                    event = 'mms-drugs:client:pilzeseller50',
                },
            }
        }
    )
    lib.showContext('pilzeseller')
end)

RegisterNetEvent('mms-drugs:client:pilzeseller1')
AddEventHandler('mms-drugs:client:pilzeseller1', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:pilzeseller1' ,1)
end)

RegisterNetEvent('mms-drugs:client:pilzeseller5')
AddEventHandler('mms-drugs:client:pilzeseller5', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:pilzeseller5' ,1)
end)

RegisterNetEvent('mms-drugs:client:pilzeseller25')
AddEventHandler('mms-drugs:client:pilzeseller25', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:pilzeseller25' ,1)
end)

RegisterNetEvent('mms-drugs:client:pilzeseller50')
AddEventHandler('mms-drugs:client:pilzeseller50', function(opiatseller)
        Wait(500)
        TriggerServerEvent('mms-drugs:server:pilzeseller50' ,1)
end)