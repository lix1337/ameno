-- Versioning check
function checkIfVersionIsNewer(newVersion)
    -- Grab all patch levels
    local messageMajor, messageMinor, messagePatch = string.match(newVersion, "(%d+)%.(%d+)%.(%d+)")
    local myMajor, myMinor, myPatch = string.match(amenoversion, "(%d+)%.(%d+)%.(%d+)")

    -- Put patch levels into tables
    local messageVersions = {tonumber(messageMajor), tonumber(messageMinor), tonumber(messagePatch)}
    local myVersions = {tonumber(myMajor), tonumber(myMinor), tonumber(myPatch)}

    for i = 1, 3, 1 do
        if messageVersions[i] > myVersions[i] then
            return 1
        elseif (myVersions[i] > messageVersions[i]) then
            return -1
        end
    end
    -- Both versions are equal
    return 0
end