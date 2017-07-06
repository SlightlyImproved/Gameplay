-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

local settings = {}

local panel =
{
    type = "panel",
    name = "Slightly Improved™ Gameplay",
    displayName = "Slightly Improved™ Gameplay",
    author = nil,
    version = nil,
}

local options =
{
    {
        type = "dropdown",
        name = "Default Send Mail Mode",
        tooltip = "Change whether Send Money or C.O.D. option should be selected by default when writing a new mail.",
        choices = {"Send Money", "C.O.D."},
        getFunc = function() return settings.mailSendDefaultMode end,
        setFunc = function(value) settings.mailSendDefaultMode = value end,
    },
    {
        type = "checkbox",
        name = "Compact Equipment Slots",
        tooltip = "Rearrange equipment slots in the inventory screen to make it more compact.",
        getFunc = function() return settings.compactPaperDoll end,
        setFunc = function(value) settings.compactPaperDoll = value end,
        warning = "Requires reloading the UI.",
    },
    {
        type = "checkbox",
        name = "Hide Wayshrines in World View",
        tooltip = "Automatically filter out Wayshrines when zooming out to Tamriel.",
        getFunc = function() return settings.noWorldmapWayshrines end,
        setFunc = function(value) settings.noWorldmapWayshrines = value end,
    },
    {
        type = "checkbox",
        name = "Fence Warnings",
        tooltip = "Periodically display warnings when you have stolen items in your inventory.",
        getFunc = function() return settings.isFenceWarnerEnabled end,
        setFunc = function(value) settings.isFenceWarnerEnabled = value end,
    },
    {
        type = "checkbox",
        name = "Trash Warnings",
        tooltip = "Periodically display warnings when you have trash items in your inventory.",
        getFunc = function() return settings.isTrashWarnerEnabled end,
        setFunc = function(value) settings.isTrashWarnerEnabled = value end,
    },
    {
        type = "checkbox",
        name = "Display Style in Item Tooltip",
        tooltip = "Display the armor or weapon style in the left upper corner of its item tooltip.",
        getFunc = function() return settings.improveItemTooltip end,
        setFunc = function(value) settings.improveItemTooltip = value end,
    },
    {
        type = "slider",
        name = "Old Mail Threshold in Days",
        tooltip = "Mail older than this number of days can be deleted in bulk. Note that Mail that's still unread or has items/gold attached to it won't be touched.",
        min = 0,
        max = 30,
        step = 1,
        getFunc = function() return settings.oldMailThreshold end,
        setFunc = function(value) settings.oldMailThreshold = value end,
    },
}

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    settings = savedVars

    local LAM = LibStub("LibAddonMenu-2.0")
    LAM:RegisterAddonPanel("SlightlyImprovedGameplay", panel)
    LAM:RegisterOptionControls("SlightlyImprovedGameplay", options)
end)
