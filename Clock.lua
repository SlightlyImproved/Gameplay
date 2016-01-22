-- Slightly Improved™ Gameplay 1.0.1 (Jan 21 2015)
-- Licensed under CC BY-NC-SA 4.0

local PERFORMANCE_METER_PADDING = 20

local showClock = false

local function PatchPerformanceMeters()
    local self = PERFORMANCE_METERS

    CreateControlFromVirtual("$(parent)Backdrop", self.control, "Sig_PerformanceMetersBackdrop")
    GetControl(self.control, "Bg"):SetHidden(true)

    self.latencyControl:SetWidth(62)
    self.latencyBars:ClearAnchors()
    self.latencyBars:SetAnchor(LEFT, nil, LEFT, 5, 0)

    self.clockControl = CreateControlFromVirtual("$(parent)Clock", self.control, "Sig_PerformanceMetersClock")
    self.clockLabel = GetControl(self.clockControl, "Label")


    -- esoui\ingame\performance\performancemeter.lua:120
    -- local UpdateVisibility = self.UpdateVisibility
    function self:UpdateVisibility()
        local controls =
        {
            self.framerateControl,
            self.latencyControl,
            self.clockControl,
        }

        local controlIsOn =
        {
            GetSetting_Bool(SETTING_TYPE_UI, UI_SETTING_SHOW_FRAMERATE),
            GetSetting_Bool(SETTING_TYPE_UI, UI_SETTING_SHOW_LATENCY),
            showClock,
        }

        local anyIsOn
        local previousControl
        local totalWidth = 0
        for i = 1, #controls do
            local control = controls[i]
            local isOn = controlIsOn[i]

            if isOn then
                anyIsOn = true
                control:SetHidden(false)
                control:ClearAnchors()
                if previousControl then
                    control:SetAnchor(LEFT, previousControl, RIGHT)
                else
                    control:SetAnchor(LEFT, self.control, LEFT, PERFORMANCE_METER_PADDING, 0)
                end
                previousControl = control
                totalWidth = totalWidth + control:GetWidth()
            else
                control:SetHidden(true)
            end
        end
        self.control:SetWidth(totalWidth + PERFORMANCE_METER_PADDING * 2)
        PERFORMANCE_METER_FRAGMENT:SetHiddenForReason("AnyOn", not anyIsOn, 0, 0)
        self:OnUpdate()
    end

    -- esoui\ingame\performance\performancemeter.lua:65
    function self:OnUpdate()
        if not PERFORMANCE_METER_FRAGMENT:IsHiddenForReason("AnyOn") then
            if not self.framerateControl:IsHidden() then
                self:SetFramerate(GetFramerate())
            end
            if not self.latencyControl:IsHidden() then
                self:SetLatency(GetLatency())
            end
            if not self.clockControl:IsHidden() then
                self.clockLabel:SetText(string.sub(GetTimeString(), 1, -4))
            end
        end
    end
end

CALLBACK_MANAGER:RegisterCallback("Sig_OnAddOnLoaded", function(sv)
    PatchPerformanceMeters()

    showClock = sv.showClock
    PERFORMANCE_METERS:UpdateVisibility()

    SLASH_COMMANDS[GetString(SI_SLASH_CLOCK)] = function()
        showClock = not showClock
        sv.showClock = showClock
        PERFORMANCE_METERS:UpdateVisibility()
    end
end)
