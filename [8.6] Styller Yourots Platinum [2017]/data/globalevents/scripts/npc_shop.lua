function onThink(cid, interval, lastExecution)
local query = db.getResult("SELECT `id`, `player_id`, `item_id`, `count` FROM `shop_npc` WHERE `date` < "..os.time() - _config_npc_shop.days_limit*24*60*60)
if (query:getID() ~= -1) then
repeat
local item,amount,name = query:getDataInt("item_id"),query:getDataInt("count"),getPlayerByShopID(query:getDataInt("id"))
local player = getPlayerByNameWildcard(name)
if player then
local parcel = doCreateItemEx(ITEM_PARCEL)
if isItemStackable(item) or amount == 1 then
doAddContainerItem(parcel, item, amount)
else
for i = 1, amount do
doAddContainerItem(parcel, item, 1)
end
end
doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE,"[Npc Auction] Were returned "..amount.." "..getItemNameById(item).." from your depot.")
doPlayerSendMailByName(name, parcel, 1)
else
if isItemStackable(item) or amount == 1 then
doPlayerAddDepotItem(query:getDataInt("player_id"), item, amount)
else
for i = 1, amount do
doPlayerAddDepotItem(query:getDataInt("player_id"), item, 1)
end
end
local file = io.open(OfflineMessagesConfig.messageSavingDirectory .. name .. '.Gandhi', 'a+')
local msgfrom, msgoff = "[Npc Auction]",{"Were returned "..amount.." "..getItemNameById(item).." from your depot."}
file:write(OfflineMessagesConfig.messageFormatString:format(os.date(OfflineMessagesConfig.dateFormatString), msgfrom, table.concat(msgoff, OfflineMessagesConfig.separatorAfterNickname)) .. '\n')
file:close()
end
doDeleteShopItem(query:getDataInt("id")) 
until not query:next()
query:free()
end
return true
end  