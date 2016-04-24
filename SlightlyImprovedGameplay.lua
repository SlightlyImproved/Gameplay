-- SlightlyImprovedGameplay 1.1.1 (Feb 18 2016)
-- Licensed under CC BY-NC-SA 4.0

local defaultSavedVars =
{
    mailSendDefaultMode = MAIL_SEND_MODE_COD,
    compactPaperDoll = true,
    noWorldmapWayshrines = true,
    isTrashWarnerEnabled = true,
    isFenceWarnerEnabled = true,
    improveItemTooltip = true,
    preventStoreSearchReset = true,
}

EVENT_MANAGER:RegisterForEvent("SlightlyImprovedGameplay", EVENT_ADD_ON_LOADED, function(eventCode, addOnName)
    if (addOnName == "SlightlyImprovedGameplay") then

        local savedVars = ZO_SavedVars:New("SlightlyImprovedGameplay_SavedVars", 1, nil, defaultSavedVars)

        do
            local __newindex = savedVars.__newindex
            function savedVars.__newindex(self, key, value)
                __newindex(self, key, value)

                if (key == "mailSendDefaultMode") then
                    MAIL_SEND:SetToDefaultMode()
                end
            end
        end

        CALLBACK_MANAGER:FireCallbacks("SlightlyImprovedGameplay_OnAddOnLoaded", savedVars)
    end
end)
