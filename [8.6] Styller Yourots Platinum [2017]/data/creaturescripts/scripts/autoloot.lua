function onLogin(cid)
	
	if vip.hasVip(cid) and getPlayerStorageValue(cid, 27001) <= 0 then
		setPlayerStorageValue(cid, 27001, 1)
	elseif getPlayerStorageValue(cid, 27001) > 0 and not vip.hasVip(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[Auto Loot] You VIP is Over, Start a new list!")
		setPlayerStorageValue(cid, 27001, -1)
		setPlayerStorageValue(cid, info.Storages[1], -1)
	end
	return true
end
function onKill(cid, target, lastHit) 
	if isPlayer(cid) and getAutoLootDays(cid) > 0 and isMonster(target) then
		addEvent(corpseRetireItems, 0, cid ,getThingPos(target))
	end
	return true
end