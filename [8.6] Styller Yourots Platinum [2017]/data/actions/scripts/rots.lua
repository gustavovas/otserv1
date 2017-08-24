-- annihilator chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 1750 then
   		queststatus = getPlayerStorageValue(cid,5908)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Legion Helmet.")
   			doPlayerAddItem(cid,2480,1)
   			setPlayerStorageValue(cid,5908,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
       	end
	else
		return 0
   	end

   	return 1
end	
	

