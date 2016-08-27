-- LibHookTooltip 1.0.0
-- Licensed under MIT © 2016 Arthur Corenzan

local LHT, _ = LibStub:NewLibrary("LibHookTooltip-1.0", 1)
if not LHT then
    return
end

-- Hooks to be called BEFORE initializing tooltip.
LHT.preHookTable = {}

-- Hooks to be called AFTER initializing tooltip.
LHT.postHookTable = {}

local function HookTooltip(tooltip, itemLink, callHookedMethod)
    for _, preHook in pairs(LHT.preHookTable) do
        preHook(tooltip, itemLink)
    end

    callHookedMethod()

    for _, postHook in pairs(LHT.postHookTable) do
        postHook(tooltip, itemLink)
    end
end

local function GetEquippedItemLink(slotId)
    return GetItemLink(WORN_BAG, slotId)
end

local function GetItemLinkPassThrough(itemLink)
    return itemLink
end

-- Tooltip object, method name, function to get item link.
local hookableMethodsTable =
{
    { ItemTooltip, "SetBagItem", GetItemLink },
    { ItemTooltip, "SetWornItem", GetEquippedItemLink },
    { ItemTooltip, "SetTradeItem", GetTradeItemLink },
    { ItemTooltip, "SetQuestReward", GetQuestRewardItemLink },
    { ItemTooltip, "SetBuybackItem", GetBuybackItemLink },
    { ItemTooltip, "SetStoreItem", GetStoreItemLink },
    { ItemTooltip, "SetAttachedMailItem", GetAttachedItemLink },
    { ItemTooltip, "SetLootItem", GetLootItemLink },
    { ItemTooltip, "SetTradingHouseItem", GetTradingHouseSearchResultItemLink },
    { ItemTooltip, "SetTradingHouseListing", GetTradingHouseListingItemLink },
    { PopupTooltip, "SetLink", GetItemLinkPassThrough },
}

for i = 1, #hookableMethodsTable do
    local tooltip, methodName, getItemLink = unpack(hookableMethodsTable[i])
    local hookedMethod = tooltip[methodName]

    tooltip[methodName] = function(self, ...)
        local arguments = {...}
        local itemLink = getItemLink(...)
        HookTooltip(tooltip, itemLink, function()
            hookedMethod(self, unpack(arguments))
        end)
    end
end

for _, tooltip in ipairs({ComparativeTooltip1, ComparativeTooltip2}) do
    local hookedHandler = tooltip:GetHandler("OnAddGameData")
    tooltip:SetHandler("OnAddGameData", function(self, gameDataType, slotId, ...)
        local arguments = {...}
        if (gameDataType == TOOLTIP_GAME_DATA_EQUIPPED_INFO) then
            local itemLink = GetItemLink(WORN_BAG, slotId)
            HookTooltip(self, itemLink, function()
                hookedHandler(self, gameDataType, slotId, unpack(arguments))
            end)
        else
            hookedHandler(self, gameDataType, slotId, unpack(arguments))
        end
    end)
end

function LHT:RegisterPreHook(name, hook)
    table.insert(self.preHookTable, hook)
end

function LHT:RegisterPostHook(name, hook)
    table.insert(self.postHookTable, hook)
end
