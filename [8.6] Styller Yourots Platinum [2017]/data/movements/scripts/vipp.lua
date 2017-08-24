function onStepIn(cid, item, pos)

novapos1 = {x=295, y=24, z=7}
backpos = {x=295, y=24, z=7}
msg = ""

if isPlayer(cid) then actionid == 5955 then
doSendMagicEffect(cid,2)
doTeleportThing(cid,novapos1)
doSendMagicEffect(novapos1,10)
else
doTeleportThing(cid,backpos)
doPlayerSendTextMessage(cid, 22, msg)
end

end