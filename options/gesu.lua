function generate_gesu_gui_elements()
    local gesu_group = AceGUI:Create("SimpleGroup")
    gesu_group:SetFullWidth(true)
    gesu_group:SetLayout("List")

    local gesu_heading = AceGUI:Create("Heading")
    gesu_heading:SetText("Gesu")
    gesu_heading:SetFullWidth(true)

    local react_to_gesu_checkbox = AceGUI:Create("CheckBox")
    react_to_gesu_checkbox:SetFullWidth(true)
    react_to_gesu_checkbox:SetLabel("React to !gesu Command")
    react_to_gesu_checkbox:SetDescription("If enabled, respond to !gesu command with message.")
    react_to_gesu_checkbox:SetValue(AMENOVARS.react_to_gesu)
    react_to_gesu_checkbox:SetCallback("OnValueChanged", function()
        AMENOVARS.react_to_gesu = react_to_gesu_checkbox:GetValue()
    end)

    local gesu_message_edit_box = AceGUI:Create("EditBox")
    gesu_message_edit_box:SetFullWidth(true)
    gesu_message_edit_box:SetLabel("!gesu React Massage")
    gesu_message_edit_box:SetText(AMENOVARS.gesu_message)
    gesu_message_edit_box:SetCallback("OnEnterPressed", function()
        AMENOVARS.gesu_message = gesu_message_edit_box:GetText()
    end)

    local gesu_sound_check_box = AceGUI:Create("CheckBox")
    gesu_sound_check_box:SetFullWidth(true)
    gesu_sound_check_box:SetLabel("Play sound on !gesu command")
    gesu_sound_check_box:SetDescription("If enabled, play a sound when !gesu was written in chat.")
    gesu_sound_check_box:SetValue(AMENOVARS.gesu_sound)
    gesu_sound_check_box:SetCallback("OnValueChanged", function()
        AMENOVARS.gesu_sound = gesu_sound_check_box:GetValue()
    end)

    gesu_group:AddChild(gesu_heading)
    gesu_group:AddChild(react_to_gesu_checkbox)
    gesu_group:AddChild(gesu_message_edit_box)
    gesu_group:AddChild(gesu_sound_check_box)

    return gesu_group
end
