function onStepIn(cid, item, position, fromPosition, param, words)
message = 'Welcome Warlord Arena.'
status = getPlayerStorageValue(cid,5002)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,5002,1)

end