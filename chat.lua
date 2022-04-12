local function chatCheck(self, event, ...)
    -- Disabled
    if AMENOVARS.lieblingsfach_enabled == false then
        return
    end

    local text = ...

    if (text == "!lieblingsfach") then
        PlaySoundFile(AMENOVARS.lieblingsfach, "Master")
        local msg = valid_favourite_subjects[AMENOVARS.lieblingsfach] .. " ist mein Lieblingsfach!"
        SendChatMessage(msg, send_to_channel)
    end
end

local frame = CreateFrame("frame")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame:SetScript("OnEvent", chatCheck)
