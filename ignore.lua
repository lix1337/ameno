function isPlayerIgnored(name)
    for i=1,C_FriendList.GetNumIgnores(),1 do
        if(C_FriendList.GetIgnoreName(i) == name) then
            return true
        end
    end
    return false
end