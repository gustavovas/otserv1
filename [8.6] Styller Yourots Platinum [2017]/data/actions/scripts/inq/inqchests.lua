function onUse(cid, item, fromPosition, itemEx, toPosition)
   	if item.uid == 14000 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found robe of the underworld.")
   			doPlayerAddItem(cid,8890,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 14001 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a  Spellbook of Dark Mysteries.")
   			doPlayerAddItem(cid,8918,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
   	elseif item.uid == 14002 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Fireborn Giant Armor.")
   			doPlayerAddItem(cid,8881,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
		end
   	elseif item.uid == 14003 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Master Archer's Armor.")
   			doPlayerAddItem(cid,8888,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
  	elseif item.uid == 14004 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Royal Crossbow.")
   			doPlayerAddItem(cid,8851,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	elseif item.uid == 14005 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Hellforged Axe.")
   			doPlayerAddItem(cid,8924,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	elseif item.uid == 14006 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Obsidian Truncheon.")
   			doPlayerAddItem(cid,8928,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	elseif item.uid == 14007 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Emerald Sword.")
   			doPlayerAddItem(cid,8930,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	elseif item.uid == 14008 then
		queststatus = getPlayerStorageValue(cid,50301)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found a Warsinger Bow.")
   			doPlayerAddItem(cid,8854,1)
   			setPlayerStorageValue(cid,50301,1)
   		else
   			doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
   		end
	end
   	return 1
end