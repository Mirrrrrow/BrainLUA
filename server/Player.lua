function LoadPlayer(playerName, playerCoords, playerIdentifier, playerId, ranglevel, personalId, playerAccounts, job,grade, inventory, loadout)
    self = {}

    self.name = playerName
    self.optionalData = {}
    self.coords = playerCoords
    self.identifier = playerIdentifier
    self.job = job
    self.inventory = inventory
    self.grade = grade
    self.id = playerId
    self.accounts = playerAccounts
    self.loadout = loadout
    self.personalId = personalId
    self.teamlevel = ranglevel
    self.teamrang = "Spieler"
    if self.teamlevel ~= 0 then
        self.teamrang = Config.Team[ranglevel].label
    end

    self.getAccounts = function()
        return self.accounts
    end

    self.removeAccountMoney = function(account,money)
        if !account or !money then
            Debug("Account or Money wasnt given!")
            return
        end
        if !self.accounts[account] then
            Debug("Account is not registrated!")
            return
        end
        self.accounts[account].money = self.accounts[account].money - money
        self.updateAccounts()
    end

    self.addAccountMoney = function(account,money)
        if !account or !money then
            Debug("Account or Money wasnt given!")
            return
        end
        if !self.accounts[account] then
            Debug("Account is not registrated!")
            return
        end
        self.accounts[account].money = self.accounts[account].money + money
        self.updateAccounts()

    end

    self.setAccountMoney = function(account,money)
        if !account or !money then
            Debug("Account or Money wasnt given!")
            return
        end
        if !self.accounts[account] then
            Debug("Account is not registrated!")
            return
        end
        self.accounts[account].money = money
        self.updateAccounts()

    end

    self.getAccountMoney = function(account)
        if !account then
            Debug("Account wasnt given!")
            return
        end
        if !self.accounts[account] then
            Debug("Account is not registrated!")
            return
        end
        return self.accounts[account].money
    end
    
    self.getAccount = function(account)
        if !account then
            Debug("Account wasnt given!")
            return
        end
        if !self.accounts[account] then
            Debug("Account is not registrated!")
            return
        end
        return self.accounts[account]
    end

    self.updateOptionalData = function(index,value)
        if !index or !value then
            Debug("Index, Value wasnt given!")
            return
        end
        if !self.optionalData[index] then
            Debug(index.. " isnt valuable!")
            return
        end
        self.optionalData[index] = value
    end

    self.addOptionalData = function(index,value)
        if !index or !value then
            Debug("Index, Value wasnt given!")
            return
        end
        table.insert(self.optionalData,index, value )
    end

    self.getOptionalData = function(index)
        if !index then
            Debug("Index wasnt given!")
            return
        end
        if !self.optionalData[index] then
            Debug(index.. " isnt valuable!")
            return
        end
        return self.optionalData[index]
    end

    self.removeOptionalData = function(index)
        if !index then
            Debug("Index wasnt given!")
            return
        end
        if !self.optionalData[index] then
            Debug(index.. " isnt valuable!")
            return
        end
        table.remove(self.optionalData, index)
    end

    self.getAllOptionalData = function (DoEncode)
        if DoEncode then
            return JSON.encode(self.optionalData)
        end
        return self.optionalData
    end

    self.setJob = function(job, grade)
        if !Config.Jobs.jobs[job] then
            Debug("Job " .. job .. " does not exist!")
            return
        end
        if grade then
            if !Config.Jobs.jobs[job].grades[grade] then
                Debug("Grade " .. grade .. " does not exist!")
                return
            end
            self.grade = grade
        end
        self.job = job
        TriggerClientEvent("BrainLUA:UpdateJob", self.id, self.job, self.grade)
    end

    self.getJobName = function()
        return self.job
    end

    self.getJobLabel = function()
        return Config.Jobs.jobs[self.job].label
    end

    self.getGrade = function()
        return self.grade
    end

    self.setGrade = function(grade)
        if !type(grade) == "number" then
            Debug("Grade must be a number!")
            return
        end
        if !Config.Jobs.jobs[self.job].grades[grade] then
            Debug("Grade " .. grade .. " does not exist!")
            return
        end
        self.grade = grade
        TriggerClientEvent("BrainLUA:UpdateJob", self.id, self.job, self.grade)
    end

    self.getName = function()
        return self.name
    end

    self.getIdentifier = function()
        return self.identifier
    end

    self.updateAccounts = function()
        exports.mongodb:update({ collection = "users", query = { identifier = self.identifier}, update = {['$set'] = {accounts = self.accounts}}}, function (success, updatedUsers)
            if not success then
                print("Error message!")
                return
            end
        end)
    end

    TriggerClientEvent("BrainLUA:PlayerLoaded", self.id, self)

end
