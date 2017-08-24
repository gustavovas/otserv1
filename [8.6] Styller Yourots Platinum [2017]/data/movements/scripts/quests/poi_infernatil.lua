function onStepIn(cid, item, position, fromPosition, param, words)
playername = getPlayerName(cid)
message = 'You have absorved the spirit of Infernatil, the Incendiary of Hell.'
status = getPlayerStorageValue(cid,4060)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4060,1)

end