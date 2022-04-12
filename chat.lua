local function chatCheck(self, event, ...)
    -- Disabled
    if AMENOVARS.lieblingsfach_enabled == false then
        return
    end

    local text = ...

    if (text == "!lieblingsfach") then
        PlaySoundFile(valid_favourite_subjects[AMENOVARS.lieblingsfach], "Master")
        local message = AMENOVARS.lieblingsfach .. " ist mein Lieblingsfach!"
        SendChatMessage(message, "raid")
    end
end

local frame = CreateFrame("frame")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame:SetScript("OnEvent", chatCheck)