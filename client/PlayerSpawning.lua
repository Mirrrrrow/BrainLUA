local notSpawned = true
Citizen.CreateThread(function()
    while notSpawned do
        spawnPlayer()
        Wait(500)
    end
end)

function spawnPlayer()
    local defaultModel = "mp_m_freemode_01"
    RequestModel(GetHashKey(defaultModel))
    
    while not HasModelLoaded(GetHashKey(defaultModel)) do
        RequestModel(GetHashKey(defaultModel))
        Wait(0)
    end

    SetPlayerModel(PlayerId(), GetHashKey(defaultModel))
    LoadDefaultSkin()

    for i=0,19 do
        Citizen.Wait(1)
        SetPedComponentVariation(PlayerPedId(), 0, i, 0, 0)
    end

    SetModelAsNoLongerNeeded(GetHashKey(defaultModel))
    ShutdownLoadingScreen()
    FreezeEntityPosition(PlayerPedId(), false)

    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)

    notSpawned = false


    TriggerServerEvent("brain:playerLoaded", GetPlayerServerId(PlayerId()), GetPlayerName(PlayerId()))
end

function LoadDefaultSkin()
    SetPedComponentVariation(PlayerPedId(), 8, Config.DefaultSkin['tshirt_1'], Config.DefaultSkin['tshirt_2'], 2)
    SetPedComponentVariation(PlayerPedId(), 11, Config.DefaultSkin['torso_1'], Config.DefaultSkin['torso_2'], 2)
    SetPedComponentVariation(PlayerPedId(), 4, Config.DefaultSkin['pants_1'], Config.DefaultSkin['pants_2'], 2)
    SetPedComponentVariation(PlayerPedId(), 6, Config.DefaultSkin['shoes_1'], Config.DefaultSkin['shoes_2'], 2)
end


RegisterNetEvent("brain:spawnPlayerLocation")
AddEventHandler("brain:spawnPlayerLocation", function()
    SetEntityCoords(PlayerPedId(), Config.SpawnPosition.x, Config.SpawnPosition.y, Config.SpawnPosition.z)
    SetEntityHeading(PlayerPedId(), Config.SpawnPosition.heading)
    SetGameplayCamRelativeHeading(Config.SpawnPosition.heading)
end)