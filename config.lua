Config = {}

-- settings
Config.Cooldown = 10 -- amount in seconds (3600 = 1hr) Cooldown Weedpflanze wie schnell man Ernten kann
Config.hightime = 60000
Config.passouttime = 30000

----------------------------------------------CONFIG WEED-------------------

Config.amountweed = 10  -- how much weed you can Haverest

---- Blip Weedpflanze

Config.Blip = {
    blipName = 'Weedpflanze',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}

------ Weedpflanze

Config.weedplant = {
    { 
        lable = 'Weed',
        name = 'Weedpflanze',
        coords = vector3(-327.26, 735.40, 117.31),
        showblip = true,
    },
    --{ 
    --    lable = 'Weed2',
    --    name = 'Weedplant2',
    --    coords = vector3(765.27, 1491.22, 199.75),
    --    showblip = true,
    --},
    
}

-------------  Blip Weedverarbeiter

Config.BlipWorker = {
    blipName = 'Weedverarbeiter',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}


------ Weedverarbeiter
Config.workerweedinput = 0
Config.workerjointoutput = 0

Config.weedworker = {
    { 
        lable = 'Weedverarbeiter',
        name = 'Weedverarbeiter',
        coords = vector3(-335.46, 723.68, 117.22),
        showblipworker = true,
    },
}


-------------  Blip Weedverkäufer

Config.BlipSeller = {
    blipName = 'Jointverkäufer', 
    blipSprite = 'blip_animal_quality_01', 
    blipScale = 0.5,
}


----- Weedverkäufer

Config.weedseller = {
    { 
        lable = 'Jointverkäufer',
        name = 'Jointverkäufer',
        coords = vector3(-332.98, 719.21, 117.04),
        showblipseller = true,
    },
}

Config.sellprice = 1000

--------------------------CONFIG OPIUM----------------------------------------------

Config.amountopium = 10  -- how much Opium you can Haverest

---- Blip Opiumpflanze

Config.Blipopiumplant = {
    blipName = 'Opiumpflanze',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}

------ Opiumpflanze

Config.opiumplant = {
    { 
        lable = 'Opium',
        name = 'Opiumpflanze',
        coords = vector3(-323.07, 728.23, 117.42),
        showblip = true,
    },
    --{ 
    --    lable = 'Weed2',
    --    name = 'Weedplant2',
    --    coords = vector3(765.27, 1491.22, 199.75),
    --    showblip = true,
    --},
    
}

-------------  Blip Opiumverarbeiter

Config.BlipOpiumWorker = {
    blipName = 'Weedverarbeiter',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}


------ Opiumverarbeiter

Config.opiumworker = {
    { 
        lable = 'Opiumverarbeiter',
        name = 'Opiumverarbeiter',
        coords = vector3(-338.43, 729.44, 117.23),
        showblipopiumworker = true,
    },


}


-------------  Blip Opiatverkäufer

Config.BlipOpiatSeller = {
    blipName = 'Opiatverkäufer', 
    blipSprite = 'blip_animal_quality_01', 
    blipScale = 0.5,
}


----- Opiatverkäufer

Config.opiatseller = {
    { 
        lable = 'Opiatverkäufer',
        name = 'Opiatverkäufer',
        coords = vector3(-339.85, 732.71, 117.20),
        showblipseller = true,
    },
}

Config.sellpriceopiat = 1000


--------------------------CONFIG KOKAIN----------------------------------------------

Config.amountkokain = 10  -- how much Kokain you can Haverest

---- Blip Opiumpflanze

Config.Blipkokainplant = {
    blipName = 'Kokainpflanze',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}

------ Opiumpflanze

Config.kokainplant = {
    { 
        lable = 'Kokain',
        name = 'Kokainpflanze',
        coords = vector3(-328.68, 741.27, 117.21),
        showblip = true,
    },
    --{ 
    --    lable = 'Weed2',
    --    name = 'Weedplant2',
    --    coords = vector3(765.27, 1491.22, 199.75),
    --    showblip = true,
    --},
    
}

-------------  Blip Kokainverarbeiter

Config.BlipKokainWorker = {
    blipName = 'Kokainverarbeiter',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}


------ Kokainverarbeiter

Config.kokainworker = {
    { 
        lable = 'Kokainverarbeiter',
        name = 'Kokainverarbeiter',
        coords = vector3(-342.22, 735.96, 117.24),
        showblipkokainworker = true,
    },


}


-------------  Blip Kokainverkäufer

Config.BlipKokainSeller = {
    blipName = 'Kokainverkäufer', 
    blipSprite = 'blip_animal_quality_01', 
    blipScale = 0.5,
}


----- Kokainverkäufer

Config.kokainseller = {
    { 
        lable = 'Kokainverkäufer',
        name = 'Kokainverkäufer',
        coords = vector3(-344.73, 741.31, 117.26),
        showblipseller = true,
    },
}

Config.sellpricekokain = 1000

--------------------------CONFIG Pilze----------------------------------------------

Config.amountsporen = 10  -- how much Sporen you can Haverest

---- Blip Pilzsporen

Config.Blipsporenplant = {
    blipName = 'Pilzsporen',
    blipSprite = 's_inv_baybolete01bx',
    blipScale = 0.5,
}

------ Sporenpflanze

Config.sporenplant = {
    { 
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(-326.52, 731.34, 117.31),
        showblip = true,
    },
    --{ 
    --    lable = 'Weed2',
    --    name = 'Weedplant2',
    --    coords = vector3(765.27, 1491.22, 199.75),
    --    showblip = true,
    --},
    
}

-------------  Blip Sporenverarbeiter

Config.BlipSporenWorker = {
    blipName = 'Sporenverarbeiter',
    blipSprite = 'blip_animal_quality_01',
    blipScale = 0.5,
}


------ Sporenverarbeiter

Config.sporenworker = {
    { 
        lable = 'Sporenverarbeiter',
        name = 'Sporenverarbeiter',
        coords = vector3(-331.16, 747.11, 117.04),
        showblipsporenworker = true,
    },


}


-------------  Blip Pilzverkäufer

Config.BlipPilzeSeller = {
    blipName = 'Pilzverkäufer', 
    blipSprite = 'blip_animal_quality_01', 
    blipScale = 0.5,
}


----- Pilzverkäufer

Config.pilzeseller = {
    { 
        lable = 'Pilzverkäufer',
        name = 'Pilzverkäufer',
        coords = vector3(-335.41, 746.22, 116.86),
        showblipseller = true,
    },
}

Config.sellpricepilze = 1000