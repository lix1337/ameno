pull_timers = {
    ["monte_full_correct"] = "Monte 10-0 Correct",
    ["monte_full_wrong"] = "Monte 10-0 Wrong",
    ["monte_half_wrong"] = "Monte 10-5 Wrong"
}

function generate_pull_timer_gui_elements()
    local pull_timer_group = AceGUI:Create("SimpleGroup")
    pull_timer_group:SetFullWidth(true)
    pull_timer_group:SetLayout("List")

    local pull_timer_heading = AceGUI:Create("Heading")
    pull_timer_heading:SetText("Pull Timer Sound")
    pull_timer_heading:SetFullWidth(true)

    local enable_pull_timer_sounds_checkbox = AceGUI:Create("CheckBox")
    enable_pull_timer_sounds_checkbox:SetFullWidth(true)
    enable_pull_timer_sounds_checkbox:SetLabel("Enable Pull Timer Sounds")
    enable_pull_timer_sounds_checkbox:SetDescription("Play custom pull timer sounds on DBM or BigWigs pull.")
    enable_pull_timer_sounds_checkbox:SetValue(AMENOVARS.play_pull_timer_sounds)
    enable_pull_timer_sounds_checkbox:SetCallback("OnValueChanged", function()
        AMENOVARS.play_pull_timer_sounds = enable_pull_timer_sounds_checkbox:GetValue()
    end)

    local pull_timer_dropdown = AceGUI:Create("Dropdown")
    pull_timer_dropdown:SetLabel("Select Pull Timer")
    pull_timer_dropdown:SetList(pull_timers)
    pull_timer_dropdown:SetValue(AMENOVARS.pull_timer)
    pull_timer_dropdown:SetCallback("OnValueChanged", function()
        AMENOVARS.pull_timer = pull_timer_dropdown:GetValue()
    end)

    pull_timer_group:AddChild(pull_timer_heading)
    pull_timer_group:AddChild(enable_pull_timer_sounds_checkbox)
    pull_timer_group:AddChild(pull_timer_dropdown)

    return pull_timer_group
end
