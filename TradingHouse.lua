-- Slightly Improved™ Gameplay 1.1.1 (Feb 18 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local resetAllSearchData = TRADING_HOUSE.ResetAllSearchData
    function TRADING_HOUSE:ResetAllSearchData()
        self:ClearSearchResults()
        -- resetAllSearchData()
    end
end)
