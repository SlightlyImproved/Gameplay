-- SlightlyImprovedGameplay 1.2.1 (Jun 2 2016)
-- Licensed under CC BY-NC-SA 4.0

local function UpdateAnchor(control, newPoint, newRelativeTo, newRelativePoint, newOffsetX, newOffsetY)
    local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY = control:GetAnchor(0)
    if isValidAnchor then
        control:ClearAnchors()
        control:SetAnchor(newPoint or point, newRelativeTo or relativeTo, newRelativePoint or relativePoint, newOffsetX or offsetX, newOffsetY or offsetY)
    end
end

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    if savedVars.compactPaperDoll then
        ZO_CharacterPaperDoll:SetHidden(true)
        ZO_CharacterApparelSection:SetHidden(true)
        ZO_CharacterAccessoriesSection:SetHidden(true)
        ZO_CharacterWeaponsSection:SetHidden(true)

        UpdateAnchor(ZO_CharacterEquipmentSlotsHead, TOPLEFT, ZO_CharacterTitle, BOTTOMLEFT, 0, 10)

        UpdateAnchor(ZO_CharacterEquipmentSlotsShoulder, TOPLEFT, ZO_CharacterEquipmentSlotsHead, BOTTOMLEFT, 0, 10)
        UpdateAnchor(ZO_CharacterEquipmentSlotsGlove, TOPLEFT, ZO_CharacterEquipmentSlotsShoulder, BOTTOMLEFT, 0, 10)
        UpdateAnchor(ZO_CharacterEquipmentSlotsLeg, TOPLEFT, ZO_CharacterEquipmentSlotsGlove, BOTTOMLEFT, 0, 10)

        UpdateAnchor(ZO_CharacterEquipmentSlotsChest, TOPLEFT, ZO_CharacterEquipmentSlotsShoulder, TOPRIGHT, 10, 0)
        UpdateAnchor(ZO_CharacterEquipmentSlotsBelt, TOPLEFT, ZO_CharacterEquipmentSlotsGlove, TOPRIGHT, 10, 0)
        UpdateAnchor(ZO_CharacterEquipmentSlotsFoot, TOPLEFT, ZO_CharacterEquipmentSlotsLeg, TOPRIGHT, 10, 0)

        UpdateAnchor(ZO_CharacterEquipmentSlotsCostume, TOPLEFT, ZO_CharacterEquipmentSlotsHead, TOPRIGHT, 10, 0)

        UpdateAnchor(ZO_CharacterEquipmentSlotsNeck, TOPLEFT, ZO_CharacterEquipmentSlotsChest, TOPRIGHT, 10, 0)
        UpdateAnchor(ZO_CharacterEquipmentSlotsRing1, TOPLEFT, ZO_CharacterEquipmentSlotsBelt, TOPRIGHT, 10, 0)
        UpdateAnchor(ZO_CharacterEquipmentSlotsRing2, TOPLEFT, ZO_CharacterEquipmentSlotsFoot, TOPRIGHT, 10, 0)

        UpdateAnchor(ZO_CharacterEquipmentSlotsMainHand, TOPLEFT, ZO_CharacterEquipmentSlotsLeg, BOTTOMLEFT, 0, 10)
    end
end)
