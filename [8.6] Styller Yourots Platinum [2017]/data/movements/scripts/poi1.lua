function onUse(cid, item, frompos, item2, topos)

if item.uid == 5681 then
queststatus = getPlayerStorageValue(cid,4066)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"You have absorved the spirit of Apocalypse, Total Destruction.")
setPlayerStorageValue(cid,4066,1)
else
doPlayerSendTextMessage(cid,22,"You have absorved the spirit of Apocalypse, Total Destruction.")
end
else
return 0
end

return 1
end