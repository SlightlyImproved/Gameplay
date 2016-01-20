-- Slightly Improved™ Gameplay 1.0.0 (Jan 1 2015)
-- Licensed under CC BY-NC-SA 4.0

local FenceWarner = ZO_Object:Subclass()

local AUTO_WARN_WAIT_TIME = 60 * 10
local TRIGGERED_WARN_WAIT_TIME = 60 * 5

function FenceWarner:New()
    local warner = ZO_Object.New(self)
    warner:Initialize()
    return warner
end

function FenceWarner:Initialize()
    self.isEnabled = true
    self.lastWarning = nil

    local function OnInventoryFullUpdate()
        if self:ShouldWarn(TRIGGERED_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForEvent("FenceWarner", EVENT_INVENTORY_FULL_UPDATE, OnInventoryFullUpdate)

    local function OnInventorySingleSlotUpdate(eventCode, bagId, slotId)
        if (bagId == BAG_BACKPACK) and self:ShouldWarn(TRIGGERED_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForEvent("FenceWarner", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnInventorySingleSlotUpdate)

    local function OnUpdate()
        if self:ShouldWarn(AUTO_WARN_WAIT_TIME) then
            self:Warn()
        end
    end
    EVENT_MANAGER:RegisterForUpdate("FenceWarner", 60 * 1000, OnUpdate)
end

function FenceWarner:Enable()
    self.isEnabled = true
end

function FenceWarner:Disable()
    self.isEnabled = false
end

function FenceWarner:ShouldWarn(waitTime)
    local shouldWarn = AreAnyItemsStolen(BAG_BACKPACK)
    local notInCombat = not IsUnitInCombat("player")
    local waitTimeElapsed = (not self.lastWarning or self.lastWarning + waitTime < GetFrameTimeSeconds())

    return self.isEnabled and shouldWarn and notInCombat and waitTimeElapsed
end

function FenceWarner:Warn(waitTime)
    ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.NEGATIVE_CLICK, SI_HAS_STOLEN_ITEM)
    self.lastWarning = GetFrameTimeSeconds()
end

CALLBACK_MANAGER:RegisterCallback("Sig_OnAddOnLoaded", function()
    FENCE_WARNER = FenceWarner:New()
end)
