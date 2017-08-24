function onUse(cid, item, frompos, item2, topos)
   if getPlayerStorageValue(cid, 11139) < 1 then
      setPlayerStorageValue(cid, 11139, 1)
doSendMagicEffect(getPlayerPosition(cid), math.random(28,30)) 
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You can open the magic door! grrrrr!.")
      doRemoveItem(item.uid, 1)
   end
   return true
end