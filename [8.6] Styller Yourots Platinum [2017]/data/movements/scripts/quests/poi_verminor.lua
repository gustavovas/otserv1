function onStepIn(cid, item, position, fromPosition, param, words)
message = 'You have absorved the spirit of Verminor, the Plaguelord.'
status = getPlayerStorageValue(cid,4058)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4058,1)

end