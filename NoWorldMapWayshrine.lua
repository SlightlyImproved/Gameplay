-- Slightly Improved™ Gameplay 1.1.0 (Feb 15 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local comboBox = WORLD_MAP_FILTERS.pvePanel:FindCheckBox(MAP_FILTER_WAYSHRINES)
    local shouldRestore = false

    local function OnMapChange()
        local wayshrinesShown = ZO_WorldMap_IsPinGroupShown(MAP_FILTER_WAYSHRINES)
        local isEnabled = savedVars.settings.noWorldmapWayshrines

        if (GetMapType() == MAPTYPE_ALLIANCE) then
            if isEnabled and wayshrinesShown then
                shouldRestore = true
                ZO_CheckButton_OnClicked(comboBox)
            end
        else
            if isEnabled and not wayshrinesShown and shouldRestore then
                shouldRestore = false
                ZO_CheckButton_OnClicked(comboBox)
            end
        end
    end

    CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", OnMapChange)
end)
