-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local resetAllSearchData = TRADING_HOUSE.ResetAllSearchData
    function TRADING_HOUSE:ResetAllSearchData()
        self:ClearSearchResults()
        -- resetAllSearchData()
    end
end)
