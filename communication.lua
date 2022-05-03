death_sound_prefix = "ds"
local send_version_prefix = "sv"
local join_prefix = "join"
local ignored_player_prefix = "ip"

local warned_about_old_version = false

-- Handles if player is in dungeonbrowser-formed group
send_to_channel = IsPartyLFG() and "INSTANCE_CHAT" or "RAID"

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
        send_addon_message(send_version_prefix .. amenoversion)
        -- send my_death_sound
        send_addon_message(death_sound_prefix .. AMENOVARS.death_sound_own)
        return
    end

    -- Someone send his death sound
    if string.match(message, death_sound_prefix) then
        local sound = string.sub(message, string.len(death_sound_prefix) + 1)
        player_death_sounds_db[sender] = sound
        return
    end

    -- Someone send his addon version
    -- Check if the replied version is newer then my own
    if string.match(message, send_version_prefix) then
        if warned_about_old_version then
            return
        end

        local version = string.sub(message, string.len(send_version_prefix) + 1)

        if checkIfVersionIsNewer(message) == 1 then
            -- My version is not up to date
            local msg = "A newer version of ameno is available: " .. version ..
                            "\nyou are running the old shit version: " .. amenoversion
            BasicMessageDialog.Text:SetText(msg)
            BasicMessageDialog:Show()
            warned_about_old_version = true
        end
        return
    end

    -- Someone joined while being on the ignore list of an addon user
    if string.match(message, ignored_player_prefix) then
        local ignoredPlayer = string.sub(message, string.len(ignored_player_prefix) + 1)
        print("|cffFF0000Player " .. ignoredPlayer .. " is ignored by " .. sender)
        return
    end
end

-- Execute code on group change (e.g. player joins)
local group_update_frame = CreateFrame("FRAME")
group_update_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
group_update_frame:SetScript("OnEvent", function(self, event)
    if event == "GROUP_ROSTER_UPDATE" then
        -- Notify everyone that i joined the group
        send_addon_message(join_prefix)
    end
end)

-- Send join into addon channel on VARIABLES_LOADED
local addon_loaded_frame = CreateFrame("FRAME")
addon_loaded_frame:RegisterEvent("VARIABLES_LOADED")
addon_loaded_frame:SetScript("OnEvent", function(self, event, loaded_addon)
    send_addon_message(join_prefix)
end)

-- Send warning that a new joined player is ignored by me
local system_message_frame = CreateFrame("Frame")
system_message_frame:RegisterEvent("CHAT_MSG_SYSTEM")
system_message_frame:SetScript("OnEvent", function(self, event, message)
    local isPlayerInRaid = UnitInRaid("player")
    joinPartyPattern = gsub(ERR_JOINED_GROUP_S, "%%s", "(.+)")
    if (isPlayerInRaid == 1) then
        if (send_to_channel == "RAID") then
            joinPartyPattern = gsub(ERR_RAID_MEMBER_ADDED_S, "%%s", "(.+)")
        else
            joinPartyPattern = gsub(ERR_INSTANCE_GROUP_ADDED_S, "%%s", "(.+)")
        end
    end
    local name = strmatch(message, joinPartyPattern)
    if name then
        if (isPlayerIgnored(name)) then
            send_addon_message(ignored_player_prefix .. name)
        end
    end
end)

function send_addon_message(message)
    local channel = nil

    -- Determine channel to send in
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        channel = "INSTANCE_CHAT"
    elseif IsInRaid() then
        channel = "RAID"
    elseif IsInGroup() then
        channel = "PARTY"
    else
        channel = "SELF"
    end

    if AMENOVARS.debug_mode then
        print("ameno", message, channel)
    end

    C_ChatInfo.SendAddonMessage("ameno", message, channel)
end
