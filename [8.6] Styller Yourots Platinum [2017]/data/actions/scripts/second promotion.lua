function onUse(cid, item, frompos, item2, topos)


local config = {
pz = "yes", -- players precisam estar em protection zone para usar? ("yes" or "no").
battle = "yes", -- players deve estar sem battle ("yes" or "no")
pos = {x=320, y=702, z=7}
}


if(config.pz == "yes") and (getTilePzInfo(getCreaturePosition(cid)) == FALSE) then
doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT,"You need to be able to teleport protection zone.")
return TRUE
end

if(config.battle == "yes") and (getCreatureCondition(cid, CONDITION_INFIGHT) == TRUE) then
doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You need to be able to teleport without battle.")
return TRUE
end

if item.itemid == 5785 then
doPlayerSendTextMessage(cid,22,"Welcome to City VIP! You can know it will, but if it dies, return to Blood City!")
doPlayerRemoveItem(cid, 5785, 1)
doTeleportThing(cid,config.pos)
doSendMagicEffect(getCreaturePosition(cid), 10)
doSendMagicEffect(frompos,6)
end
return 1
end