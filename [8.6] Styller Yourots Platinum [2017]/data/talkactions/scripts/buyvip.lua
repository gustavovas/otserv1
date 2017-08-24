function onSay(cid, words, param, channel)
   if getPlayerStorageValue(cid, 2700) <= os.time() then
     local kk = os.time()+2
     setPlayerStorageValue(cid, 2700, kk)
       if getPlayerMoney(cid) >= 6000000 then
         if doPlayerAddItem(cid, 5785, 1, false) then
           return doPlayerRemoveMoney(cid, 6000000) and doPlayerSendTextMessage(cid,25,"Use a medalha para obter 7 dias de vip. Congratulations!")
         else
          return doPlayerSendCancel(cid, "You don't have space or cap.") and doSendMagicEffect(getCreaturePosition(cid), 2)
         end
       else
         return doPlayerSendCancel(cid, "You don't have 6kk.") and doSendMagicEffect(getCreaturePosition(cid), 2)
       end
   else
         return doPlayerSendCancel(cid, "You are exhausted.") and doSendMagicEffect(getCreaturePosition(cid), 2)
   end
   return true
end