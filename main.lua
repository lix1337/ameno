-- Setup global variables
addon_name = ...

-- Magic versioning dont touch
amenoversion = "2.1.1"
-- Magic ends

player_death_sounds_db = {}

-- Reference to libs
AceGUI = LibStub("AceGUI-3.0")
AceTimer = LibStub("AceTimer-3.0")
LSM = LibStub("LibSharedMedia-3.0")

-- Join addon message channel
C_ChatInfo.RegisterAddonMessagePrefix("ameno")

-- Execute code after variables are loaded (all addons are loaded at this point)
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
            AMENOVARS = {}
        end

        -- Setup specific table values for backwards compatibility
        if AMENOVARS.lieblingsfach == nil then
            AMENOVARS.lieblingsfach = "Interface\\Addons\\ameno\\sound\\lieblingsfach_englisch.ogg"
        end

        if AMENOVARS.death_sound_own == nil then
            AMENOVARS.death_sound_own = "Interface\\Addons\\ameno\\sound\\tableSmash.ogg"
        end

        if AMENOVARS.death_sound_default == nil then
            AMENOVARS.death_sound_default = "Interface\\Addons\\ameno\\sound\\tableSmash.ogg"
        end

        if AMENOVARS.death_sound_enabled == nil then
            AMENOVARS.death_sound_enabled = true
        end

        if AMENOVARS.custom_death_sounds_enabled == nil then
            AMENOVARS.custom_death_sounds_enabled = true
        end

        if AMENOVARS.react_to_gesu == nil then
            AMENOVARS.react_to_gesu = true
        end

        if AMENOVARS.gesu_message == nil then
            AMENOVARS.gesu_message = "187, wo ist nur der gesu geblieben?"
        end

        if AMENOVARS.lieblingsfach_enabled == nil then
            AMENOVARS.lieblingsfach_enabled = true
        end

        if AMENOVARS.play_pull_timer_sounds == nil then
            AMENOVARS.play_pull_timer_sounds = false
        end

        if AMENOVARS.pull_timer == nil then
            AMENOVARS.pull_timer = "monte_half_wrong"
        end

        if AMENOVARS.lust_sound_enabled == nil then
            AMENOVARS.lust_sound_enabled = true
        end

        if AMENOVARS.lust_sound == nil then
            AMENOVARS.lust_sound = "Interface\\Addons\\ameno\\sound\\geilgeilgeil.ogg"
        end

        -- Make sure I get notified about my old ass version
        imWarnedAboutMyOldAssVersion = false

        -- Notify everyone that i (re-)joined the channel
        C_ChatInfo.SendAddonMessage("ameno", "join", send_to_channel)
    end
end)
