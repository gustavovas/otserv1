function onUse(cid, item, fromPosition, itemEx, toPosition) 
	local days = 3
	addAutoLootDays(cid, days)
	doSendMagicEffect(getCreaturePosition(cid), 29)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"You received "..days.." days of AutoLoot, you have "..getAutoLootDays(cid).." auto loot days.")
	doRemoveItem(item.uid)
	return true
end