local lust_auras = {
    ["Heroism"] = "Sated",
    ["Bloodlust"] = "Exhaustion",
    ["Time Warp"] = "Temporal Displacement",
    ["Primal Rage"] = "Fatigued",
    ["Drums of Fury"] = "Exhaustion",
    ["Drums of the Mountain"] = "Exhaustion",
    ["Drums of the Maelstrom"] = "Exhaustion",
    ["Drums of Deathly Ferocity"] = "Exhaustion"
}

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
        -- Check if any aura in list exists on player
        if AuraUtil.FindAuraByName(lust, "player") then

            -- Check if player has corresponding debuff. If not, the lust aura is new
            if AuraUtil.FindAuraByName(lust_auras[lust], "player", "HARMFUL") == nil then
                PlaySoundFile(AMENOVARS.lust_sound, "Master")
            end

            return
        end
    end
end)
