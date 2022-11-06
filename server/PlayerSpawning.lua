RegisterServerEvent('framework:playerLoaded')
AddEventHandler('framework:playerLoaded', function(playerId, playerName)
    local playerIdentifier = GetPlayerIdentifier(playerId, 0)
    CheckCharacter(playerIdentifier, playerId, playerName)
    Debug("Player " .. playerName .. " with the identifier " .. playerIdentifier .. " has joined the server.")
end)

function CheckCharacter(playerIdentifier, playerId, playerName)
    exports.mongodb:findOne({ collection = "users", query = { identifier = playerIdentifier } }, function (success, result)
        if not success then
            print("Error message: "..tostring(result))
            return
        end    

        if #result > 0 then
            local playerResult = result[1]
            Debug("Player " .. playerName .. " with the identifier " .. playerIdentifier .. " has a character.")
            LoadPlayer(playerName, playerResult.coords, playerIdentifier, playerId, playerResult.rang, playerResult.personalId, playerResult.accounts, playerResult.job, playerResult.grade, playerResult.inventory, playerResult.loadout)
        else
            Debug("Player " .. playerName .. " with the identifier " .. playerIdentifier .. " has no character.")
            CreateCharacter(playerIdentifier, playerId, playerName)
        end
    end)
end


function CreateCharacter(playerIdentifier, playerId, playerName)
    exports.mongodb:findOne({ collection = "users", query = {} }, function (success1, result1)
        if not success1 then
            print("Error message: "..tostring(result1))
            return
        end    
        local newId = #result1 + 1

        local playerData = {
            ["identifier"] = playerIdentifier,
            ["coords"] = Config.SpawnPosition,
            ["rang"] = 0,
            ["personalId"] = newId,
            ["job"] = Config.Jobs.defaultjob,
            ["grade"] = Config.Jobs.defaultgrade,
            ["inventory"] = {},
            ["loadout"] = {},
            ["accounts"] = Config.Accounts
        }
        Wait(15)
        exports.mongodb:insertOne({ collection = "users", document = playerData}, function (success,result,ids)
            if not success then
                print("Error message: "..tostring(result))
                return
            end
            
            LoadPlayer(playerName, playerData["coords"], playerIdentifier, playerId, 0, playerData["personalId"], playerData["accounts"], playerData["job"], playerData["grade"], playerData["inventory"], playerData["loadout"])
            Debug('A Character for ' ..playerName.. ' with the ID '..ids[1].. ' got created!')
            TriggerClientEvent('brain:spawnPlayerLocation', playerId)
        end)
    end)

end