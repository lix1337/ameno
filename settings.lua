-- subscribe to events
local frame = CreateFrame("Frame", event, InterfaceOptionsFramePanelContainer)
frame:RegisterEvent("ADDON_LOADED")

-- called when event is fired
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if (loadedAddon == addon_name and event == "ADDON_LOADED") then
        -- create interface options panel
        local panel = CreateFrame("FRAME", "ExamplePanel")
        panel.name = "ameno"
        local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        title:SetPoint("TOP", 0, -10)
        title:SetText("AMENO")

        -- tbi
        panel.okay = function(self)
        end

        -- add panel to interface options
        InterfaceOptions_AddCategory(panel)
    end
end)
