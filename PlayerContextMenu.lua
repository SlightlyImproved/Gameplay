-- Slightly Improved™ Gameplay 1.2.0 (Apr 24 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function()
    -- esoui\ingame\chatsystem\sharedchatsystem.lua:2036
    local ShowPlayerContextMenu = SharedChatSystem.ShowPlayerContextMenu
    function SharedChatSystem:ShowPlayerContextMenu(playerName, rawName)
        ShowPlayerContextMenu(self, playerName, rawName)

        AddMenuItem(GetString(SI_CHAT_PLAYER_CONTEXT_COPY_IN_CHAT), function()
            ZO_LinkHandler_InsertLink(playerName)
        end)

        AddMenuItem(GetString(SI_CHAT_PLAYER_CONTEXT_SEND_MAIL), function()
            if MAIL_SEND:IsHidden() then
                MAIL_SEND:ComposeMailTo(playerName)
            else
                MAIL_SEND:SetReply(playerName)
            end
        end)

        -- Refresh menu.
        ShowMenu()
    end
end)
