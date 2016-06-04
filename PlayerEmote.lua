-- SlightlyImprovedGameplay 1.2.1 (Jun 4 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)
    local function emoteAcquireBehavior(control)
        if (not control.hasBeenSlightlyImproved) then
            control.hasBeenSlightlyImproved = true
            control:SetMouseEnabled(true)
            control:SetHandler("OnMouseEnter", function()
                control:SetColor(ZO_HIGHLIGHT_TEXT:UnpackRGB())
            end)
            control:SetHandler("OnMouseExit", function()
                control:SetColor(ZO_NORMAL_TEXT:UnpackRGB())
            end)
            control:SetHandler("OnMouseDown", function()
                control:SetColor(ZO_SELECTED_TEXT:UnpackRGB())
                local emote = control:GetText()
                -- d(emote)
                -- d(SLASH_COMMANDS[emote])
                if SLASH_COMMANDS[emote] then
                    SCENE_MANAGER:ShowBaseScene()
                    SLASH_COMMANDS[emote]()
                end
            end)
            control:SetHandler("OnMouseUp", function()
                control:SetColor(ZO_HIGHLIGHT_TEXT:UnpackRGB())
            end)
        end
    end
    KEYBOARD_PLAYER_EMOTE.emoteControlPool:SetCustomAcquireBehavior(emoteAcquireBehavior)
    KEYBOARD_PLAYER_EMOTE:UpdateCategories()
end)
