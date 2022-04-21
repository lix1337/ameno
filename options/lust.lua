local soundhandler

local sounds = {}

for key, value in pairs(LSM:HashTable("sound")) do
    sounds[value] = key
end

function generate_lust_gui_elements()
    local lust_group = AceGUI:Create("SimpleGroup")
    lust_group:SetFullWidth(true)
    lust_group:SetLayout("List")

    local lust_heading = AceGUI:Create("Heading")
    lust_heading:SetText("Bloodlust Sound")
    lust_heading:SetFullWidth(true)

    local lust_check_box = AceGUI:Create("CheckBox")
    lust_check_box:SetFullWidth(true)
    lust_check_box:SetLabel("Enable Bloodlust Sound")
    lust_check_box:SetDescription("If enabled, a sound will play on Bloodlust, Time Warp, Heroism, etc.")
    lust_check_box:SetValue(AMENOVARS.lust_sound_enabled)
    lust_check_box:SetCallback("OnValueChanged", function()
        AMENOVARS.lust_sound_enabled = lust_check_box:GetValue()
    end)

    local lust_dropdown = AceGUI:Create("Dropdown")
    lust_dropdown:SetLabel("Sounds")
    lust_dropdown:SetList(sounds)
    lust_dropdown:SetValue(AMENOVARS.lust_sound)
    lust_dropdown:SetCallback("OnValueChanged", function()
        if (soundhandler) then
            StopSound(soundhandler)
        end
        AMENOVARS.lust_sound = lust_dropdown:GetValue()
        _, soundhandler = PlaySoundFile(AMENOVARS.lust_sound, "Master")
    end)

    lust_group:AddChild(lust_heading)
    lust_group:AddChild(lust_check_box)
    lust_group:AddChild(lust_dropdown)

    return lust_group
end
