-- Slightly Improved™ Gameplay
-- The MIT License © 2016 Arthur Corenzan

local NAMESPACE = "SlightlyImprovedGameplay"

local savedVars = {}
local deletableMailIds = {}
local doneDeletingMails = true

local function collectDeletableMailIds()
    for mailId in ZO_GetNextMailIdIter do
        local mailData = {}
        ZO_MailInboxShared_PopulateMailData(mailData, mailId)
        if not mailData.unread and not mailData.fromCS then
            local daysSinceReceived = mailData.secsSinceReceived / (24 * 3600)
            if daysSinceReceived >= savedVars.oldMailThreshold then
                local numAttachments, attachedMoney = GetMailAttachmentInfo(mailData.mailId)
                if numAttachments == 0 and attachedMoney == 0 then
                    table.insert(deletableMailIds, mailId)
                end
            end
        end
    end
end

local keybindStripDescriptor = {
    alignment = KEYBIND_STRIP_ALIGN_LEFT,
    {
        name = GetString(SI_MAIL_READ_DELETE_OLD),
        keybind = "UI_SHORTCUT_QUATERNARY",
        callback = function()
            ZO_Dialogs_ShowDialog("DELETE_OLD_MAIL")
        end,
        visible = function()
            return true
        end
    },
}

local function deleteNextMail()
    if not doneDeletingMails then
        if #deletableMailIds > 0 then
            DeleteMail(deletableMailIds[1], true)
            table.remove(deletableMailIds, 1)
        else
            doneDeletingMails = true
        end
    end
end

ESO_Dialogs["DELETE_OLD_MAIL"] =
{
    gamepadInfo =
    {
        dialogType = GAMEPAD_DIALOGS.BASIC,
    },
    title =
    {
        text = SI_PROMPT_TITLE_DELETE_OLD_MAIL,
    },
    mainText =
    {
        text = SI_OLD_MAIL_CONFIRM_DELETE,
    },
    buttons =
    {
        [1] =
        {
            text = SI_MAIL_DELETE,
            callback = function(dialog)
                doneDeletingMails = false
                deleteNextMail()
            end
        },
        [2] =
        {
            text = SI_DIALOG_CANCEL,
        }
    }
}

CALLBACK_MANAGER:RegisterCallback("SlightlyImprovedGameplay_OnAddOnLoaded", function(loadedSavedVars)
    savedVars = loadedSavedVars
    EVENT_MANAGER:RegisterForEvent(NAMESPACE, EVENT_MAIL_INBOX_UPDATE, function()
        if MAIL_INBOX_SCENE:IsShowing() then
            collectDeletableMailIds()
            if #deletableMailIds > 0 then
                KEYBIND_STRIP:AddKeybindButtonGroup(keybindStripDescriptor)
            else
                KEYBIND_STRIP:RemoveKeybindButtonGroup(keybindStripDescriptor)
            end
        end
    end)
    EVENT_MANAGER:RegisterForEvent(NAMESPACE, EVENT_MAIL_REMOVED, deleteNextMail)
end)
