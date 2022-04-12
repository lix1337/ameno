local variables_loaded_frame = CreateFrame("FRAME")
variables_loaded_frame:RegisterEvent("VARIABLES_LOADED")
variables_loaded_frame:SetScript("OnEvent", function(self, event)
    if event == "VARIABLES_LOADED" then
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
end)
