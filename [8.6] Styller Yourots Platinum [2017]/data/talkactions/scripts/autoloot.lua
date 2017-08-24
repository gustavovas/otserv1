function onSay(cid, words, param)
local param, slots = param:lower(), vip.hasVip(cid) and info.Max_Slots.premium or info.Max_Slots.free
if not param or param == "" then
	ShowItemsTabble(cid) return true
elseif tonumber(param) then
	doPlayerSendCancel(cid, "enter commands: !autoloot item name [+] !autoloot clean [+] !autoloot money [+] !autoloot on/off") return true
elseif isInArray({"clean","limpar", "clear"}, param) then
	setPlayerStorageValue(cid, info.storages[1], -1)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"[Auto Loot] Your list has been cleaned.") return true
elseif isInArray({"starttt","stotp","ont","oftf"}, param) then
	setPlayerStorageValue(cid, info.storages[3], getPlayerStorageValue(cid, info.storages[3]) <= 0 and 1 or 0)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"[Auto Loot] "..(getPlayerStorageValue(cid, info.storages[3]) > 0 and "Stopped" or "Started")..".") return true
elseif isInArray({"money","gold","gps","dinheiro"}, param) then
	setPlayerStorageValue(cid, info.storages[2], getPlayerStorageValue(cid, info.storages[2]) <= 0 and 1 or 0)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"[Auto Loot] Gold Colleting "..(getPlayerStorageValue(cid, info.storages[2]) > 0 and "Activated" or "disabled")..".") return true
end
local item = getItemIdByName(param, false)
if not item then
	doPlayerSendTextMessage(cid, MESSAGE_FIRST, "This item does not exist.") return true
end
local var = isInTable(cid, item)
if isInArray({2148,2152,2160},item) then 
	doPlayerSendTextMessage(cid, MESSAGE_FIRST, "Enter !autoloot money to add money in your list!") return true	
elseif isInArray(info.BlockItemsList, item) then
	doPlayerSendTextMessage(cid, MESSAGE_FIRST, "You can not add this item in the list!") return true
elseif not var and #getPlayerStorageTable(cid, info.storages[1]) >= slots then
	doPlayerSendTextMessage(cid, MESSAGE_FIRST, "max "..slots.." from auto loot") return true
end
if not var then
	addItemTable(cid, item)
else
	removeItemTable(cid, item)
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,not var and "you added the item "..param.." in the list" or "you removed the item "..param.." from the list")
return true
end