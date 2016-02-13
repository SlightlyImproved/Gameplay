-- SlightlyImprovedGameplay 1.1.0 (Feb 15 2016)
-- Licensed under CC BY-NC-SA 4.0

SLIGHTLY_IMPROVED_GAMEPLAY = "SlightlyImprovedGameplay"

local defaultSavedVars =
{
    settings =
    {
        mailSendDefaultMode = MAIL_SEND_MODE_COD,
        compactPaperDoll = true,
        noWorldmapWayshrines = true,
        isTrashWarnerEnabled = true,
        isFenceWarnerEnabled = true,
    }
}

EVENT_MANAGER:RegisterForEvent(SLIGHTLY_IMPROVED_GAMEPLAY, EVENT_ADD_ON_LOADED, function(eventCode, addOnName)
    if (addOnName == SLIGHTLY_IMPROVED_GAMEPLAY) then
        local savedVars = ZO_SavedVars:New("SigSavedVars", 2, nil, defaultSavedVars)
        CALLBACK_MANAGER:FireCallbacks("SlightlyImprovedGameplay_OnAddOnLoaded", savedVars)
    end
end)
