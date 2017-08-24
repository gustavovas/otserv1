function onStepIn(cid, item, position, fromPosition, param, words)
playername = getPlayerName(cid)
message = 'Victori! Thougit the new teleporter into the next room.'
status = getPlayerStorageValue(cid,5064)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,5064,1)

end