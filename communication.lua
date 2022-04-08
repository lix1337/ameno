local frame = CreateFrame("Frame")

frame:RegisterEvent("CHAT_MSG_ADDON")

frame:SetScript("OnEvent", function(self, event, ...)
    frame_event_callback(event, ...)
end)

function frame_event_callback(event, ...)
    if (event == "CHAT_MSG_ADDON") then
        chat_massage_addon_callback(...)
    end
end

function chat_massage_addon_callback(prefix, message, chatType, sender)
    if prefix ~= "ameno" then
        return
    end

    if string.find(sender, "-") then
        local minusIndex = string.find(sender, "-") - 1
        sender = string.sub(sender, 1, minusIndex)
    end

    -- Someone joined the addon message channel, send my_death_sound
    if message == "join" then
        C_ChatInfo.SendAddonMessage("ameno", AMENOVARS.my_death_sound, "RAID")
    end

    -- Someone asked for my version
    if string.match(message,"versionQuery-")then
        C_ChatInfo.SendAddonMessage("ameno", "versionReply-" .. amenoversion, "RAID")
    end

    -- Check if the replied version is newer then my own
    if string.match(message,"versionReply-")then
        local version = string.sub(message, (string.find(message, "-") + 1))

        -- Put all patch levels into one number for comparison (e.g. 2.0.4 -> 204)
        local messageMajor, messageMinor, messagePatch = string.match(message, "(%d+)%.(%d+)%.(%d+)")
        local myMajor, myMinor, myPatch = string.match(amenoversion, "(%d+)%.(%d+)%.(%d+)")
        local versionNumberMessage = tonumber(messageMajor .. messageMinor .. messagePatch)
        local versionNumberMy = tonumber(myMajor .. myMinor .. myPatch)
        
        if ( not imWarnedAboutMyOldAssVersion and (versionNumberMessage > versionNumberMy))then
            imWarnedAboutMyOldAssVersion=true
            msg = "A newer version of ameno is available: " .. version .. "\nyou are running the old shit version: " .. amenoversion
            BasicMessageDialog.Text:SetText(msg)
            BasicMessageDialog:Show()
        end
    end

    player_death_sounds_db[sender] = message
end
