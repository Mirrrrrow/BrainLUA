function LoadPlayer(playerName, playerCoords, playerIdentifier, playerId, ranglevel, personalId, playerAccounts, job,grade, inventory, loadout)
    self = {}

    self.name = playerName
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

    TriggerClientEvent("BrainLUA:PlayerLoaded", self.id, self)

end
