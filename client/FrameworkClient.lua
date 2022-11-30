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

FrameworkClient.IsIplActive = function(iplName)
    if not iplName then return end
    return (IsIplActive(iplName))
end

FrameworkClient.LoadIpl = function(iplName)
    if not iplName then return end
    if IsIplActive(iplName) then return end
    RequestIpl(iplName)
end


FrameworkClient.UnLoadIpl = function(iplName)
    if not iplName then return end
    if not IsIplActive(iplName) then return end
    RemoveIpl(iplName)
end

FrameworkClient.addNPC = function(position, heading,model)
    if not position or not heading or not model then return end
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
      Wait(1)
    end

    ped =  CreatePed(4, GetHashKey(model),position.x,position.y,position.z, 3374176, false, true)
    SetEntityHeading(ped, heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end

FrameworkClient.showNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, true)
end

FrameworkClient.showPictureNotification = function(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    SetNotificationMessage(icon, icon, true, 1, title, subtitle)
    DrawNotification(false, true)
end

FrameworkClient.showHelpNotification = function(msg)
    AddTextEntry("BRAINLUA", msg)
    DisplayHelpTextThisFrame("BRAINLUA", false)
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