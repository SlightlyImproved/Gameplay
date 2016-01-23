-- Slightly Improved™ Gameplay 1.0.1 (Jan 23 2016)
-- Licensed under CC BY-NC-SA 4.0

CALLBACK_MANAGER:RegisterCallback("Sig_OnAddOnLoaded", function()

    -- esoui\ingame\mail\keyboard\mailsend_keyboard.lua:157
    local clearFields = MAIL_SEND.ClearFields
    function MAIL_SEND:ClearFields(...)
        clearFields(self, ...)
        self:SetCoDMode()
    end
    MAIL_SEND:SetCoDMode()
end)
