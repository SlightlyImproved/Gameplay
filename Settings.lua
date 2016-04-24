-- SlightlyImprovedGameplay 1.1.1 (Feb 18 2016)
-- Licensed under CC BY-NC-SA 4.0

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
        name = "Send Mail Mode",
        tooltip = "Change whether Send Money or C.O.D. option should be selected by default when sending a new mail.",
        choices = {"Send Money", "C.O.D."},
        getFunc = function() return settings.mailSendDefaultMode end,
        setFunc = function(value) settings.mailSendDefaultMode = value end,
    },
    {
        type = "checkbox",
        name = "Compact Paper Doll",
        tooltip = "Rearrange equipped gear slots in the inventory screen.",
        getFunc = function() return settings.compactPaperDoll end,
        setFunc = function(value) settings.compactPaperDoll = value end,
        warning = "Requires reloading the UI.",
    },
    {
        type = "checkbox",
        name = "No Worldmap Wayshrines",
        tooltip = "Automatically filter out Wayshrines when zooming out to the world map.",
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
        name = "Display Weapon and Armor Style",
        tooltip = "Display armor and weapon style in the item tooltip.",
        getFunc = function() return settings.improveItemTooltip end,
        setFunc = function(value) settings.improveItemTooltip = value end,
    },
    {
        type = "checkbox",
        name = "Prevent Guild Store filter reset",
        tooltip = "Remember search filters across multiple Guild Stores. Makes no difference if you're using a replacement for Guild Store like AwesomeGuildStore.",
        getFunc = function() return settings.preventStoreSearchReset end,
        setFunc = function(value) settings.preventStoreSearchReset = value end,
    },
}

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    settings = savedVars

    local LAM = LibStub("LibAddonMenu-2.0")
    LAM:RegisterAddonPanel("SlightlyImprovedGameplay", panel)
    LAM:RegisterOptionControls("SlightlyImprovedGameplay", options)
end)
