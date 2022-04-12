-- Setup global variables
addon_name = ...
-- Magic versioning dont touch
amenoversion = "2.1.1"
-- Magic ends
player_death_sounds_db = {}
AceGUI = LibStub("AceGUI-3.0")

-- Join addon message channel
C_ChatInfo.RegisterAddonMessagePrefix("ameno")

-- Execute code after variables are loaded (all addons are loaded at this point)
local addon_loaded_frame = CreateFrame("FRAME")
addon_loaded_frame:RegisterEvent("VARIABLES_LOADED")
addon_loaded_frame:SetScript("OnEvent", function(self, event, loaded_addon)
    -- Wrong addon
    if loaded_addon ~= addon_name then
        return
    end

    if event == "VARIABLES_LOADED" then
        -- Setup AMENOVARS if addon is first time used
        if type(AMENOVARS) ~= "table" then
            AMENOVARS = {}
        end

        if AMENOVARS.debug_mode == nil then
            AMENOVARS.debug_mode = false
        end

        -- Setup specific table values for backwards compatibility
        if AMENOVARS.lieblingsfach == nil then
            AMENOVARS.lieblingsfach = favorite_subjects[math.random(5)]
        end

        if AMENOVARS.my_death_sound == nil then
            AMENOVARS.my_death_sound = smash
        end

        -- Make sure I get notified about my old ass version
        imWarnedAboutMyOldAssVersion = false

        -- Notify everyone that i (re-)joined the channel
        C_ChatInfo.SendAddonMessage("ameno", "join", send_to_channel)
    end
end)
