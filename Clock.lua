-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(sv)
    local function TellTheTime()
        d(GetTimeString())
    end

    SLASH_COMMANDS[GetString(SI_SLASH_CLOCK)] = TellTheTime
    SLASH_COMMANDS[GetString(SI_SLASH_TIME)] = TellTheTime
end)
