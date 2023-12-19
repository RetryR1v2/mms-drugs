Config = {}

-- settings
Config.Cooldown = 10 -- amount in seconds (3600 = 1hr) Cooldown Weedpflanze wie schnell man Ernten kann
Config.hightime = 60000
Config.passouttime = 30000

----------------------------------------------CONFIG WEED-------------------

Config.amountweed = 10  -- how much weed you can Haverest

---- Blip Weedpflanze

Config.Blip = {
    blipName = 'Weed',
    blipSprite = 'blip_mp_pickup',
    blipScale = 0.5,
}

------ Weedpflanze
Config.HaverestWeedTime = 5000    ---- 5 Secs to haverest Weed
Config.weedplant = {
    { 
        weedplantid = 1,                ---- Every Plant need a diffrent ID
        lable = 'Weed',
        name = 'Weed',
        coords = vector3(-1850.21, 650.89, 128.88),
        showblip = true,     
    },
    { 
        weedplantid = 2,                ---- Every Plant need a diffrent ID
        lable = 'Weed',
        name = 'Weed',
        coords = vector3(-1852.85, 653.97, 129.61),
        showblip = true,     
    },
    { 
        weedplantid = 3,                ---- Every Plant need a diffrent ID
        lable = 'Weed',
        name = 'Weed',
        coords = vector3(-1860.49, 655.10, 129.43),
        showblip = true,     
    },
    { 
        weedplantid = 4,                ---- Every Plant need a diffrent ID
        lable = 'Weed',
        name = 'Weed',
        coords = vector3(-1861.14, 649.18, 128.46),
        showblip = true,     
    },
    { 
        weedplantid = 5,                ---- Every Plant need a diffrent ID
        lable = 'Weed',
        name = 'Weed',
        coords = vector3(-1856.86, 644.74, 127.83),
        showblip = true,     
    },

    
}

-------------  Blip Weedverarbeiter

Config.BlipWorker = {
    blipName = 'Weed Verarbeiter',
    blipSprite = 'blip_shop_blacksmith',
    blipScale = 0.5,
}


------ Weedverarbeiter
Config.ReciepeWeedNeeded = 10   --- how much weed   Example 10 weed = 2 Joints
Config.ReciepeJointReward = 2   --- how much joints you get
Config.WorktimeWeedWorker = 3000  --- 3 Secs for 2 Weed

Config.weedworker = {
    { 
        weedworkerid = 6,  ---- Every ID need to be Diffrent in whole config  if you got weedplant id 1 -5 you need workerid 6 +
        lable = 'Weed Verarbeiter',
        name = 'Weed Verarbeiter',
        coords = vector3(-335.46, 723.68, 117.22),
        showblipworker = true,
    },
}


-------------  Blip Weedverkäufer

Config.BlipSeller = {
    blipName = 'Joint Verkäufer', 
    blipSprite = 'blip_cash_bag', 
    blipScale = 0.5,
}


----- Weedverkäufer

Config.jointseller = {
    { 
        jointsellerid = 7,
        lable = 'Joint Verkäufer',
        name = 'Joint Verkäufer',
        coords = vector3(-332.98, 719.21, 117.04),
        showblipseller = true,
    },
}
Config.SellJointAmount = 1
Config.SellJointPrice = 5
Config.SellJointTime = 2000

--------------------------CONFIG OPIUM----------------------------------------------

Config.amountopium = 10  -- how much Opium you can Haverest

---- Blip Opiumpflanze

Config.Blipopiumplant = {
    blipName = 'Opiumpflanze',
    blipSprite = 'blip_mp_pickup',
    blipScale = 0.5,
}

------ Opiumpflanze
Config.HaverestOpiumTime = 5000
Config.opiumplant = {
    { 
        opiumplantid = 8,
        lable = 'Opium',
        name = 'Opium',
        coords = vector3(703.04, 1668.48, 211.22),
        showblipopium = true,
    },
    { 
        opiumplantid = 9,
        lable = 'Opium',
        name = 'Opium',
        coords = vector3(705.34, 1670.89, 212.00),
        showblipopium = true,
    },
    { 
        opiumplantid = 10,
        lable = 'Opium',
        name = 'Opium',
        coords = vector3(709.45, 1669.49, 213.05),
        showblipopium = true,
    },
    { 
        opiumplantid = 11,
        lable = 'Opium',
        name = 'Opium',
        coords = vector3(711.08, 1666.35, 213.30),
        showblipopium = true,
    },
    { 
        opiumplantid = 12,
        lable = 'Opium',
        name = 'Opium',
        coords = vector3(711.08, 1666.35, 213.30),
        showblipopium = true,
    },
}

-------------  Blip Opiumverarbeiter
Config.ReciepeOpiumNeeded = 10   --- how much Opium   Example 10 Opium = 2 Opiat
Config.ReciepeOpiatReward = 2   --- how much Opiat you get
Config.WorktimeOpiumWorker = 3000  --- 3 Secs for 2 Opium

Config.BlipOpiumWorker = {
    blipName = 'Opium Verarbeiter',
    blipSprite = 'blip_shop_blacksmith',
    blipScale = 0.5,
}


------ Opiumverarbeiter

Config.opiumworker = {
    { 
        opiumworkerid = 13,
        lable = 'Opium Verarbeiter',
        name = 'Opium Verarbeiter',
        coords = vector3(-338.43, 729.44, 117.23),
        showblipopiumworker = true,
    },


}


-------------  Blip Opiatverkäufer

Config.BlipOpiatSeller = {
    blipName = 'Opiat Verkäufer', 
    blipSprite = 'blip_cash_bag', 
    blipScale = 0.5,
}


----- Opiatverkäufer

Config.opiatseller = {
    { 
        opiatsellerid = 14,
        lable = 'Opiat Verkäufer',
        name = 'Opiat Verkäufer',
        coords = vector3(-339.85, 732.71, 117.20),
        showblipseller = true,
    },
}

Config.SellOpiatAmount = 1
Config.SellOpiatPrice = 5
Config.SellOpiatTime = 2000


--------------------------CONFIG KOKAIN----------------------------------------------

Config.amountkokain = 10  -- how much Kokain you can Haverest

---- Blip Kokain Pflanze

Config.Blipkokainplant = {
    blipName = 'Kokain',
    blipSprite = 'blip_mp_pickup',
    blipScale = 0.5,
}

------ Kokain Pflanze
Config.HaverestKokainTime = 5000
Config.kokainplant = {
    { 
        kokainplantid = 15,
        lable = 'Kokain',
        name = 'Kokain',
        coords = vector3(2237.36, 1796.77, 129.24),
        showblipkokain = true,
    },
    { 
        kokainplantid = 16,
        lable = 'Kokain',
        name = 'Kokain',
        coords = vector3(2234.47, 1791.73, 129.09),
        showblipkokain = true,
    },
    { 
        kokainplantid = 17,
        lable = 'Kokain',
        name = 'Kokain',
        coords = vector3(2229.12, 1789.43, 129.70),
        showblipkokain = true,
    },
    { 
        kokainplantid = 18,
        lable = 'Kokain',
        name = 'Kokain',
        coords = vector3(2227.11, 1792.35, 131.04),
        showblipkokain = true,
    },
    { 
        kokainplantid = 19,
        lable = 'Kokain',
        name = 'Kokain',
        coords = vector3(2231.74, 1795.37, 130.29),
        showblipkokain = true,
    },

    
    
}

-------------  Blip Kokainverarbeiter
Config.ReciepeKokainNeeded = 10   --- how much Opium   Example 10 Opium = 2 Opiat
Config.ReciepeKokainReward = 2   --- how much Opiat you get
Config.WorktimeKokainWorker = 3000  --- 3 Secs for 2 Opium


Config.BlipKokainWorker = {
    blipName = 'Kokain Verarbeiter',
    blipSprite = 'blip_shop_blacksmith',
    blipScale = 0.5,
}


------ Kokainverarbeiter

Config.kokainworker = {
    { 
        kokainworkerid = 20,
        lable = 'Kokain Verarbeiter',
        name = 'Kokain Verarbeiter',
        coords = vector3(-342.22, 735.96, 117.24),
        showblipkokainworker = true,
    },


}


-------------  Blip Kokainverkäufer

Config.BlipKokainSeller = {
    blipName = 'Kokain Verkäufer', 
    blipSprite = 'blip_cash_bag', 
    blipScale = 0.5,
}


----- Kokainverkäufer

Config.kokainseller = {
    { 
        kokainsellerid = 21,
        lable = 'Kokain Verkäufer',
        name = 'Kokain Verkäufer',
        coords = vector3(-344.73, 741.31, 117.26),
        showblipseller = true,
    },
}

Config.SellKokainAmount = 1
Config.SellKokainPrice = 5
Config.SellKokainTime = 2000

--------------------------CONFIG Pilze----------------------------------------------

Config.amountsporen = 10  -- how much Sporen you can Haverest

---- Blip Pilzsporen

Config.Blipsporenplant = {
    blipName = 'Pilzsporen',
    blipSprite = 'blip_mp_pickup',
    blipScale = 0.5,
}

------ Sporenpflanze
Config.HaverestSporenTime = 5000
Config.sporenplant = {
    { 
        sporenplantid = 22,
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(1962.40, -1913.72, 42.11),
        showblipsporen = true,
    },
    { 
        sporenplantid = 23,
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(1964.69, -1908.25, 42.03),
        showblipsporen = true,
    },
    { 
        sporenplantid = 24,
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(1960.21, -1904.32, 41.99),
        showblipsporen = true,
    },
    { 
        sporenplantid = 25,
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(1954.50, -1904.82, 41.94),
        showblipsporen = true,
    },
    { 
        sporenplantid = 26,
        lable = 'Sporen',
        name = 'Pilzsporen',
        coords = vector3(1951.26, -1908.42, 41.94),
        showblipsporen = true,
    },
    
}

-------------  Blip Sporenverarbeiter
Config.ReciepeSporenNeeded = 10   --- how much Opium   Example 10 Opium = 2 Opiat
Config.ReciepeSporenReward = 2   --- how much Opiat you get
Config.WorktimeSporenWorker = 3000  --- 3 Secs for 2 Opium

Config.BlipSporenWorker = {
    blipName = 'Sporen Verarbeiter',
    blipSprite = 'blip_shop_blacksmith',
    blipScale = 0.5,
}


------ Sporenverarbeiter

Config.sporenworker = {
    { 
        sporenworkerid = 27,
        lable = 'Sporen Verarbeiter',
        name = 'Sporen Verarbeiter',
        coords = vector3(-331.16, 747.11, 117.04),
        showblipsporenworker = true,
    },


}


-------------  Blip Pilzverkäufer

Config.BlipPilzeSeller = {
    blipName = 'Pilz Verkäufer', 
    blipSprite = 'blip_cash_bag', 
    blipScale = 0.5,
}


----- Pilzverkäufer

Config.pilzeseller = {
    { 
        pilzsellerid = 28,
        lable = 'Pilz Verkäufer',
        name = 'Pilz Verkäufer',
        coords = vector3(-335.41, 746.22, 116.86),
        showblipseller = true,
    },
}

Config.SellPilzAmount = 1
Config.SellPilzPrice = 5
Config.SellPilzTime = 2000