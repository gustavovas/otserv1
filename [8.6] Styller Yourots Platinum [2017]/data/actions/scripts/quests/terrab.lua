-- annihilator chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 5882 then
   		queststatus = getPlayerStorageValue(cid,9990)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a terra boots.")
   			doPlayerAddItem(cid,7886,1)
   			setPlayerStorageValue(cid,9990,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
       	end
	else
		return 0
   	end

   	return 1
end	
	

