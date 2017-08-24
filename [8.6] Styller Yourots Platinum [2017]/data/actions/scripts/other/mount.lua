--[(MountSystem1.4 created byMatheus)]--
function onUse(cid, item)

local outfit = {lookType = 342} -- Outfit da montaria!
local exhaust = 60 -- Tempo para player poder usar o item novamente! (tempo em segundos)
local time = 60 -- Tempo para ficar na montaria! (tempo em segundos)
local speed = 300 -- Velocidade adicionada ao player após usar o item! (300 = velocidade, quanto maior mais rapido...)
local mana = 600 -- Quantidade de mana que o player necessita para usar o sistema!
local premium = "yes" -- Apenas players premium accounts "yes" or "no"!?
local storage = 9393 -- Não mexa aqui!

if premium == "yes" and not isPremium(cid) then
return doPlayerSendTextMessage(cid, 23, "Sorry, only premium players.")
end

if(getCreatureMana(cid) < mana) then
return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTENOUGHMANA)
end

if (getPlayerStorageValue(cid, storage) <= os.time()) then
doCreatureSay(cid, "Yeeeah!!!\nYou went up on his ride.", 19)
doSetCreatureOutfit(cid, outfit, time*1000)
doChangeSpeed(cid, speed)
doSendMagicEffect(getCreaturePosition(cid), 34)
setPlayerStorageValue(cid, storage, os.time()+exhaust)
doPlayerAddMana(cid, -mana)
addEvent(doChangeSpeed, time*1000+40, cid, -speed)
addEvent(doPlayerSendTextMessage, time*1000+45, cid, 23, "Mount is time out!")
addEvent(doSendMagicEffect, time*1000+50, getCreaturePosition(cid), 2)
else
doPlayerSendCancel(cid, "Sorry, you only can again use this item after "..exhaust.." seconds.")
end
return TRUE
end 