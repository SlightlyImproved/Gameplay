-- SlightlyImprovedGameplay 1.1.1 (Feb 18 2016)
-- Licensed under CC BY-NC-SA 4.0

local SLIGHTLY_IMPROVED_GAMEPLAY = "SlightlyImprovedGameplay"

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
        local savedVars = ZO_SavedVars:New("SlightlyImprovedGameplay_SavedVars", 2, nil, defaultSavedVars)
        CALLBACK_MANAGER:FireCallbacks("SlightlyImprovedGameplay_OnAddOnLoaded", savedVars)
    end
end)
