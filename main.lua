local debug = false
local LSM = LibStub("LibSharedMedia-3.0") 

--ameno
LSM:Register("sound", "Ameno: Ameno male", [[Interface\Addons\ameno\sound\ameno_male.ogg]])
LSM:Register("sound", "Ameno: Ameno female", [[Interface\Addons\ameno\sound\ameno_female.ogg]])
LSM:Register("sound", "Ameno: Ameno Melodie no beat", [[Interface\Addons\ameno\sound\ameno_melodie_noBeat.ogg]])

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

--lieblingsfach
LSM:Register("sound", "Ameno: Lieblingsfach Englisch", [[Interface\Addons\ameno\sound\lieblingsfach_englisch.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Turnen", [[Interface\Addons\ameno\sound\lieblingsfach_turnen.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Turnen", [[Interface\Addons\ameno\sound\lieblingsfach_kunst.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Turnen", [[Interface\Addons\ameno\sound\lieblingsfach_musik.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Turnen", [[Interface\Addons\ameno\sound\lieblingsfach_mathe.ogg]]) 
LSM:Register("sound", "Ameno: Was ist dein Lieblingsfach", [[Interface\Addons\ameno\sound\lieblingsfach_wasIstDeinLiebslingsfach.ogg]]) 

--other stuff
LSM:Register("sound", "Ameno: World_First", [[Interface\Addons\ameno\sound\worldFirst.ogg]]) 

--background
LSM:Register("background", "Carlos Matos", [[Interface\Addons\ameno\background\carlosMatos.tga]])

--music
LSM:Register("sound", "Geil, Geil, Geil", [[Interface\Addons\ameno\sound\geilgeilgeil.ogg]])


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


local function chatCheck(self, event, ...)
    local text = ...

    if(text == "!lieblingsfach") then
        path = "Interface\\Addons\\ameno\\sound\\lieblingsfach_" .. string.lower(_lieblingsfach) .. ".ogg"
        PlaySoundFile(path,"Master")
        message = _lieblingsfach .. " ist mein Lieblingsfach!"
        SendChatMessage(message, "raid")
    end
end

local frameChat = CreateFrame("frame")
frameChat:RegisterEvent("CHAT_MSG_RAID_LEADER")
frameChat:SetScript("OnEvent", chatCheck)
