-- Slightly Improved™ Gameplay 1.2.0 (Apr 24 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local LibHookTooltip = LibStub("LibHookTooltip-1.0")

    local defaultStrings =
    {
        ["SI_ITEM_FORMAT_STR_BROAD_TYPE"] = GetString(SI_ITEM_FORMAT_STR_BROAD_TYPE),
    }

    LibHookTooltip:RegisterPreHook("SlightlyImprovedGameplay", function(tooltip, link)
        local itemType = GetItemLinkItemType(link)
        local isArmor = (itemType == ITEMTYPE_ARMOR)
        local isWeapon = (itemType == ITEMTYPE_WEAPON)
        if savedVars.improveItemTooltip and (isArmor or isWeapon) then
            local equipType = GetItemLinkEquipType(link)
            if (equipType ~= EQUIP_TYPE_INVALID) then
                local styleId = GetItemLinkItemStyle(link)
                if styleId and (styleId ~= ITEMSTYLE_NONE) then
                    local prefix = GetString("SI_ITEMSTYLE", styleId).." "
                    SafeAddString(SI_ITEM_FORMAT_STR_BROAD_TYPE, prefix..defaultStrings["SI_ITEM_FORMAT_STR_BROAD_TYPE"], 1)
                end
            end
        else
            SafeAddString(SI_ITEM_FORMAT_STR_BROAD_TYPE, defaultStrings["SI_ITEM_FORMAT_STR_BROAD_TYPE"], 1)
        end
    end)
end)
