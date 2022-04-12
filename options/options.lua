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

-- Add button to interface options which opens the settings
local frame = CreateFrame("Frame", event, InterfaceOptionsFramePanelContainer)
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if (loadedAddon == addon_name and event == "ADDON_LOADED") then
        local panel = CreateFrame("Frame", nil, UIParent)
        panel.name = "Ameno"
        InterfaceOptions_AddCategory(panel)

        local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        button:SetPoint("CENTER", 0, 0)
        button:SetWidth(100)
        button:SetHeight(25)
        button:SetText("Open Settings")
        button:SetScript("OnClick", function()
            ShowSettingsMenu()
        end)
    end
end)

-- Show settings window on command
SLASH_AMENO1 = "/ameno"
SlashCmdList["AMENO"] = function(msg)
    ShowSettingsMenu()
end

