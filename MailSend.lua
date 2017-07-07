-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

local NAMESPACE = "SlightlyImprovedGameplay"

MAIL_SEND_MODE_COD = "C.O.D."
MAIL_SEND_MODE_MONEY_ATTACHMENT = "Send Money"

function MAIL_SEND:SetDefaultMode(defaultMode)
    if (defaultMode == MAIL_SEND_MODE_COD) then
        self:SetCoDMode()
    else
        self:SetMoneyAttachmentMode()
    end
end

CALLBACK_MANAGER:RegisterCallback(NAMESPACE.."_OnSavedVarChanged", function(key, value, oldValue)
    if (key == "mailSendDefaultMode") then
        MAIL_SEND:SetDefaultMode(value)
    end
end)

CALLBACK_MANAGER:RegisterCallback(NAMESPACE.."_OnAddOnLoaded", function(savedVars)
    -- esoui\ingame\mail\keyboard\mailsend_keyboard.lua:157
    local clearFields = MAIL_SEND.ClearFields
    function MAIL_SEND:ClearFields(...)
        clearFields(self, ...)
        self:SetDefaultMode(savedVars.mailSendDefaultMode)
    end

    MAIL_SEND:SetDefaultMode(savedVars.mailSendDefaultMode)
end)
