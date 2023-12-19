local RSGCore = exports['rsg-core']:GetCoreObject()
FeatherMenu =  exports['feather-menu'].initiate()
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
AddEventHandler('mms-drugs:client:weedworkercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.WorktimeWeedWorker * anzahl, -- Adjust the duration as needed
        label = 'Verarbeite Weed',
        position = 'bottom',
        useWhileDead = false,
    })
end)

RegisterNetEvent('mms-drugs:client:weedsellercircle')
AddEventHandler('mms-drugs:client:weedsellercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.SellJointTime * anzahl, -- Adjust the duration as needed
        label = 'Verkaufe Joints',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:opiumworkercircle')
AddEventHandler('mms-drugs:client:opiumworkercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.WorktimeOpiumWorker * anzahl, -- Adjust the duration as needed
        label = 'Verarbeite Opium',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:opiatsellercircle')
AddEventHandler('mms-drugs:client:opiatsellercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.SellOpiatTime * anzahl, -- Adjust the duration as needed
        label = 'Verkaufe Opiate',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:kokainworkercircle')
AddEventHandler('mms-drugs:client:kokainworkercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.WorktimeKokainWorker * anzahl, -- Adjust the duration as needed
        label = 'Verarbeite Kokain',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:kokainsellercircle')
AddEventHandler('mms-drugs:client:kokainsellercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.SellKokainTime * anzahl, -- Adjust the duration as needed
        label = 'Verkaufe Kokain Pulver',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:sporenworkercircle')
AddEventHandler('mms-drugs:client:sporenworkercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.WorktimeSporenWorker, -- Adjust the duration as needed
        label = 'Verarbeite Sporen',
        position = 'bottom',
        useWhileDead = false, 
    })
end)

RegisterNetEvent('mms-drugs:client:pilzsellercircle')
AddEventHandler('mms-drugs:client:pilzsellercircle', function(anzahl)
    lib.progressCircle({
        duration = Config.SellPilzTime*anzahl, -- Adjust the duration as needed
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
        exports['rsg-core']:createPrompt(v.weedplantid, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
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
            end
            spawnedweed = true
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
            duration = Config.HaverestWeedTime, -- Adjust the duration as needed
            label = 'Ernte Weed',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:giveweed')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'info')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for weedworker,v in pairs(Config.weedworker) do
        exports['rsg-core']:createPrompt(v.weedworkerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:openweedworkermenu',
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
RegisterNetEvent('mms-drugs:client:openweedworkermenu')
AddEventHandler('mms-drugs:client:openweedworkermenu', function(inputValue)
    WeedVerarbeiterMenu:Open({
        startupPage = Page1, 
    })
end)



-- Verarbeiter Menü
Citizen.CreateThread(function()
WeedVerarbeiterMenu = FeatherMenu:RegisterMenu('feather:character:weedverarbeitermenu', {
    top = '40%',
    left = '20%',
    ['720width'] = '500px',
    ['1080width'] = '600px',
    ['2kwidth'] = '700px',
    ['4kwidth'] = '900px',
    style = {
        -- ['height'] = '500px'
        ['border'] = '5px solid green',
        -- ['background-image'] = 'none',
        ['background-color'] = '#006400'
    },
    contentslot = {
        style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
            ['height'] = '500px',
            ['min-height'] = '300px'
        }
    },
    draggable = true,
    --canclose = false
})
Page1 = WeedVerarbeiterMenu:RegisterPage('first:page1')
Page1:RegisterElement('header', {
    value = 'Weed Verarbeiter',
    slot = "header",
    style = {}
})
Page1:RegisterElement('line', {
    slot = "header",
    style = {}
})
TextDisplay1 = Page1:RegisterElement('textdisplay', {
    value = "Verarbeite dein Weed zu Joints!",
    style = {}
})
TextDisplay2 = Page1:RegisterElement('textdisplay', {
    value = 'Rezept: ' .. Config.ReciepeWeedNeeded.. ' Weed = '.. Config.ReciepeJointReward .. ' Joints!',
    style = {}
})
local dauer = Config.WorktimeWeedWorker / 1000
TextDisplay3 = Page1:RegisterElement('textdisplay', {
    value = 'Dauer: ' .. dauer .. ' Sekunden!',
    style = {}
})
local inputValue = ''
Page1:RegisterElement('input', {
    label = "Wie Oft Herstellen:",
    placeholder = "1",
    persist = false,
    style = {
    }
}, function(data)
    inputValue = data.value
end)
Page1:RegisterElement('button', {
    label = "Jetzt Verarbeiten",
    style = {
    },
}, function()
    TriggerEvent('mms-drugs:client:weedworker',inputValue)
end)
Page1:RegisterElement('button', {
    label = "Verarbeiter Verlassen",
    style = {
    },
}, function()
    WeedVerarbeiterMenu:Close({ 
    })
end)
Page1:RegisterElement('subheader', {
    value = "Weed Verarbeiter",
    slot = "footer",
    style = {}
})
Page1:RegisterElement('line', {
    slot = "footer",
    style = {}
})
end)


RegisterNetEvent('mms-drugs:client:weedworker')
AddEventHandler('mms-drugs:client:weedworker', function(inputValue)
        local anzahl = tostring(inputValue)
        TriggerServerEvent('mms-drugs:server:weedworker' ,anzahl)
end)


-- Verkäufer prompt

Citizen.CreateThread(function()
    for weedseller,v in pairs(Config.jointseller) do
        exports['rsg-core']:createPrompt(v.jointsellerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:jointsellermenu',
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

RegisterNetEvent('mms-drugs:client:jointsellermenu')
AddEventHandler('mms-drugs:client:jointsellermenu', function(inputValue)
    JointMenu:Open({
        startupPage = Page2,
    })
end)

Citizen.CreateThread(function()
    JointMenu = FeatherMenu:RegisterMenu('feather:character:weedverarbeitermenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page2 = JointMenu:RegisterPage('first:page2')
    Page2:RegisterElement('header', {
        value = 'Joint Verkäufer',
        slot = "header",
        style = {}
    })
    Page2:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay4 = Page1:RegisterElement('textdisplay', {
        value = "Verkaufe deine Joints!",
        style = {}
    })
    TextDisplay5 = Page1:RegisterElement('textdisplay', {
        value = 'Preis: ' .. Config.SellJointPrice.. ' $. Für ' .. Config.SellJointAmount.. ' Joints!',
        style = {}
    })
    local dauer = Config.SellJointTime / 1000
    TextDisplay6 = Page1:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page2:RegisterElement('input', {
        label = "Wieviele Verkaufen:",
        placeholder = "1",
        persist = false,
        style = {
        }
    }, function(data)
        inputValue = data.value
    end)
    Page2:RegisterElement('button', {
        label = "Jetzt Verkaufen",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:weedseller',inputValue)
    end)
    Page2:RegisterElement('button', {
        label = "Verkäufer Verlassen",
        style = {
        },
    }, function()
        JointMenu:Close({ 
        })
    end)
    Page2:RegisterElement('subheader', {
        value = "Joint Verkäufer",
        slot = "footer",
        style = {}
    })
    Page2:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    RegisterNetEvent('mms-drugs:client:weedseller')
    AddEventHandler('mms-drugs:client:weedseller', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:weedseller' ,anzahl)
    end)

-----------------------------------------------------------------------------OPIUM------------------------------------------------

-- prompt and blip for Opium Plants

Citizen.CreateThread(function()
    for weed,v in pairs(Config.opiumplant) do
        exports['rsg-core']:createPrompt(v.opiumplantid, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checkopiumplant',
            args = {  },
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
            duration = Config.HaverestOpiumTime, -- Adjust the duration as needed
            label = 'Ernte Opium',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:giveopium')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'info')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for opiumworker,v in pairs(Config.opiumworker) do
        exports['rsg-core']:createPrompt(v.opiumworkerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
            type = 'client',
            event = 'mms-drugs:client:openopiumworkermenu',
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



RegisterNetEvent('mms-drugs:client:openopiumworkermenu')
AddEventHandler('mms-drugs:client:openopiumworkermenu', function()
    OpiumMenu:Open({
        startupPage = Page3, 
    })
end)


-- Verarbeiter Menü
Citizen.CreateThread(function()
OpiumMenu = FeatherMenu:RegisterMenu('feather:character:opiummenu', {
    top = '40%',
    left = '20%',
    ['720width'] = '500px',
    ['1080width'] = '600px',
    ['2kwidth'] = '700px',
    ['4kwidth'] = '900px',
    style = {
        -- ['height'] = '500px'
        ['border'] = '5px solid green',
        -- ['background-image'] = 'none',
        ['background-color'] = '#006400'
    },
    contentslot = {
        style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
            ['height'] = '500px',
            ['min-height'] = '300px'
        }
    },
    draggable = true,
    --canclose = false
})
Page3 = OpiumMenu:RegisterPage('first:page3')
Page3:RegisterElement('header', {
    value = 'Opium Verarbeiter',
    slot = "header",
    style = {}
})
Page3:RegisterElement('line', {
    slot = "header",
    style = {}
})
TextDisplay7 = Page2:RegisterElement('textdisplay', {
    value = "Verarbeite dein Opium zu Opiate!",
    style = {}
})
TextDisplay8 = Page2:RegisterElement('textdisplay', {
    value = 'Rezept: ' .. Config.ReciepeOpiumNeeded.. ' Opium = '.. Config.ReciepeOpiatReward .. ' Opiate!',
    style = {}
})
local dauer = Config.WorktimeOpiumWorker / 1000
TextDisplay9 = Page2:RegisterElement('textdisplay', {
    value = 'Dauer: ' .. dauer .. ' Sekunden!',
    style = {}
})
local inputValue = ''
Page3:RegisterElement('input', {
    label = "Wie Oft Herstellen:",
    placeholder = "1",
    persist = false,
    style = {
   }
}, function(data)
    inputValue = data.value
end)
Page3:RegisterElement('button', {
    label = "Jetzt Verarbeiten",
    style = {
    },
}, function()
    TriggerEvent('mms-drugs:client:opiumworker',inputValue)
end)
Page3:RegisterElement('button', {
    label = "Verarbeiter Verlassen",
    style = {
    },
}, function()
    OpiumMenu:Close({ 
    })
end)
Page3:RegisterElement('subheader', {
    value = "Opium Verarbeiter",
    slot = "footer",
    style = {}
})
Page3:RegisterElement('line', {
    slot = "footer",
    style = {}
})
end)


RegisterNetEvent('mms-drugs:client:opiumworker')
AddEventHandler('mms-drugs:client:opiumworker', function(inputValue)
        local anzahl = tostring(inputValue)
        TriggerServerEvent('mms-drugs:server:opiumworker' ,anzahl)
end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for opiatseller,v in pairs(Config.opiatseller) do
        exports['rsg-core']:createPrompt(v.opiatsellerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
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

RegisterNetEvent('mms-drugs:client:opiatsellermenu')
AddEventHandler('mms-drugs:client:opiatsellermenu', function(inputValue)
    OpiatMenu:Open({
        startupPage = Page4,
    })
end)

Citizen.CreateThread(function()
    OpiatMenu = FeatherMenu:RegisterMenu('feather:character:opiatsellermenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page4 = OpiatMenu:RegisterPage('first:page4')
    Page4:RegisterElement('header', {
        value = 'Opiat Verkäufer',
        slot = "header",
        style = {}
    })
    Page4:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay10 = Page4:RegisterElement('textdisplay', {
        value = "Verkaufe deine Opiate!",
        style = {}
    })
    TextDisplay11 = Page4:RegisterElement('textdisplay', {
        value = 'Preis: ' .. Config.SellOpiatPrice.. ' $. Für ' .. Config.SellOpiatAmount.. ' Opiate!',
        style = {}
    })
    local dauer = Config.SellOpiatTime / 1000
    TextDisplay12 = Page4:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page4:RegisterElement('input', {
        label = "Wieviele Verkaufen:",
        placeholder = "1",
        persist = false,
        style = {
        }
    }, function(data)
        inputValue = data.value
    end)
    Page4:RegisterElement('button', {
        label = "Jetzt Verkaufen",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:opiatseller',inputValue)
    end)
    Page4:RegisterElement('button', {
        label = "Verkäufer Verlassen",
        style = {
        },
    }, function()
        OpiatMenu:Close({ 
        })
    end)
    Page4:RegisterElement('subheader', {
        value = "Opiat Verkäufer",
        slot = "footer",
        style = {}
    })
    Page4:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    RegisterNetEvent('mms-drugs:client:opiatseller')
    AddEventHandler('mms-drugs:client:opiatseller', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:opiatseller' ,anzahl)
    end)

-----------------------------------------------------------------------------Kokain------------------------------------------------

-- prompt and blip for Kokain Plants

Citizen.CreateThread(function()
    for kokain,v in pairs(Config.kokainplant) do
        exports['rsg-core']:createPrompt(v.kokainplantid, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checkkokainplant',
            args = {  },
        })
        if v.showblipkokain == true then
            local kokainblip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(kokainblip, GetHashKey(Config.Blipkokainplant.blipSprite), true)
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
            duration = Config.HaverestKokainTime, -- Adjust the duration as needed
            label = 'Ernte Kokain',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:givekokain')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'info')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for kokainworker,v in pairs(Config.kokainworker) do
        exports['rsg-core']:createPrompt(v.kokainworkerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
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

RegisterNetEvent('mms-drugs:client:kokainmenu')
AddEventHandler('mms-drugs:client:kokainmenu', function()
    KokainMenu:Open({
        startupPage = Page5, 
    })
end)

-- Verarbeiter Menü

Citizen.CreateThread(function()
    KokainMenu = FeatherMenu:RegisterMenu('feather:character:kokainmenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page5 = KokainMenu:RegisterPage('first:page5')
    Page5:RegisterElement('header', {
        value = 'Kokain Verarbeiter',
        slot = "header",
        style = {}
    })
    Page5:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay13 = Page5:RegisterElement('textdisplay', {
        value = "Verarbeite dein Kokain zu Kokain Pulver!",
        style = {}
    })
    TextDisplay14 = Page5:RegisterElement('textdisplay', {
        value = 'Rezept: ' .. Config.ReciepeKokainNeeded.. ' Kokain = '.. Config.ReciepeKokainReward .. ' Kokain Pulver!',
        style = {}
    })
    local dauer = Config.WorktimeKokainWorker / 1000
    TextDisplay15 = Page5:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page5:RegisterElement('input', {
        label = "Wie Oft Herstellen:",
        placeholder = "1",
        persist = false,
        style = {
       }
    }, function(data)
        inputValue = data.value
    end)
    Page5:RegisterElement('button', {
        label = "Jetzt Verarbeiten",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:kokainworker',inputValue)
    end)
    Page5:RegisterElement('button', {
        label = "Verarbeiter Verlassen",
        style = {
        },
    }, function()
        KokainMenu:Close({ 
        })
    end)
    Page5:RegisterElement('subheader', {
        value = "Kokain Verarbeiter",
        slot = "footer",
        style = {}
    })
    Page5:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    
    RegisterNetEvent('mms-drugs:client:kokainworker')
    AddEventHandler('mms-drugs:client:kokainworker', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:kokainworker' ,anzahl)
    end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for kokainseller,v in pairs(Config.kokainseller) do
        exports['rsg-core']:createPrompt(v.kokainsellerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
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

RegisterNetEvent('mms-drugs:client:kokainsellermenu')
AddEventHandler('mms-drugs:client:kokainsellermenu', function(inputValue)
    KokainSellerMenu:Open({
        startupPage = Page6,
    })
end)

Citizen.CreateThread(function()
    KokainSellerMenu = FeatherMenu:RegisterMenu('feather:character:kokainsellermenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page6 = KokainSellerMenu:RegisterPage('first:page6')
    Page6:RegisterElement('header', {
        value = 'Kokain Pulver Verkäufer',
        slot = "header",
        style = {}
    })
    Page6:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay16 = Page6:RegisterElement('textdisplay', {
        value = "Verkaufe deine Kokain Pulver!",
        style = {}
    })
    TextDisplay17 = Page6:RegisterElement('textdisplay', {
        value = 'Preis: ' .. Config.SellKokainPrice.. ' $. Für ' .. Config.SellKokainAmount.. ' Kokain Pulver!',
        style = {}
    })
    local dauer = Config.SellKokainTime / 1000
    TextDisplay18 = Page6:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page6:RegisterElement('input', {
        label = "Wieviele Verkaufen:",
        placeholder = "1",
        persist = false,
        style = {
        }
    }, function(data)
        inputValue = data.value
    end)
    Page6:RegisterElement('button', {
        label = "Jetzt Verkaufen",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:kokainseller',inputValue)
    end)
    Page6:RegisterElement('button', {
        label = "Verkäufer Verlassen",
        style = {
        },
    }, function()
        KokainSellerMenu:Close({ 
        })
    end)
    Page6:RegisterElement('subheader', {
        value = "Kokain Pulver Verkäufer",
        slot = "footer",
        style = {}
    })
    Page6:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    RegisterNetEvent('mms-drugs:client:kokainseller')
    AddEventHandler('mms-drugs:client:kokainseller', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:kokainseller' ,anzahl)
    end)

-----------------------------------------------------------------------------Pilze------------------------------------------------

-- prompt and blip for Sporen Plants

Citizen.CreateThread(function()
    for sporen,v in pairs(Config.sporenplant) do
        exports['rsg-core']:createPrompt(v.sporenplantid, v.coords -1, RSGCore.Shared.Keybinds['J'], 'Ernte ' ..v.lable, {
            type = 'client',
            event = 'mms-drugs:client:checksporenplant',
            args = {  },
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
            duration = Config.HaverestSporenTime, -- Adjust the duration as needed
            label = 'Ernte Sporen',
            position = 'bottom',
            useWhileDead = false, 
        })
        ClearPedTasks(ped)
        TriggerServerEvent('mms-drugs:server:givesporen')
        cooldownTimer()
        busy = false
    else
        RSGCore.Functions.Notify('Die Pflanze wächst Bitte warte ' .. cooldownSecondsRemaining .. ' Sekunden', 'info')
    end
end)

-- Verarbeiter prompt

Citizen.CreateThread(function()
    for sporenworker,v in pairs(Config.sporenworker) do
        exports['rsg-core']:createPrompt(v.sporenworkerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
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

RegisterNetEvent('mms-drugs:client:sporenmenu')
AddEventHandler('mms-drugs:client:sporenmenu', function()
    SporenMenu:Open({
        startupPage = Page7, 
    })
end)

-- Verarbeiter Menü

Citizen.CreateThread(function()
    SporenMenu = FeatherMenu:RegisterMenu('feather:character:sporennmenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page7 = SporenMenu:RegisterPage('first:page7')
    Page7:RegisterElement('header', {
        value = 'Sporen Verarbeiter',
        slot = "header",
        style = {}
    })
    Page7:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay19 = Page7:RegisterElement('textdisplay', {
        value = "Verarbeite deine Sporen zu Pilzen!",
        style = {}
    })
    TextDisplay20 = Page7:RegisterElement('textdisplay', {
        value = 'Rezept: ' .. Config.ReciepeSporenNeeded.. ' Sporen = '.. Config.ReciepeSporenReward .. ' Pilzen!',
        style = {}
    })
    local dauer = Config.WorktimeSporenWorker / 1000
    TextDisplay21 = Page7:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page7:RegisterElement('input', {
        label = "Wie Oft Herstellen:",
        placeholder = "1",
        persist = false,
        style = {
       }
    }, function(data)
        inputValue = data.value
    end)
    Page7:RegisterElement('button', {
        label = "Jetzt Verarbeiten",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:sporenworker',inputValue)
    end)
    Page7:RegisterElement('button', {
        label = "Verarbeiter Verlassen",
        style = {
        },
    }, function()
        SporenMenu:Close({ 
        })
    end)
    Page7:RegisterElement('subheader', {
        value = "Sporen Verarbeiter",
        slot = "footer",
        style = {}
    })
    Page7:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    
    RegisterNetEvent('mms-drugs:client:sporenworker')
    AddEventHandler('mms-drugs:client:sporenworker', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:sporenworker' ,anzahl)
    end)

-- Verkäufer prompt

Citizen.CreateThread(function()
    for pilzeseller,v in pairs(Config.pilzeseller) do
        exports['rsg-core']:createPrompt(v.pilzsellerid, v.coords, RSGCore.Shared.Keybinds['J'],  ('Open ') .. v.lable, {
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

RegisterNetEvent('mms-drugs:client:pilzesellermenu')
AddEventHandler('mms-drugs:client:pilzesellermenu', function(inputValue)
    PilzSellerMenu:Open({
        startupPage = Page8,
    })
end)

Citizen.CreateThread(function()
    PilzSellerMenu = FeatherMenu:RegisterMenu('feather:character:pilzesellermenu', {
        top = '40%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '600px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '900px',
        style = {
            -- ['height'] = '500px'
            ['border'] = '5px solid green',
            -- ['background-image'] = 'none',
            ['background-color'] = '#006400'
        },
        contentslot = {
            style = { --This style is what is currently making the content slot scoped and scrollable. If you delete this, it will make the content height dynamic to its inner content.
                ['height'] = '500px',
                ['min-height'] = '300px'
            }
        },
        draggable = true,
        --canclose = false
    })
    Page8 = PilzSellerMenu:RegisterPage('first:page8')
    Page8:RegisterElement('header', {
        value = 'Pilz Verkäufer',
        slot = "header",
        style = {}
    })
    Page8:RegisterElement('line', {
        slot = "header",
        style = {}
    })
    TextDisplay22 = Page8:RegisterElement('textdisplay', {
        value = "Verkaufe deine Pilze!",
        style = {}
    })
    TextDisplay23 = Page8:RegisterElement('textdisplay', {
        value = 'Preis: ' .. Config.SellPilzPrice  .. ' $. Für ' .. Config.SellPilzAmount.. ' Pilze!',
        style = {}
    })
    local dauer = Config.SellKokainTime / 1000
    TextDisplay24 = Page8:RegisterElement('textdisplay', {
        value = 'Dauer: ' .. dauer .. ' Sekunden!',
        style = {}
    })
    local inputValue = ''
    Page8:RegisterElement('input', {
        label = "Wieviele Verkaufen:",
        placeholder = "1",
        persist = false,
        style = {
        }
    }, function(data)
        inputValue = data.value
    end)
    Page8:RegisterElement('button', {
        label = "Jetzt Verkaufen",
        style = {
        },
    }, function()
        TriggerEvent('mms-drugs:client:pilzseller',inputValue)
    end)
    Page8:RegisterElement('button', {
        label = "Verkäufer Verlassen",
        style = {
        },
    }, function()
        PilzSellerMenu:Close({ 
        })
    end)
    Page8:RegisterElement('subheader', {
        value = "Pilz Verkäufer",
        slot = "footer",
        style = {}
    })
    Page8:RegisterElement('line', {
        slot = "footer",
        style = {}
    })
    end)
    
    RegisterNetEvent('mms-drugs:client:pilzseller')
    AddEventHandler('mms-drugs:client:pilzseller', function(inputValue)
            local anzahl = tostring(inputValue)
            TriggerServerEvent('mms-drugs:server:pilzseller' ,anzahl)
    end)