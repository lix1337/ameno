valid_death_sounds = {
    ["Interface\\Addons\\ameno\\sound\\tableSmash.ogg"] = "Toni Table Smash",
    ["Interface\\Addons\\ameno\\sound\\ach_der_toni.ogg"] = "Ach, der Toni",
    ["Interface\\Addons\\ameno\\sound\\noin.ogg"] = "Noin",
    ["Interface\\Addons\\ameno\\sound\\mc_hit.ogg"] = "MC Hit",
    ["Interface\\Addons\\ameno\\sound\\mc_hurt.ogg"] = "MC Hurt",
    ["Interface\\Addons\\ameno\\sound\\mc_villager.ogg"] = "MC Villager",
    ["Interface\\Addons\\ameno\\sound\\rb_oof.ogg"] = "RB Oof",
    ["Interface\\Addons\\ameno\\sound\\michi_stoehnt.ogg"] = "Michi Stoehnt"
}

local variables_loaded_frame = CreateFrame("FRAME")
variables_loaded_frame:RegisterEvent("VARIABLES_LOADED")
variables_loaded_frame:SetScript("OnEvent", function(self, event)
    if event == "VARIABLES_LOADED" then
        death_sound_group = AceGUI:Create("SimpleGroup")
        death_sound_group:SetFullWidth(true)
        death_sound_group:SetLayout("List")

        local death_sounds_heading = AceGUI:Create("Heading")
        death_sounds_heading:SetText("Death Sounds")
        death_sounds_heading:SetFullWidth(true)

        -- Enable Player Death Sound
        local death_sound_check_box = AceGUI:Create("CheckBox")
        death_sound_check_box:SetFullWidth(true)
        death_sound_check_box:SetLabel("Enable Player Death Sound")
        death_sound_check_box:SetDescription("If enabled, a death sound will play on player death.")
        death_sound_check_box:SetValue(AMENOVARS.death_sound_enabled)
        death_sound_check_box:SetCallback("OnValueChanged", function()
            AMENOVARS.death_sound_enabled = death_sound_check_box:GetValue()
        end)

        -- Allow Custom Player Death Sounds
        local death_sound_custom_check_box = AceGUI:Create("CheckBox")
        death_sound_custom_check_box:SetFullWidth(true)
        death_sound_custom_check_box:SetLabel("Allow Custom Player Death Sounds")
        death_sound_custom_check_box:SetDescription("If allowed, the players own death sound will play on death.")
        death_sound_custom_check_box:SetValue(AMENOVARS.custom_death_sounds_enabled)
        death_sound_custom_check_box:SetCallback("OnValueChanged", function()
            --AMENOVARS.custom_death_sounds_enabled = death_sound_custom_check_box:GetValue()
        end)

        local death_sound_dropdown_group = AceGUI:Create("SimpleGroup")
        death_sound_dropdown_group:SetFullWidth(true)
        death_sound_dropdown_group:SetLayout("Flow")

        -- Default Player Death Sound
        local death_sound_default_dropdown = AceGUI:Create("Dropdown")
        death_sound_default_dropdown:SetLabel("Default Player Death Sound")
        death_sound_default_dropdown:SetList(valid_death_sounds)
        death_sound_default_dropdown:SetValue(AMENOVARS.death_sound_default)
        death_sound_default_dropdown:SetCallback("OnValueChanged", function()
            AMENOVARS.death_sound_default = death_sound_default_dropdown:GetValue()
            PlaySoundFile(AMENOVARS.death_sound_default, "Master")
        end)

        -- Own Player Death Sound
        local death_sound_own_dropdown = AceGUI:Create("Dropdown")
        death_sound_own_dropdown:SetLabel("Own Player Death Sound")
        death_sound_own_dropdown:SetList(valid_death_sounds)
        death_sound_own_dropdown:SetValue(AMENOVARS.death_sound_own)
        death_sound_own_dropdown:SetCallback("OnValueChanged", function()
            AMENOVARS.death_sound_own = death_sound_own_dropdown:GetValue()
            PlaySoundFile(AMENOVARS.death_sound_own, "Master")
            C_ChatInfo.SendAddonMessage("ameno", death_sound_prefix .. AMENOVARS.death_sound_own, "RAID")
        end)

        death_sound_dropdown_group:AddChild(death_sound_default_dropdown)
        death_sound_dropdown_group:AddChild(death_sound_own_dropdown)

        death_sound_group:AddChild(death_sounds_heading)
        death_sound_group:AddChild(death_sound_check_box)
        death_sound_group:AddChild(death_sound_custom_check_box)
        death_sound_group:AddChild(death_sound_dropdown_group)
    end
end)
