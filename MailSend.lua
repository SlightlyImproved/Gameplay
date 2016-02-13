-- Slightly Improved™ Gameplay 1.1.0 (Feb 15 2016)
-- Licensed under CC BY-NC-SA 4.0

MAIL_SEND_MODE_COD = "C.O.D."
MAIL_SEND_MODE_MONEY_ATTACHMENT = "Send Money"

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(savedVars)

    function MAIL_SEND:SetToDefaultMode()
        if (savedVars.settings.mailSendDefaultMode == MAIL_SEND_MODE_COD) then
            self:SetCoDMode()
        else
            self:SetMoneyAttachmentMode()
        end
    end

    -- esoui\ingame\mail\keyboard\mailsend_keyboard.lua:157
    local clearFields = MAIL_SEND.ClearFields
    function MAIL_SEND:ClearFields(...)
        clearFields(self, ...)
        self:SetToDefaultMode()
    end

    MAIL_SEND:SetToDefaultMode()
end)
