function onPrepareDeath(cid, corpse, lastHitKiller, mostDamageKiller)

if getPlayerStorageValue(cid, config_tvt.green_kills) > 0 then
	doTeleportThing(cid, config_tvt.green_pos)
	setGlobalStorageValue(red_kills, getGlobalStorageValue(red_kills) + 1)
end

if getPlayerStorageValue(cid, config_tvt.red_kills) > 0 then
	doTeleportThing(cid, config_tvt.red_pos)
	setGlobalStorageValue(red_kills, getGlobalStorageValue(green_kills) + 1)
end

doPlayerSendTextMessage(cid, 27, "You dead!")

return true
end