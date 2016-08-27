-- SlightlyImprovedGameplay 1.2.2 (Aug 27 2016)
-- Licensed under MIT © 2016 Arthur Corenzan

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
