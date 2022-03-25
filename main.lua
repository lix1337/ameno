local debug = false
local LSM = LibStub("LibSharedMedia-3.0") 

--Spieler sounds
LSM:Register("sound", "Ameno: Table_Smash", [[Interface\Addons\ameno\sound\tableSmash.ogg]])

--Pizzeria am Rewemarkt
LSM:Register("sound", "Ameno: Brafwursigehaeck", [[Interface\Addons\ameno\sound\brafwursigehaeck.ogg]]) 
LSM:Register("sound", "Ameno: Hahnclieri", [[Interface\Addons\ameno\sound\hahnclieri.ogg]]) 

--montanablack
LSM:Register("sound", "Ameno: Montanablack10", [[Interface\Addons\ameno\sound\montanablack_10.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack09", [[Interface\Addons\ameno\sound\montanablack_09.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack08", [[Interface\Addons\ameno\sound\montanablack_08.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack06", [[Interface\Addons\ameno\sound\montanablack_06.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack07", [[Interface\Addons\ameno\sound\montanablack_07.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack sechs sieben Digga wer Bruder", [[Interface\Addons\ameno\sound\montanablack_6_7_diggaWerBruder.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack05", [[Interface\Addons\ameno\sound\montanablack_05.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack04", [[Interface\Addons\ameno\sound\montanablack_04.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack03", [[Interface\Addons\ameno\sound\montanablack_03.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack02", [[Interface\Addons\ameno\sound\montanablack_02.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack01", [[Interface\Addons\ameno\sound\montanablack_01.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack Bruder", [[Interface\Addons\ameno\sound\montanablack_bruder.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack Ende", [[Interface\Addons\ameno\sound\montanablack_ende.ogg]]) 
LSM:Register("sound", "Ameno: Montanablack Digga wer Bruder", [[Interface\Addons\ameno\sound\montanablack_diggaWerBruder.ogg]]) 

--other stuff
LSM:Register("sound", "Ameno: World_First", [[Interface\Addons\ameno\sound\worldFirst.ogg]]) 




--AOTC Jailer play sound
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