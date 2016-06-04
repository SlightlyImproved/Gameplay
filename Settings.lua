-- SlightlyImprovedGameplay 1.2.1 (Jun 4 2016)
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
        tooltip = "Change whether Send Money or C.O.D. option should be selected by default when writing a new mail.",
        choices = {"Send Money", "C.O.D."},
        getFunc = function() return settings.mailSendDefaultMode end,
        setFunc = function(value) settings.mailSendDefaultMode = value end,
    },
    {
        type = "checkbox",
        name = "Remove Paper Doll",
        tooltip = "Rearrange equipment slots in the inventory screen.",
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
        name = "Display Equipment Style",
        tooltip = "Display armor and weapon style in the item tooltip.",
        getFunc = function() return settings.improveItemTooltip end,
        setFunc = function(value) settings.improveItemTooltip = value end,
    },
    {
        type = "checkbox",
        name = "Remember Guild Store Search",
        tooltip = "Remember search terms across Guild Stores interactions. Nothing changes if you're using a Guild Store replacement.",
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
