-- Slightly Improved™ Gameplay 1.0.0 (Jan 1 2015)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("Sig_OnAddOnLoaded", function()
    -- esoui\ingame\chatsystem\sharedchatsystem.lua:2036
    local ShowPlayerContextMenu = SharedChatSystem.ShowPlayerContextMenu
    function SharedChatSystem:ShowPlayerContextMenu(playerName, rawName)
        ShowPlayerContextMenu(self, playerName, rawName)

        AddMenuItem(GetString(SI_CHAT_PLAYER_CONTEXT_COPY_IN_CHAT), function()
            ZO_LinkHandler_InsertLink(playerName)
        end)

        AddMenuItem(GetString(SI_CHAT_PLAYER_CONTEXT_SEND_MAIL), function()
            MAIL_SEND:ComposeMailTo(playerName)
        end)

        ShowMenu()
    end
end)
