-- Slightly Improved™ Gameplay 1.2.0 (Apr 24 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(sv)
    local function TellTheTime()
        d(GetTimeString())
    end

    SLASH_COMMANDS[GetString(SI_SLASH_CLOCK)] = TellTheTime
    SLASH_COMMANDS[GetString(SI_SLASH_TIME)] = TellTheTime
end)
