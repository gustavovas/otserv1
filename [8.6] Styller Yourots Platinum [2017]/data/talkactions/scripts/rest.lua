
-- (Sistema para dormir com recuperação automatica) --
-- Criadores: Flaah e Vodkart - Modificado por Bloodwalker --
-- (Não retirem os créditos) --
 
  events = {}
  config = {
  sit = {hp = 100, mana = 100},   -- Hp e mana que ira healar
  storage = 21211
}
 
  function onSay(cid, words, param, channel)
  
  if getTilePzInfo(getThingPos(cid)) == false then
  doPlayerSendCancel(cid, "Voce só pode descansar em protection zone.")
  end
   
  if getTilePzInfo(getThingPos(cid)) == true then
  if getPlayerStorageValue(cid, config.storage) == -1 then
  doCreatureSay(cid,"Rest!", TALKTYPE_ORANGE_1)
  doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE , "Para levantar digite o comando !rest novamente.")
  doSitRelax(cid, config.sit)
  doCreatureSetNoMove(cid, true)
  setPlayerStorageValue(cid, config.storage, 1)
  if(getPlayerSex(cid) == 1)then
  doSetItemOutfit(cid, 2317, -1)
  else
  doSetItemOutfit(cid, 3065, -1)
  end
  
  else
  setPlayerStorageValue(cid, config.storage, -1)
  doCreatureSay(cid,"zzZZzZ..", TALKTYPE_ORANGE_1)
  doRemoveCondition(cid, CONDITION_OUTFIT)
  doCreatureSetNoMove(cid, false)
  stopEvent(events[getPlayerGUID(cid)])
  end
  end
  return true
  end
  function doSitRelax(cid, formula)
  if not isCreature(cid) then return LUA_ERROR end
  doCreatureAddHealth(cid, formula.hp)
  doCreatureAddMana(cid, formula.mana)
  doSendMagicEffect(getCreaturePosition(cid), 32)
  events[getPlayerGUID(cid)] = addEvent(doSitRelax, 3000, cid, formula)
  end