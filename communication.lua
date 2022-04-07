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

    player_death_sounds_db[sender] = message
end
