function onSay(cid, words, param)

if getGlobalStorageValue(battlefield.storage) ~= -1 then
	doPlayerSendCancel(cid, "The event is already open.")
	return true
elseif not tonumber(param) or param % 2 ~= 0 then
	doPlayerSendCancel(cid, "You must choose an even number.")
	return true
end

doBroadcastMessage("The event BattleField was opened and We are waiting "..param.." Players! Team divided into "..((param)/2).." VS "..((param)/2))
setGlobalStorageValue(battlefield.storage, tonumber(param))
local tp = doCreateItem(1387, 1, battlefield.tpPos)
doItemSetAttribute(tp, "aid", 45000)

return true
end