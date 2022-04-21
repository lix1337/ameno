local lust_auras = {
    ["Heroism"] = true,
    ["Bloodlust"] = true,
    ["Time Warp"] = true,
    ["Primal Rage"] = true,
    ["Drums of Fury"] = true,
    ["Drums of the Mountain"] = true,
    ["Drums of the Maelstrom"] = true,
    ["Drums of Deathly Ferocity"] = true
}

local last_time = nil

local frame = CreateFrame("FRAME")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", function(self, event, ...)
    local unit = ...

    -- Not enabled
    if AMENOVARS.lust_sound_enabled == false then
        return
    end

    -- Ignore aura changes on everyone but the own player
    if unit ~= "player" then
        return
    end

    -- If an aura on player changes while any lust is already active, the sound would retrigger.
    -- Thus skip all aura changes for 10 minutes after last lust was detected.
    if last_time ~= nil and time() - last_time < 590 then
        return
    end

    for lust in pairs(lust_auras) do
        -- Check if any aura in list exists on player
        if AuraUtil.FindAuraByName(lust, "player") then
            PlaySoundFile(AMENOVARS.lust_sound, "Master")

            -- Save the time lust was detected
            last_time = time()
            return
        end
    end
end)
