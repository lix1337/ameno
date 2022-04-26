local lust_auras = {
    ["Heroism"] = "Exhaustion",
    ["Bloodlust"] = "Sated",
    ["Time Warp"] = "Temporal Displacement",
    ["Primal Rage"] = "Fatigued",
    ["Drums of Fury"] = "Exhaustion",
    ["Drums of the Mountain"] = "Exhaustion",
    ["Drums of the Maelstrom"] = "Exhaustion",
    ["Drums of Deathly Ferocity"] = "Exhaustion"
}

local last_lust = nil

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

    for lust in pairs(lust_auras) do
        local name, _, _, _, _, expiration_time = AuraUtil.FindAuraByName(lust, "player")

        -- lust found
        if expiration_time ~= nil then

            -- check if lust is new
            if last_lust ~= expiration_time then
                PlaySoundFile(AMENOVARS.lust_sound, "Master")
                last_lust = expiration_time
            end

            return
        end
    end
end)
