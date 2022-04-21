local monte_timer_correct = {
    "Interface\\Addons\\ameno\\sound\\mb_01.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_02.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_03.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_04.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_05.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_06.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_07.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_08.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_09.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_10.ogg"
}

local monte_timer_wrong = {
    "Interface\\Addons\\ameno\\sound\\mb_01.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_02.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_03.ogg",
    nil,
    "Interface\\Addons\\ameno\\sound\\mb_6_7_diggaWerBruder.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_07.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_06.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_08.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_09.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_10.ogg"
}

local monte_timer_half = {
    nil,
    nil,
    nil,
    nil,
    "Interface\\Addons\\ameno\\sound\\mb_6_7_diggaWerBruder.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_07.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_06.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_08.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_09.ogg",
    "Interface\\Addons\\ameno\\sound\\mb_10.ogg",
}

local timer, i = nil, nil

local function play_pull_sound()
    if AMENOVARS.pull_timer == "monte_full_correct" then
        if monte_timer_correct[i] ~= nil then
            PlaySoundFile(monte_timer_correct[i], "Master")
        end
    end

    if AMENOVARS.pull_timer == "monte_full_wrong" then
        if monte_timer_wrong[i] ~= nil then
            PlaySoundFile(monte_timer_wrong[i], "Master")
        end
    end

    if AMENOVARS.pull_timer == "monte_half_wrong" then
        if monte_timer_half[i] ~= nil then
            PlaySoundFile(monte_timer_half[i], "Master")
        end
    end

    -- Timer has ended, reset
    if i < 1 then
        AceTimer:CancelTimer(timer)
        timer = nil
    end

    -- Decrement
    i = i - 1
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", function(self, event, prefix, message, chatType, sender)
    -- Custom pull timer is disabled
    if AMENOVARS.play_pull_timer_sounds == false then
        return
    end

    -- Handle DBM timer message
    if prefix == "D4" then
        if string.match(message, "PT\t") then
            i = string.match(message, "\t%d+\t")
            i = string.gsub(i, "\t", "")
            i = tonumber(i)

            -- pull was cancelled (DBM sends pull 0 on abort)
            if i == 0 then
                AceTimer:CancelTimer(timer)
                timer = nil
                return
            end

            -- Reset timer (important, else timer can be messed up)
            AceTimer:CancelTimer(timer)
            timer = nil

            -- Play first sound immediately
            play_pull_sound()

            -- Start timer every 1 second, after 1 second
            timer = AceTimer:ScheduleRepeatingTimer(play_pull_sound, 1)
            return
        end
    end

    -- Handle BigWigs timer message
    if prefix == "BigWigs" then
        if string.match(message, "P^Pull^") then
            i = string.match(message, "%d+")
            i = tonumber(i)

            -- pull was cancelled (BigWigs sends pull 0 on abort)
            if i == 0 then
                AceTimer:CancelTimer(timer)
                timer = nil
                return
            end

            -- Reset timer (important, else timer can be messed up)
            AceTimer:CancelTimer(timer)
            timer = nil

            -- Play first sound immediately
            play_pull_sound()

            -- Start timer every 1 second, after 1 second
            timer = AceTimer:ScheduleRepeatingTimer(play_pull_sound, 1)
            return
        end
    end
end)
