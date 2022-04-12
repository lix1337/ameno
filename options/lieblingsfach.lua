valid_favourite_subjects = {
    ["Interface\\Addons\\ameno\\sound\\lieblingsfach_englisch.ogg"] = "Englisch",
    ["Interface\\Addons\\ameno\\sound\\lieblingsfach_turnen.ogg"] = "Turnen",
    ["Interface\\Addons\\ameno\\sound\\lieblingsfach_mathe.ogg"] = "Mathe",
    ["Interface\\Addons\\ameno\\sound\\lieblingsfach_musik.ogg"] = "Musik",
    ["Interface\\Addons\\ameno\\sound\\lieblingsfach_kunst.ogg"] = "Kunst"
}

local variables_loaded_frame = CreateFrame("FRAME")
variables_loaded_frame:RegisterEvent("VARIABLES_LOADED")
variables_loaded_frame:SetScript("OnEvent", function(self, event)
    if event == "VARIABLES_LOADED" then
        Lieblingsfach_group = AceGUI:Create("SimpleGroup")
        Lieblingsfach_group:SetFullWidth(true)
        Lieblingsfach_group:SetLayout("List")

        local lieblingsfach_heading = AceGUI:Create("Heading")
        lieblingsfach_heading:SetText("Lieblingsfach Sound")
        lieblingsfach_heading:SetFullWidth(true)

        local lieblingsfach_check_box = AceGUI:Create("CheckBox")
        lieblingsfach_check_box:SetFullWidth(true)
        lieblingsfach_check_box:SetLabel("Enable Lieblingsfach Sound")
        lieblingsfach_check_box:SetDescription(
            "If not enabled, no sound will play and no message will be written on !lieblingsfach.")
        lieblingsfach_check_box:SetValue(AMENOVARS.lieblingsfach_enabled)
        lieblingsfach_check_box:SetCallback("OnValueChanged", function()
            AMENOVARS.lieblingsfach_enabled = lieblingsfach_check_box:GetValue()
        end)

        local lieblingsfach_dropdown = AceGUI:Create("Dropdown")
        lieblingsfach_dropdown:SetLabel("Default Player Death Sound")
        lieblingsfach_dropdown:SetList(valid_favourite_subjects)
        lieblingsfach_dropdown:SetValue(AMENOVARS.lieblingsfach)
        lieblingsfach_dropdown:SetCallback("OnValueChanged", function()
            AMENOVARS.lieblingsfach = lieblingsfach_dropdown:GetValue()
            PlaySoundFile(AMENOVARS.lieblingsfach, "Master")
        end)

        Lieblingsfach_group:AddChild(lieblingsfach_heading)
        Lieblingsfach_group:AddChild(lieblingsfach_check_box)
        Lieblingsfach_group:AddChild(lieblingsfach_dropdown)
    end
end)
