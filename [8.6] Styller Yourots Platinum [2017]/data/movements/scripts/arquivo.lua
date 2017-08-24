function onStepIn(cid, item, pos)

if getPlayerLevel(cid) < 600 and getPlayerAccess(cid) < 1 then
  doPlayerSendCancel(cid,"Only players with level 100 or higher can pass.")
  doSendMagicEffect(pos, 2)
  pos.y = pos.y+1
  doTeleportThing(cid, pos)
  doSendMagicEffect(pos, 2)
end
end