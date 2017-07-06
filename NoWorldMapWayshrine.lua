-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local comboBox = WORLD_MAP_FILTERS.pvePanel:FindCheckBox(MAP_FILTER_WAYSHRINES)
    local shouldChangeBack = false

    local function OnMapChanged()
        local showWayshrines = ZO_WorldMap_IsPinGroupShown(MAP_FILTER_WAYSHRINES)
        local isEnabled = savedVars.noWorldmapWayshrines

        if (GetMapType() == MAPTYPE_WORLD) then
            if (isEnabled and showWayshrines) then
                ZO_CheckButton_OnClicked(comboBox)
                shouldChangeBack = true
            end
        else
            if (not showWayshrines and shouldChangeBack) then
                ZO_CheckButton_OnClicked(comboBox)
                shouldChangeBack = false
            end
        end
    end

    CALLBACK_MANAGER:RegisterCallback("OnWorldMapChanged", OnMapChanged)
end)
