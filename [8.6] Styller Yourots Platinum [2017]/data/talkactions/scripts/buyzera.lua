function onSay(cid, words, param, channel)
   if getPlayerStorageValue(cid, 2700) <= os.time() then
     local kk = os.time()+2
     setPlayerStorageValue(cid, 2700, kk)
       if getPlayerMoney(cid) >= 10000 then
         if doPlayerAddItem(cid, 2173, 1, false) then
           return doPlayerRemoveMoney(cid, 10000) and doSendMagicEffect(getCreaturePosition(cid), 22)
         else
          return doPlayerSendCancel(cid, "You don't have space or cap.") and doSendMagicEffect(getCreaturePosition(cid), 2)
         end
       else
         return doPlayerSendCancel(cid, "You don't have money.") and doSendMagicEffect(getCreaturePosition(cid), 2)
       end
   else
         return doPlayerSendCancel(cid, "You are exhausted.") and doSendMagicEffect(getCreaturePosition(cid), 2)
   end
   return true
end