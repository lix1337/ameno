local frame = CreateFrame("FRAME")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame:SetScript("OnEvent", function(self, event, ...)
    -- Disabled
    if AMENOVARS.lieblingsfach_enabled == false then
        return
    end

    local text = ...

    if (text == "!lieblingsfach") then
        PlaySoundFile(AMENOVARS.lieblingsfach, "Master")
        local msg = valid_favourite_subjects[AMENOVARS.lieblingsfach] .. " ist mein Lieblingsfach!"
        SendChatMessage(msg, "raid")
    end
end)

local frame1 = CreateFrame("FRAME")
frame1:RegisterEvent("CHAT_MSG_PARTY")
frame1:RegisterEvent("CHAT_MSG_PARTY_LEADER")
frame1:RegisterEvent("CHAT_MSG_RAID")
frame1:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame1:SetScript("OnEvent", function(self, event, ...)
    -- Disabled
    if AMENOVARS.react_to_gesu == false then
        return
    end

    local channel = nil

    if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
        channel = "party"
    end

    if event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
        channel = "raid"
    end

    local text = ...

    if text == "!gesu" and channel then
        SendChatMessage(AMENOVARS.gesu_message, channel)
        
        if AMENOVARS.gesu_sound then
            PlaySoundFile("Interface\\Addons\\ameno\\sound\\marius.ogg", "Master")
        end
    end
end)
