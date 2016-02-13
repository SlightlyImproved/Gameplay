
local getSetting
local setSetting

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
        name = "New Mail Mode",
        tooltip = "Change whether Send Money or C.O.D. option should be selected by default when sending a new mail.",
        choices = {"Send Money", "C.O.D."},
        getFunc = function() return getSetting("mailSendDefaultMode") end,
        setFunc = function(value)
            setSetting("mailSendDefaultMode", value)
            MAIL_SEND:SetToDefaultMode()
        end,
    },
    {
        type = "checkbox",
        name = "Compact Paper Doll",
        tooltip = "Rearrange equipped gear slots in the inventory screen.",
        getFunc = function() return getSetting("compactPaperDoll") end,
        setFunc = function(value) setSetting("compactPaperDoll", value) end,
        warning = "Requires reloading the UI.",
    },
    {
        type = "checkbox",
        name = "No Worldmap Wayshrines",
        tooltip = "Automatically filter out Wayshrines when zooming out to the world map.",
        getFunc = function() return getSetting("noWorldmapWayshrines") end,
        setFunc = function(value) setSetting("noWorldmapWayshrines", value) end,
    },
    {
        type = "checkbox",
        name = "Fence Warnings",
        tooltip = "Periodically display warnings when you have stolen items in your inventory.",
        getFunc = function() return getSetting("isFenceWarnerEnabled") end,
        setFunc = function(value) setSetting("isFenceWarnerEnabled", value) end,
    },
    {
        type = "checkbox",
        name = "Trash Warnings",
        tooltip = "Periodically display warnings when you have trash items in your inventory.",
        getFunc = function() return getSetting("isTrashWarnerEnabled") end,
        setFunc = function(value) setSetting("isTrashWarnerEnabled", value) end,
    },
}

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    getSetting = function(name)
        return savedVars.settings[name]
    end
    setSetting = function(name, value)
        savedVars.settings[name] = value
    end

    local LAM = LibStub("LibAddonMenu-2.0")

    LAM:RegisterAddonPanel("SlightlyImprovedGameplay", panel)
    LAM:RegisterOptionControls("SlightlyImprovedGameplay", options)
end)
