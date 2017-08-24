function onStepIn(cid, item, position, fromPosition, param, words)

message = 'You have absorved the spirit of Ashfalor, the Right Hand of Urgith. The general of the undead hordes.'

status = getPlayerStorageValue(cid,4064)
	doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, message)
setPlayerStorageValue(cid,4064,1)

end