function onSay(cid, words, param)
local premium = "yes" -- Apenas players premium accounts "yes" or "no"!?
local battle = "yes"
if battle == "yes" and (getCreatureCondition(cid, CONDITION_INFIGHT) == TRUE) then
doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You need without battle.")
return TRUE
end
if premium == "yes" and not isPremium(cid) then
return doPlayerPopupFYI(cid,"Apenas Premium Account Podem Regenerar Stamina.")
end
if doPlayerRemoveItem(cid,5904,50) then
doPlayerSetStamina(cid,151200000)
doSendMagicEffect(getPlayerPosition(cid), CONST_ME_HOLYAREA)
doPlayerSendTextMessage(cid,25,"Você será kickado em 10 segundos Para regenerar a stamina.")
addEvent(doRemoveCreature, 10*1000, cid, true) 
else
doPlayerSendCancel(cid, 'You dont have 50 magic sulphur.')
doSendMagicEffect(getPlayerPosition(cid), CONST_ME_FIREEAREA)
end
end