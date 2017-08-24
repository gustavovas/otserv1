function onStepIn(cid, item, pos)
-- Script By Debone

idcidade = 4
mensagem = 'Voce virou um morador de Blue City'

if item.uid == 17204 then
	doPlayerSetTown(cid,idcidade)
	doPlayerSendTextMessage(cid,22,mensagem)
return 1
end
end