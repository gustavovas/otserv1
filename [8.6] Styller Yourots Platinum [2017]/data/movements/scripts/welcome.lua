function onStepIn(cid, item, position, fromPosition, param, words)
playername = getPlayerName(cid)

status = getPlayerStorageValue(cid,8742)
broadcastMessage (""..playername.." completed a Pits of Inferno! ", 19)

setPlayerStorageValue(cid,8742,0)

end