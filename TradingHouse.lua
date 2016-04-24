-- Slightly Improved™ Gameplay 1.2.0 (Apr 24 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local resetAllSearchData = TRADING_HOUSE.ResetAllSearchData
    function TRADING_HOUSE:ResetAllSearchData()
        self:ClearSearchResults()
        -- resetAllSearchData()
    end
end)
