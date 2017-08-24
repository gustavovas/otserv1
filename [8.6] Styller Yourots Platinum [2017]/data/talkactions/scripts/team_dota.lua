function onSay(cid, words, param, channel)
local mensage1 = "[Evento Dota] Liberada Sala dos Times! Interessados em participar, vá para a sala de times até o Evento começar! (Teleport no Templo)" -- Mensagem Inicial

gatepos = {x=677, y=14, z=7, stackpos=1} -- Posição da Pedra
getgate = getThingfromPos(gatepos)

if getgate.itemid == 1304 then
broadcastMessage(mensage1, MESSAGE_EVENT_ADVANCE)
doRemoveItem(getgate.uid,1)

end
return 1
end