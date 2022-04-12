local function ShowSettingsMenu()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Ameno Addon Settings")
    frame:SetStatusText("Ameno Addon Settings")
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    frame:SetLayout("List")

    frame:AddChild(generate_death_sound_gui_elements())
    frame:AddChild(generate_gesu_gui_elements())
    frame:AddChild(generate_lieblingsfach_gui_elements())
    frame:AddChild(generate_debug_mode_gui_elements())
end

-- Show settings window on command
SLASH_AMENO1 = "/ameno"
SlashCmdList["AMENO"] = function(msg)
    ShowSettingsMenu()
end
