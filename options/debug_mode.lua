function generate_debug_mode_gui_elements()
    local debug_mode_group = AceGUI:Create("SimpleGroup")
    debug_mode_group:SetFullWidth(true)
    debug_mode_group:SetLayout("List")

    local debug_mode_heading = AceGUI:Create("Heading")
    debug_mode_heading:SetText("Debug")
    debug_mode_heading:SetFullWidth(true)

    local debug_mode_check_box = AceGUI:Create("CheckBox")
    debug_mode_check_box:SetFullWidth(true)
    debug_mode_check_box:SetLabel("Enable Debug Mode")
    debug_mode_check_box:SetDescription("Output debug messages to console.")
    debug_mode_check_box:SetValue(AMENOVARS.debug_mode)
    debug_mode_check_box:SetCallback("OnValueChanged", function()
        AMENOVARS.debug_mode = debug_mode_check_box:GetValue()
    end)

    debug_mode_group:AddChild(debug_mode_heading)
    debug_mode_group:AddChild(debug_mode_check_box)

    return debug_mode_group
end

