function onUse(cid, item, fromPosition, itemEx, toPosition)

   	if item.uid == 15901 then
   		queststatus = getPlayerStorageValue(cid,50091)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found Earthborn Titan Armor.")
   			doPlayerAddItem(cid,8882,1)
   			setPlayerStorageValue(cid,50091,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 15902 then
   		queststatus = getPlayerStorageValue(cid,50091)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Amazon Shield.")
   			doPlayerAddItem(cid,2537,1)
   			setPlayerStorageValue(cid,50091,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 15903 then
   		queststatus = getPlayerStorageValue(cid,50091)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Windborn colossus Armor.")
   			doPlayerAddItem(cid,8883,1)
   			setPlayerStorageValue(cid,50091,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
		end
   	elseif item.uid == 15904 then
   		queststatus = getPlayerStorageValue(cid,50091)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Royal Scale Robe.")
   			doPlayerAddItem(cid,12604,1)
   			setPlayerStorageValue(cid,50091,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end