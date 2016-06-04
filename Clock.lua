-- SlightlyImprovedGameplay 1.2.1 (Jun 4 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(sv)
    local function TellTheTime()
        d(GetTimeString())
    end

    SLASH_COMMANDS[GetString(SI_SLASH_CLOCK)] = TellTheTime
    SLASH_COMMANDS[GetString(SI_SLASH_TIME)] = TellTheTime
end)
