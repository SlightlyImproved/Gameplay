-- SlightlyImprovedGameplay 1.2.2 (Aug 27 2016)
-- Licensed under MIT © 2016 Arthur Corenzan

local NAMESPACE = "SlightlyImprovedGameplay"

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

EVENT_MANAGER:RegisterForEvent(NAMESPACE, EVENT_ADD_ON_LOADED, function(eventCode, addOnName)
    if (addOnName == NAMESPACE) then
        local savedVars = ZO_SavedVars:New(NAMESPACE.."_SavedVars", 1, nil, defaultSavedVars)

        do
            local mt = getmetatable(savedVars)
            local __newindex = mt.__newindex
            function mt.__newindex(self, key, value)
                __newindex(self, key, value)

                if (key == "mailSendDefaultMode") then
                    MAIL_SEND:SetToDefaultMode()
                end
            end
        end

        CALLBACK_MANAGER:FireCallbacks(NAMESPACE.."_OnAddOnLoaded", savedVars)
    end
end)
