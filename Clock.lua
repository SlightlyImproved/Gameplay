-- SlightlyImprovedGameplay 1.2.2 (Aug 27 2016)
-- Licensed under MIT © 2016 Arthur Corenzan

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(sv)
    local function TellTheTime()
        d(GetTimeString())
    end

    SLASH_COMMANDS[GetString(SI_SLASH_CLOCK)] = TellTheTime
    SLASH_COMMANDS[GetString(SI_SLASH_TIME)] = TellTheTime
end)
