-- Slightly Improved™ Gameplay 1.0.1 (Jan 21 2015)
-- Licensed under CC BY-NC-SA 4.0

local TrashWarner = ZO_Object:Subclass()

local AUTO_WARN_WAIT_TIME = 60 * 10
local TRIGGERED_WARN_WAIT_TIME = 60 * 10

function TrashWarner:New()
    local warner = ZO_Object.New(self)
    warner:Initialize()
    return warner
end

function TrashWarner:Initialize()
    self.isEnabled = true
    self.lastWarning = nil

    local function OnInventoryFullUpdate()
        if self:ShouldWarn(TRIGGERED_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForEvent("TrashWarner", EVENT_INVENTORY_FULL_UPDATE, OnInventoryFullUpdate)

    local function OnInventorySingleSlotUpdate(eventCode, bagId, slotId)
        if (bagId == BAG_BACKPACK) and self:ShouldWarn(TRIGGERED_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForEvent("TrashWarner", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)

    local function OnUpdate()
        if self:ShouldWarn(AUTO_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForUpdate("TrashWarner", 60 * 1000, OnUpdate)
end

function TrashWarner:Enable()
    self.isEnabled = true
end

function TrashWarner:Disable()
    self.isEnabled = false
end

function TrashWarner:ShouldWarn(waitTime)
    local shouldWarn = false

    for i = 1, GetBagSize(BAG_BACKPACK) do
        local itemType = GetItemType(BAG_BACKPACK, i)
        if (itemType == ITEMTYPE_NONE) then
            break
        end
        if (itemType == ITEMTYPE_TRASH) or (itemType == ITEMTYPE_TROPHY) then
            shouldWarn = true
            break
        end
    end

    local notInCombat = not IsUnitInCombat("player")
    local waitTimeElapsed = (not self.lastWarning or self.lastWarning + waitTime < GetFrameTimeSeconds())

    return self.isEnabled and shouldWarn and notInCombat and waitTimeElapsed
end

function TrashWarner:Warn(waitTime)
    ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, SI_HAS_TRASH_ITEM)
    self.lastWarning = GetFrameTimeSeconds()
end

CALLBACK_MANAGER:RegisterCallback("Sig_OnAddOnLoaded", function()
    TRASH_WARNER = TrashWarner:New()
end)
