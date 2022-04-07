local frame = CreateFrame("frame")
frame:RegisterEvent("CHAT_MSG_RAID_LEADER")
frame:SetScript("OnEvent", chatCheck)

local function chatCheck(self, event, ...)
    local text = ...

    if (text == "!lieblingsfach") then
        local path = "Interface\\Addons\\ameno\\sound\\lieblingsfach_" .. string.lower(_lieblingsfach) .. ".ogg"
        PlaySoundFile(path, "Master")
        local message = _lieblingsfach .. " ist mein Lieblingsfach!"
        SendChatMessage(message, "raid")
    end
end
