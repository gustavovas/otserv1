function onStepIn(cid, item, position, fromPosition, param, words)
message = 'Victori! Thougit the new teleporter into the next room.'
status = getPlayerStorageValue(cid,5060)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,5060,1)

end