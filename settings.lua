local addonName = ...

-- subscribe to events
local eventFrame = CreateFrame("Frame", event, InterfaceOptionsFramePanelContainer)
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_LOGOUT")

-- If new subject is added, the parameter of the random() function during amenovars initiation has to be adapted to the number of items in this list
favouriteSubjects = {'Englisch', 'Turnen', 'Mathe', 'Musik', 'Kunst'}

--Create Dropdown
--OPTS:
--  name(string): Name of the dropdown (lowercase)
-- parent (Frame): Parent frame of the dropdown
-- items (Table): String table of the dropdown options
-- defaultVal (String): String value for the dropdown to default to (empty otherwise)
-- changeFunc (Function): A custom function to be called, after selecting a dropdown option
-- source: https://jordanbenge.medium.com/creating-a-wow-dropdown-menu-in-pure-lua-db7b2f9c0364
-- TODO: Put this in a lib
local function createDropdown(opts)
    local dropdown_name = '$parent_' .. opts['name'] .. '_dropdown'
    local menu_items = opts['items'] or {}
    local title_text = opts['title'] or ''
    local dropdown_width = 0
    local default_val = opts['defaultVal'] or ''
    local change_func = opts['changeFunc'] or fuction(dropdown_val) 


    local dropdown = CreateFrame("Frame", nil, opts['parent'], 'UIDropDownMenuTemplate')
    local dd_title = dropdown:CreateFontString(dropdown, 'OVERLAY','GameFontNormal')
    dd_title:SetPoint("TOPLEFT",20,10)

    for _, item in pairs(menu_items) do --Sets the dropdown width to the largeest item string width
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
            info.text = val;
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
eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
    --Addon is loaded, vars are ready
    if (loadedAddon == addonName and event == "ADDON_LOADED") then
        --initiate amenovars, if first login
        if type(AMENOVARS) ~= "table" then
            --random from 1 to number of items in favouriteSubjects -> needs to be changed manually if more items in the favouriteSubjects list
            AMENOVARS = {lieblingsfach=favouriteSubjects[math.random(5)]}
        end

        --create global lieblingsfach
        _lieblingsfach = AMENOVARS.lieblingsfach
        

        -- create interface options panel
        local panel = CreateFrame("FRAME", "ExamplePanel");
        panel.name = "ameno";
        local title = panel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
        title:SetPoint("TOP",0,-10)
        title:SetText("AMENO")
        
        -- tbi
        panel.okay = function(self)
        end
        
        --dropdown menu options
        local lieblingsfachDropDownOpts = {
            ['name'] = 'lieblingsfach',
            ['parent']=panel,
            ['title']='Lieblingsfach',
            ['items'] = favouriteSubjects,
            ['defaultVal']=_lieblingsfach,
            ['changeFunc']= function(_, dropdown_val)
                _lieblingsfach = dropdown_val
            end 
        }
        
        --create dropdownmenu and put it in place
        lieblingsfachDropDown = createDropdown(lieblingsfachDropDownOpts)
        lieblingsfachDropDown:SetPoint("TOPLEFT",0,-50);

        -- add panel to interface options
        InterfaceOptions_AddCategory(panel);
    
    --SAVE VARS
    elseif( event == "PLAYER_LOGOUT") then
        AMENOVARS.lieblingsfach = _lieblingsfach
    end
end)