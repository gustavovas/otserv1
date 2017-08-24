function onStepIn(cid, item, position, fromPosition, param, words)
playername = getPlayerName(cid)
message = 'You have absorved the spirit of Tafariel, the Mistress of the Damned.'
status = getPlayerStorageValue(cid,4062)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4062,1)

end