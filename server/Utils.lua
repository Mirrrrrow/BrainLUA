function Debug = function(msg)
    if Config.Debug then
        print(Config.DebugPrefix .. msg)
    end
end

function ForceDebug = function(msg)
    print(Config.DebugPrefix .. msg)
end