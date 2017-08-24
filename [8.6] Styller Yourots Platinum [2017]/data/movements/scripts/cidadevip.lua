function onStepIn(cid, item, pos)
-- Script By Debone

idcidade = 3
mensagem = 'Voce virou um morador da Cidade Vip'

if item.uid == 17201 then
	doPlayerSetTown(cid,idcidade)
	doPlayerSendTextMessage(cid,22,mensagem)
return 1
end
end