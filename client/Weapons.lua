RegisterNetEvent('BrainLUA:addWeapon')
AddEventHandler('BrainLUA:addWeapon', function (weapon,ammo,code)
    if code then
        GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), ammo, false, false)
    end
end)