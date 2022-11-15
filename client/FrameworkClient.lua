FrameworkClient = {}
FrameworkClient.PlayerData = {}
FrameworkClient.addBlip = function(position, sprite,size,colour,name)
    if not position or not sprite or not colour or not name then return end
    local blip = AddBlipForCoord(position)

    SetBlipSprite(blip, sprite)
    SetBlipScale(blip, size)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, colour)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

FrameworkClient.showNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, true)
end

RegisterNetEvent("BrainLUA:PlayerLoaded")
AddEventHandler("BrainLUA:PlayerLoaded", function(playerData)
    FrameworkClient.PlayerData = playerData
end)

RegisterNetEvent("BrainLUA:UpdateJob")
AddEventHandler("BrainLUA:UpdateJob", function(job,grade)
    FrameworkClient.PlayerData.job = job
    FrameworkClient.PlayerData.grade = grade
end)