-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

local NAMESPACE = "SlightlyImprovedGameplay"

CALLBACK_MANAGER:RegisterCallback(NAMESPACE.."_OnSavedVarChanged", function(key, value, oldValue)
    if (key == "chatAutoCompleteEnabled") then
        SLASH_COMMAND_AUTO_COMPLETE:SetEnabled(value)
    end
end)

CALLBACK_MANAGER:RegisterCallback(NAMESPACE.."_OnAddOnLoaded", function(savedVars)
    SLASH_COMMAND_AUTO_COMPLETE:SetEnabled(savedVars.chatAutoCompleteEnabled)
end)
