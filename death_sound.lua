local frame = CreateFrame("FRAME")

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

frame:SetScript("OnEvent", function(self, event)
    local _, subevent, _, _, _, _, _, _, unit_name, _, _, _, _ = CombatLogGetCurrentEventInfo()

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

    -- Player not using addon, play default sound
    if player_death_sounds_db[unit_name] == nil then
        PlaySoundFile("Interface\\Addons\\ameno\\sound\\tableSmash.ogg", "Master")
    else
        PlaySoundFile(player_death_sounds_db[unit_name], "Master")
    end
end)
