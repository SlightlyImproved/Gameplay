local PerformanceMeter = ZO_Object:Subclass()

local HIGH_LATENCY = 300
local MEDIUM_LATENCY = 150
local LOW_LATENCY = 0
local MAX_FRAMERATE = 999
local MAX_LATENCY = 999

local LATENCY_ICONS =
{
    [HIGH_LATENCY] = { image = "EsoUI/Art/Campaign/campaignBrowser_lowPop.dds", color = ZO_ERROR_COLOR },
    [MEDIUM_LATENCY] = { image = "EsoUI/Art/Campaign/campaignBrowser_medPop.dds", color = ZO_SELECTED_TEXT },
    [LOW_LATENCY] = { image = "EsoUI/Art/Campaign/campaignBrowser_hiPop.dds", color = ZO_SELECTED_TEXT }
}

local POSITION_DEFAULTS =
{
    point = BOTTOMLEFT,
    relPoint = BOTTOMLEFT,
    x = -20,
    y = 20,
}

function PerformanceMeter:New(...)
    local container = ZO_Object.New(self)
    container:Initialize(...)
    return container
end

function PerformanceMeter:Initialize(control)
    self.control = control
    self.framerateLabel = GetControl(control, "FramerateLabel")
    self.latencyLabel = GetControl(control, "LatencyLabel")
    self.clockLabel = GetControl(control, "ClockLabel")

    self.sv = {}
    -- local function OnAddOnLoaded(event, name)
    --     if name == "ZO_Ingame" then
    --         self.sv = ZO_SavedVars:New("ZO_Ingame_SavedVariables", 1, "PerformanceMeter", POSITION_DEFAULTS)
    --         self.control:ClearAnchors()
    --         self.control:SetAnchor(self.sv.point, nil, self.sv.relPoint, self.sv.x, self.sv.y)
    --         self:UpdateVisibility()
    --         self:UpdateMovable()
    --         self.control:UnregisterForEvent(EVENT_ADD_ON_LOADED)
    --     end
    -- end

    local function OnInterfaceSettingChanged(eventCode, settingType, settingId)
        if settingType == SETTING_TYPE_UI then
            if settingId == UI_SETTING_SHOW_FRAMERATE or settingId == UI_SETTING_SHOW_LATENCY then
                self:UpdateVisibility()
            elseif settingId == UI_SETTING_FRAMERATE_LATENCY_LOCK then
                self:UpdateMovable()
            end
        end
    end

    -- self.control:RegisterForEvent(EVENT_ADD_ON_LOADED, OnAddOnLoaded)
    self.control:RegisterForEvent(EVENT_INTERFACE_SETTING_CHANGED, OnInterfaceSettingChanged)

    EVENT_MANAGER:RegisterForUpdate("Sig_PerformanceMeter", 1000, function() self:OnUpdate() end)

    SIG_PERFORMANCE_METER_FRAGMENT = ZO_HUDFadeSceneFragment:New(control)
    HUD_SCENE:AddFragment(SIG_PERFORMANCE_METER_FRAGMENT)
    HUD_UI_SCENE:AddFragment(SIG_PERFORMANCE_METER_FRAGMENT)

    self:UpdateVisibility()
    self:UpdateMovable()
end

function PerformanceMeter:OnUpdate()
    if not SIG_PERFORMANCE_METER_FRAGMENT:IsHiddenForReason("AnyOn") then
        if not self.framerateLabel:IsHidden() then
            self:SetFramerate(GetFramerate())
        end
        if not self.latencyLabel:IsHidden() then
            self:SetLatency(GetLatency())
        end
        if not self.clockLabel:IsHidden() then
            self:SetTime(GetTimeString())
        end
    end
end

function PerformanceMeter:SetFramerate(framerate)
    if framerate then
        local addPlus = false
        if framerate > MAX_FRAMERATE then
            framerate = MAX_FRAMERATE
            addPlus = true
        end
        self.framerateLabel:SetText(zo_strformat(SI_FRAMERATE_METER_FORMAT, zo_round(framerate)))
    end
end

function PerformanceMeter:SetLatency(latency)
    if latency then
        local overMaxLabel
        if latency > MAX_LATENCY then
            latency = MAX_LATENCY
            overMaxLabel = zo_strformat(SI_LATENCY_EXTREME_FORMAT, latency)
        end
        --Determine if we need to update the icon and color
        local threshold = LOW_LATENCY
        if latency >= MEDIUM_LATENCY then
            threshold = latency >= HIGH_LATENCY and HIGH_LATENCY or MEDIUM_LATENCY
        end
        local icon = LATENCY_ICONS[threshold]
        if overMaxLabel then
            self.latencyLabel:SetText(zo_iconFormat(icon.image, 26, 26)..overMaxLabel)
        else
            self.latencyLabel:SetText(zo_iconFormat(icon.image, 26, 26)..tostring(latency))
        end
        if self.previousLatencyThreshold ~= threshold then
            self.latencyLabel:SetColor(icon.color:UnpackRGBA())
            self.previousLatencyThreshold = threshold
        end
    end
end

function PerformanceMeter:SetTime(time)
    self.clockLabel:SetText(string.sub(time, 1, -4))
end

function PerformanceMeter:UpdateMovable()
    self.control:SetMovable(not GetSetting_Bool(SETTING_TYPE_UI, UI_SETTING_FRAMERATE_LATENCY_LOCK))
end

local g_isClockOn = true

function PerformanceMeter:UpdateVisibility()
    local labels =
    {
        self.framerateLabel,
        self.latencyLabel,
        self.clockLabel,
    }

    local settings =
    {
        GetSetting_Bool(SETTING_TYPE_UI, UI_SETTING_SHOW_FRAMERATE),
        GetSetting_Bool(SETTING_TYPE_UI, UI_SETTING_SHOW_LATENCY),
        g_isClockOn,
    }

    local previousLabel
    local anyOn = false

    for index, label in ipairs(labels) do
        if settings[index] then
            anyOn = true
            label:SetHidden(false)
            label:ClearAnchors()
            if previousLabel then
                label:SetAnchor(LEFT, previousLabel, RIGHT, 20)
            else
                label:SetAnchor(LEFT)
            end
            previousLabel = label
        else
            label:SetHidden(true)
        end
    end

    SIG_PERFORMANCE_METER_FRAGMENT:SetHiddenForReason("AnyOn", not anyOn, 0, 0)

    self:OnUpdate()
end

function PerformanceMeter:ResetPosition()
    self.control:ClearAnchors()
    self.control:SetAnchor(POSITION_DEFAULTS.point, nil, POSITION_DEFAULTS.relPoint, POSITION_DEFAULTS.x, POSITION_DEFAULTS.y)
    self:OnMoveStop()
end

function PerformanceMeter:OnMoveStop()
    local _
    _, self.sv.point, _, self.sv.relPoint, self.sv.x, self.sv.y = self.control:GetAnchor(0)
end

function PerformanceMeter:Meter_OnMouseEnter(control)
    local tooltipText
    if control == self.framerateLabel then
        tooltipText = GetString(SI_FRAMERATE_METER_TOOLTIP)
    elseif control == self.latencyLabel then
        tooltipText = GetString(SI_LATENCY_METER_TOOLTIP)
    elseif control == self.clockLabel then
        tooltipText = "Clock"
    end

    if tooltipText then
        InitializeTooltip(InformationTooltip, control, BOTTOM, 0, 0)
        SetTooltipText(InformationTooltip, tooltipText)
    end
end

function PerformanceMeter:Meter_OnMouseExit(control)
    ClearTooltip(InformationTooltip)
end

function Sig_PerformanceMeter_OnMouseEnter(control)
    SIG_PERFORMANCE_METER:Meter_OnMouseEnter(control)
end

function Sig_PerformanceMeter_OnMouseExit(control)
    SIG_PERFORMANCE_METER:Meter_OnMouseExit(control)
end

function Sig_PerformanceMeter_OnMoveStop(control)
    SIG_PERFORMANCE_METER:OnMoveStop()
end

function Sig_PerformanceMeter_OnInitialized(control)
    SIG_PERFORMANCE_METER = PerformanceMeter:New(control)
end
