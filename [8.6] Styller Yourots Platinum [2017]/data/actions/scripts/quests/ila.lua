function onUse(cid, item, frompos, item2, topos)

	if item.uid == 5400 then
 	queststatus = getPlayerStorageValue(cid,5010)
 	if queststatus == -1 then
 	doPlayerSendTextMessage(cid,22,"You have found a heroic axe.")
 	doPlayerAddItem(cid,7389,1)
 	setPlayerStorageValue(cid,5010,1)
 	else
 	doPlayerSendTextMessage(cid,22,"It is empty.")
	end
	else
	return 0
	end
	
	return 1