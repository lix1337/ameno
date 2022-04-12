local frame = CreateFrame("FRAME")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, event)
    local _, subevent, _, _, _, _, _, _, unit_name, _, _, _, _ = CombatLogGetCurrentEventInfo()

    -- Playing deathsounds is not enabled
    if AMENOVARS.death_sound_enabled == false then
        return
    end

    -- Wrong event
    if subevent ~= "UNIT_DIED" then
        return
    end

    -- Unit not in party or raid
    if UnitInRaid(unit_name) ~= true and UnitInParty(unit_name) ~= true then
        return
    end

    -- Not a real death
    if UnitIsFeignDeath(unit_name) == true then
        return
    end

    -- Remove realm name
    if string.find(unit_name, "-") then
        local minusIndex = string.find(unit_name, "-") - 1
        unit_name = string.sub(unit_name, 1, minusIndex)
    end

    -- Player not using addon, play default sound
    if player_death_sounds_db[unit_name] == nil or AMENOVARS.allow_custom_death_sounds == false then
        PlaySoundFile(AMENOVARS.death_sound_default, "Master")
    else
        PlaySoundFile(player_death_sounds_db[unit_name], "Master")
    end
end)
