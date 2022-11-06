Config = {} -- Do not touch
Config.Version = "1.0.0" -- Do not touch
--Config.UseHud = true -- Use the build in hud
Config.Debug = true -- Set to true if you want to see debug messages
Config.DebugPrefix = "[BrainLUA-Debug] " --Debug prefix
Config.SpawnPosition = { --Spawn position on first time joining
    x = -429.4566,
    y = 1109.3939,
    z = 327.6823,
    heading = 344.6500,
}
Config.DisableWanted = true -- Disable wanted level

Config.Jobs = { --Jobs
    defaultjob = "unemployed", -- The Default Job
    defaultjobgrade = 1, -- The Default Job Grade
    jobs = { -- The Jobs
        ["unemployed"] = {
            label = "Unemployed", -- Job Label
            grades = { -- The Grades
                { --Grade 1
                    name = "unemployed", -- Grade name
                    label = "Unemployed", --Label
                    salary = 250, -- Salary
                }
            }
        }
    }
}

Config.Items = { -- Items
    ["water"] = { --Name
        label = "Water Bottle (1L)", --Label
        weight = 1000, --Weight in G
        stacklimit = true, -- Use a Stacklimit?
        maxstack = 10, -- if yes, set the max stack
    }
}

Config.UpdateTime = 1 -- Position Update Time

Config.Team = { -- Staff Roles
    {
        name = "staff", -- Role name
        label = "Staff", -- Role label
    },
    {
        name = "administrator", -- Role name
        label = "Administrator" -- Role label
    }
}

Config.Accounts = { -- All the Money Accounts
    ["money"] = { -- Name
        label = "Money", -- Label
        money = 0, -- The Defaultmoney
    }
}