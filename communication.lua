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
    if string.match(message,"versionQuery-") then
        C_ChatInfo.SendAddonMessage("ameno", "versionReply-" .. amenoversion, "RAID")
        return
    end

    -- Check if the replied version is newer then my own
    if string.match(message,"versionReply-") then
        if (imWarnedAboutMyOldAssVersion) then
            return;
        end
        local version = string.sub(message, (string.find(message, "-") + 1))

        if(checkIfVersionIsNewer(message)==1)then
            -- My version is not up to date
            msg = "A newer version of ameno is available: " .. version .. "\nyou are running the old shit version: " .. amenoversion
            BasicMessageDialog.Text:SetText(msg)
            BasicMessageDialog:Show()
            imWarnedAboutMyOldAssVersion=true
        end
        return
    end
    player_death_sounds_db[sender] = message
end
