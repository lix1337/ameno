local debug = false
local LSM = LibStub("LibSharedMedia-3.0") 

LSM:Register("sound", "Ameno: Table_Smash", [[Interface\Addons\ameno\sound\tableSmash.ogg]])
LSM:Register("sound", "Ameno: Brafwursigehaeck", [[Interface\Addons\ameno\sound\brafwursigehaeck.ogg]]) --1:13
LSM:Register("sound", "Ameno: Hahnclieri", [[Interface\Addons\ameno\sound\hahnclieri.ogg]]) --1:31
LSM:Register("sound", "Ameno: World_First", [[Interface\Addons\ameno\sound\worldFirst.ogg]]) --1:31





local function checkForAotcJailer(self, event, ...)
    if(debug) then
        if(... == 1157) then    -- duelicious for debug
            PlaySoundFile("Interface\\Addons\\ameno\\sound\\worldFirst.ogg","Master")
        end    
    end

    if(... == 15470) then -- AOTC Jailer
        PlaySoundFile("Interface\\Addons\\ameno\\sound\\worldFirst.ogg","Master")
    end    
end

local frameJailerAv = CreateFrame("frame")
frameJailerAv:RegisterEvent("ACHIEVEMENT_EARNED")
frameJailerAv:SetScript("OnEvent", checkForAotcJailer)



-- Chat check for later development, if a group or raid chat shall be parsed
--[[local function chatCheck(self, event, ...)
    local text = ...

    if(text == "p") then
        --do stuff
    end

end

frameChat:RegisterEvent("CHAT_MSG_PARTY")
frameChat:RegisterEvent("CHAT_MSG_PARTY_LEADER")
frameChat:SetScript("OnEvent", chatCheck)
]]--