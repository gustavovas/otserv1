function onLogin(cid)
local limit,days = 4,360
function CheckMcManager(cid)
local count,on = 0,getPlayersOnline()
        if #on > 0 then
for i = 1, #on do
                if getCreatureName(on[i]) == "Account Manager" and getPlayerIp(on[i]) == getPlayerIp(cid) then
count = count + 1
end
end
                if count > limit then
doAddIpBanishment(getPlayerIp(cid), days * 24 * 60 * 60)
doRemoveCreature(cid)
end
                end
return true
end
addEvent(CheckMcManager, 1000, cid)
return true
end