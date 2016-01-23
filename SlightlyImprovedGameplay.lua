-- SlightlyImprovedGameplay 1.0.1 (Jan 23 2016)
-- Licensed under CC BY-NC-SA 4.0

SIG = "SlightlyImprovedGameplay"

local defaultSavedVars =
{
    ["showClock"] = false,
}

EVENT_MANAGER:RegisterForEvent(SIG, EVENT_ADD_ON_LOADED, function(eventCode, addOnName)
    if (addOnName == SIG) then
        local sv = ZO_SavedVars:New("SigSavedVars", 1, nil, defaultSavedVars)
        CALLBACK_MANAGER:FireCallbacks("Sig_OnAddOnLoaded", sv)
    end
end)
