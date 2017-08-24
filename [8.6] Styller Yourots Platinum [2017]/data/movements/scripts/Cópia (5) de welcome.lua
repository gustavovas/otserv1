----- Script by ManoX ----
function onStepIn(cid, item, position, fromPosition)
---- Config ----
status = getPlayerStorageValue(cid,1234)
msg1 = "Welcome ViP City"
----------------

if item.actionid == 4321 and status == 0 then
doPlayerSendTextMessage(cid, 22, msg3)
setPlayerStorageValue(cid,1234,1)
else
doPlayerSendTextMessage(cid, 22, msg1)
setPlayerStorageValue(cid,1234,0)

end
end