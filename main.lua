-- Setup global variables
addon_name = ...
favorite_subjects = {'Englisch', 'Turnen', 'Mathe', 'Musik', 'Kunst'}
smash = "Interface\\Addons\\ameno\\sound\\tableSmash.ogg"
valid_death_sounds = {smash, 
                      "Interface\\Addons\\ameno\\sound\\ach_der_toni.ogg",
                      "Interface\\Addons\\ameno\\sound\\noin.ogg",
                      "Interface\\Addons\\ameno\\sound\\mc_hit.ogg",
                      "Interface\\Addons\\ameno\\sound\\mc_hurt.ogg",
                      "Interface\\Addons\\ameno\\sound\\mc_villager.ogg",
                      "Interface\\Addons\\ameno\\sound\\rb_oof.ogg",
                      "Interface\\Addons\\ameno\\sound\\michi_stoehnt.ogg"}
player_death_sounds_db = {}

-- Join addon message channel
C_ChatInfo.RegisterAddonMessagePrefix("ameno")

-- Execute code on addon load
local addon_loaded_frame = CreateFrame("FRAME")
addon_loaded_frame:RegisterEvent("ADDON_LOADED")
addon_loaded_frame:SetScript("OnEvent", function(self, event, loaded_addon)
    -- Wrong addon
    if loaded_addon ~= addon_name then
        return
    end

    if event == "ADDON_LOADED" then
        -- Setup AMENOVARS if addon is first time used
        if type(AMENOVARS) ~= "table" then
            AMENOVARS = {
                lieblingsfach = favorite_subjects[math.random(5)],
                my_death_sound = smash
            }
        end

        -- Setup specific table values for backwards compatibility
        if AMENOVARS.lieblingsfach == nil then
            AMENOVARS.lieblingsfach = favorite_subjects[math.random(5)]
        end

        if AMENOVARS.my_death_sound == nil then
            AMENOVARS.my_death_sound = smash
        end

        -- Notify everyone that i (re-)joined the channel
        C_ChatInfo.SendAddonMessage("ameno", "join", "RAID")
    end
end)

-- Execute code on group change (e.g. player joins)
local group_update_frame = CreateFrame("FRAME")
group_update_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
group_update_frame:SetScript("OnEvent", function(self, event)
    if event == "GROUP_ROSTER_UPDATE" then
        -- Notify everyone that i joined the group
        C_ChatInfo.SendAddonMessage("ameno", "join", "RAID")
    end
end)
