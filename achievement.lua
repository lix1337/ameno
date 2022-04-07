local frame = CreateFrame("frame")
frame:RegisterEvent("ACHIEVEMENT_EARNED")
frame:SetScript("OnEvent", checkForAotcJailer)

local function checkForAotcJailer(self, event, ...)
    if (... == 15470) then -- AOTC Jailer
        PlaySoundFile("Interface\\Addons\\ameno\\sound\\worldFirst.ogg", "Master")
    end
end
