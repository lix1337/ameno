-- Setup global variables
addon_name = ...
-- Magic versioning dont touch
amenoversion="2.0.4"
-- Magic ends
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
valid_favourite_subjects={  ["Englisch"]="Interface\\Addons\\ameno\\sound\\lieblingsfach_englisch.ogg",
                            ["Turnen"]="Interface\\Addons\\ameno\\sound\\lieblingsfach_turnen.ogg",
                            ["Mathe"]="Interface\\Addons\\ameno\\sound\\lieblingsfach_mathe.ogg",
                            ["Musik"]="Interface\\Addons\\ameno\\sound\\lieblingsfach_musik.ogg",
                            ["Kunst"]="Interface\\Addons\\ameno\\sound\\lieblingsfach_kunst.ogg"}
soundhandler=nil;

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

        -- Make sure I get notified about my old ass version
        imWarnedAboutMyOldAssVersion=false

        -- Notify everyone that i (re-)joined the channel
        C_ChatInfo.SendAddonMessage("ameno", "join", "RAID")

        -- Ask everyone for their version
        C_ChatInfo.SendAddonMessage("ameno", "versionQuery-" .. amenoversion, "RAID")
    end
end)

-- Execute code on group change (e.g. player joins)
local group_update_frame = CreateFrame("FRAME")
group_update_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
group_update_frame:SetScript("OnEvent", function(self, event)
    if event == "GROUP_ROSTER_UPDATE" then
        -- Notify everyone that i joined the group
        C_ChatInfo.SendAddonMessage("ameno", "join", "RAID")
        C_ChatInfo.SendAddonMessage("ameno", "versionQuery-" .. amenoversion, "RAID")
    end
end)
