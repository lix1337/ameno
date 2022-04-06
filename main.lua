local debug = false
local LSM = LibStub("LibSharedMedia-3.0") 

--ameno
LSM:Register("sound", "Ameno: Ameno male", [[Interface\Addons\ameno\sound\ameno_male.ogg]])
LSM:Register("sound", "Ameno: Ameno female", [[Interface\Addons\ameno\sound\ameno_female.ogg]])
LSM:Register("sound", "Ameno: Ameno Melodie no beat", [[Interface\Addons\ameno\sound\ameno_melodie_noBeat.ogg]])

--Spieler sounds
LSM:Register("sound", "Ameno: Table Smash", [[Interface\Addons\ameno\sound\tableSmash.ogg]])
LSM:Register("sound", "Ameno: Ach der Toni", [[Interface\Addons\ameno\sound\ach_der_toni.ogg]])

--Pizzeria am Rewemarkt
LSM:Register("sound", "Ameno: Brafwursigehaeck", [[Interface\Addons\ameno\sound\brafwursigehaeck.ogg]]) 
LSM:Register("sound", "Ameno: Hahnclieri", [[Interface\Addons\ameno\sound\hahnclieri.ogg]]) 

--Monte
LSM:Register("sound", "Ameno: Monte10", [[Interface\Addons\ameno\sound\mb_10.ogg]]) 
LSM:Register("sound", "Ameno: Monte09", [[Interface\Addons\ameno\sound\mb_09.ogg]]) 
LSM:Register("sound", "Ameno: Monte08", [[Interface\Addons\ameno\sound\mb_08.ogg]]) 
LSM:Register("sound", "Ameno: Monte06", [[Interface\Addons\ameno\sound\mb_06.ogg]]) 
LSM:Register("sound", "Ameno: Monte07", [[Interface\Addons\ameno\sound\mb_07.ogg]]) 
LSM:Register("sound", "Ameno: Monte sechs sieben Digga wer Bruder", [[Interface\Addons\ameno\sound\mb_6_7_diggaWerBruder.ogg]]) 
LSM:Register("sound", "Ameno: Monte05", [[Interface\Addons\ameno\sound\mb_05.ogg]]) 
LSM:Register("sound", "Ameno: Monte04", [[Interface\Addons\ameno\sound\mb_04.ogg]]) 
LSM:Register("sound", "Ameno: Monte03", [[Interface\Addons\ameno\sound\mb_03.ogg]]) 
LSM:Register("sound", "Ameno: Monte02", [[Interface\Addons\ameno\sound\mb_02.ogg]]) 
LSM:Register("sound", "Ameno: Monte01", [[Interface\Addons\ameno\sound\mb_01.ogg]]) 
LSM:Register("sound", "Ameno: Monte Bruder", [[Interface\Addons\ameno\sound\mb_bruder.ogg]]) 
LSM:Register("sound", "Ameno: Monte Ende", [[Interface\Addons\ameno\sound\mb_ende.ogg]]) 
LSM:Register("sound", "Ameno: Monte Digga wer Bruder", [[Interface\Addons\ameno\sound\mb_diggaWerBruder.ogg]]) 

--lieblingsfach
LSM:Register("sound", "Ameno: Lieblingsfach Englisch", [[Interface\Addons\ameno\sound\lieblingsfach_englisch.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Turnen", [[Interface\Addons\ameno\sound\lieblingsfach_turnen.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Kunst", [[Interface\Addons\ameno\sound\lieblingsfach_kunst.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Musik", [[Interface\Addons\ameno\sound\lieblingsfach_musik.ogg]]) 
LSM:Register("sound", "Ameno: Lieblingsfach Mathe", [[Interface\Addons\ameno\sound\lieblingsfach_mathe.ogg]]) 
LSM:Register("sound", "Ameno: Was ist dein Lieblingsfach", [[Interface\Addons\ameno\sound\lieblingsfach_wasIstDeinLiebslingsfach.ogg]]) 

--other stuff
LSM:Register("sound", "Ameno: World First", [[Interface\Addons\ameno\sound\worldFirst.ogg]]) 

--music
LSM:Register("sound", "Ameno: Geil, Geil, Geil", [[Interface\Addons\ameno\sound\geilgeilgeil.ogg]])

--background
LSM:Register("background", "Carlos Matos", [[Interface\Addons\ameno\background\carlosMatos.tga]])


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

-- Play sound on player death
local deathFrame = CreateFrame("FRAME")
deathFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

deathFrame:SetScript("OnEvent", function(self, event)
    self:OnEvent(event, CombatLogGetCurrentEventInfo())
end)

function deathFrame:OnEvent(self, ...)
    local _, subevent, _, _, _, _, _, _, destName, _, _, _, _ = ...

    if subevent == "UNIT_DIED" and (UnitInRaid(destName) or UnitInParty(destName)) then
        if string.find(destName, "-") then
            local minusIndex = string.find(destName, "-") - 1
            destName = string.sub(destName, 1, minusIndex)
        end
        
        local isFeign = UnitIsFeignDeath(destName)
        if isFeign == false then
            if (destName == "Testotôni") then
                PlaySoundFile("Interface\\Addons\\ameno\\sound\\ach_der_toni.ogg","Master")
            else
                PlaySoundFile("Interface\\Addons\\ameno\\sound\\tableSmash.ogg","Master")
            end
        end
    end
end