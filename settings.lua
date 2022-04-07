-- subscribe to events
local frame = CreateFrame("Frame", event, InterfaceOptionsFramePanelContainer)
frame:RegisterEvent("ADDON_LOADED")

local function createDropdown(opts)
    local dropdown_name = '$parent_' .. opts['name'] .. '_dropdown'
    local menu_items = opts['items'] or {}
    local title_text = opts['title'] or ''
    local dropdown_width = 0
    local default_val = opts['defaultVal'] or ''
    local change_func = opts['changeFunc'] or fuction(dropdown_val)

    local dropdown = CreateFrame("Frame", nil, opts['parent'], 'UIDropDownMenuTemplate')
    local dd_title = dropdown:CreateFontString(dropdown, 'OVERLAY', 'GameFontNormal')
    dd_title:SetPoint("TOPLEFT", 20, 10)

    for _, item in pairs(menu_items) do -- Sets the dropdown width to the largeest item string width
        dd_title:SetText(item)
        local text_width = dd_title:GetStringWidth() + 20
        if text_width > dropdown_width then
            dropdown_width = text_width
        end
    end

    UIDropDownMenu_SetWidth(dropdown, dropdown_width)
    UIDropDownMenu_SetText(dropdown, default_val)
    dd_title:SetText(title_text)

    UIDropDownMenu_Initialize(dropdown, function(self, level, _)
        local info = UIDropDownMenu_CreateInfo()
        for key, val in pairs(menu_items) do
            info.text = val
            if val == _lieblingsfach then
                info.checked = true
            else
                info.checked = false
            end
            info.menuList = key
            info.hasArrow = false
            info.func = function(b)
                UIDropDownMenu_SetSelectedValue(dropdown, b.value, b.value)
                UIDropDownMenu_SetText(dropdown, b.value)
                b.checked = true
                change_func(dropdown, b.value)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)
    return dropdown
end

-- called when event is fired
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    -- Addon is loaded, vars are ready
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

        -- dropdown menu options
        local lieblingsfachDropDownOpts = {
            ['name'] = 'lieblingsfach',
            ['parent'] = panel,
            ['title'] = 'Lieblingsfach',
            ['items'] = favorite_subjects,
            ['defaultVal'] = AMENOVARS.lieblingsfach,
            ['changeFunc'] = function(_, dropdown_val)
                AMENOVARS.lieblingsfach = dropdown_val
            end
        }

        -- create dropdownmenu and put it in place
        lieblingsfachDropDown = createDropdown(lieblingsfachDropDownOpts)
        lieblingsfachDropDown:SetPoint("TOPLEFT", 0, -50)

        local deathSoundDropDownOpts = {
            ['name'] = 'deathsound',
            ['parent'] = panel,
            ['title'] = 'Deathsound',
            ['items'] = valid_death_sounds,
            ['defaultVal'] = AMENOVARS.my_death_sound,
            ['changeFunc'] = function(_, dropdown_val)
                AMENOVARS.my_death_sound = dropdown_val
                C_ChatInfo.SendAddonMessage("ameno", AMENOVARS.my_death_sound, "RAID")
            end
        }

        deathSoundDropDown = createDropdown(deathSoundDropDownOpts)
        deathSoundDropDown:SetPoint("TOPLEFT", 0, -100)

        -- add panel to interface options
        InterfaceOptions_AddCategory(panel)
    end
end)
