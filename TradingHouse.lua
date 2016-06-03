-- SlightlyImprovedGameplay 1.2.1 (Jun 2 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local resetAllSearchData = TRADING_HOUSE.ResetAllSearchData
    function TRADING_HOUSE:ResetAllSearchData()
        self:ClearSearchResults()
        -- resetAllSearchData()
    end
end)
