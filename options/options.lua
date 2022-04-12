local function ShowSettingsMenu()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Ameno Addon Settings")
    frame:SetStatusText("Ameno Addon Settings")
    frame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget)
    end)
    frame:SetLayout("List")

    frame:AddChild(death_sound_group)
    frame:AddChild(chat_command_group)
    frame:AddChild(Lieblingsfach_group)
    frame:AddChild(debug_mode_group)
end

-- Show settings window on command
SLASH_AMENO1 = "/ameno"
SlashCmdList["AMENO"] = function(msg)
    ShowSettingsMenu()
end
