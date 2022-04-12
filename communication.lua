death_sound_prefix = "ds"
local send_version_prefix = "sv"
local query_version_prefix = "qv"
local join_prefix = "join"

local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", function(self, event, ...)
    frame_event_callback(event, ...)
end)

function frame_event_callback(event, ...)
    if (event == "CHAT_MSG_ADDON") then
        chat_massage_addon_callback(...)
    end
end

function chat_massage_addon_callback(prefix, message, chatType, sender)
    -- Write all addon chat messages to console if debug mode enabled
    if AMENOVARS.debug_mode then
        print(prefix, message, chatType, sender)
    end

    -- Not ameno addon
    if prefix ~= "ameno" then
        return
    end

    -- Remove realm name
    if string.find(sender, "-") then
        local minusIndex = string.find(sender, "-") - 1
        sender = string.sub(sender, 1, minusIndex)
    end

    -- Someone joined the addon message channel
    if message == join_prefix then
        -- send version
        C_ChatInfo.SendAddonMessage("ameno", send_version_prefix .. amenoversion, "RAID")
        -- send my_death_sound
        C_ChatInfo.SendAddonMessage("ameno", AMENOVARS.death_sound_own, "RAID")
        return
    end

    -- Someone send his death sound
    if string.match(message, death_sound_prefix) then
        local sound = string.sub(message, string.len(death_sound_prefix))
        player_death_sounds_db[sender] = message

        if AMENOVARS.debug_mode then
            print("New death sound of " .. sender .. " is " .. player_death_sounds_db[sender])
        end

        return
    end

    -- Someone send his addon version
    -- Check if the replied version is newer then my own
    if string.match(message, send_version_prefix) then
        if (imWarnedAboutMyOldAssVersion) then
            return
        end

        local version = string.sub(message, string.len(send_version_prefix))

        if (checkIfVersionIsNewer(message) == 1) then
            -- My version is not up to date
            local msg = "A newer version of ameno is available: " .. version ..
                            "\nyou are running the old shit version: " .. amenoversion
            BasicMessageDialog.Text:SetText(msg)
            BasicMessageDialog:Show()
            imWarnedAboutMyOldAssVersion = true
        end
        return
    end
end

-- Execute code on group change (e.g. player joins)
local group_update_frame = CreateFrame("FRAME")
group_update_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
group_update_frame:SetScript("OnEvent", function(self, event)
    if event == "GROUP_ROSTER_UPDATE" then
        -- Notify everyone that i joined the group
        C_ChatInfo.SendAddonMessage("ameno", "join", "RAID")
    end
end)

-- Send join into addon channel on VARIABLES_LOADED
local addon_loaded_frame = CreateFrame("FRAME")
addon_loaded_frame:RegisterEvent("VARIABLES_LOADED")
addon_loaded_frame:SetScript("OnEvent", function(self, event, loaded_addon)
    C_ChatInfo.SendAddonMessage("ameno", join_prefix, "RAID")
end)
