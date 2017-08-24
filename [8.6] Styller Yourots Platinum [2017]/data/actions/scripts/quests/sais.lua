-- annihilator chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 9710 then
   		queststatus = getPlayerStorageValue(cid,9157)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a sais.")
   			doPlayerAddItem(cid,11299,1)
   			setPlayerStorageValue(cid,9157,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
       	end
	else
		return 0
   	end

   	return 1
end	
	

