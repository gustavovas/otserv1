function onStepIn(cid, item, position, fromPosition, param, words)
message = 'You have absorved the spirit of Apocalypse, Total Destruction.'
status = getPlayerStorageValue(cid,4066)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4066,1)

end