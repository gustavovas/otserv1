function onStepIn(cid, item, position, fromPosition, param, words)
message = 'You found th Death Catacumbs.'
status = getPlayerStorageValue(cid,4068)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4068,1)

end