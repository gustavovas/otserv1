function onUse(cid, item, frompos, item2, topos)
  local pausa = 60*60*1000 -- (1000 = 1 segundos) Tempo que o script durará
  local texto = "Now you will receive more experience from killing monsters." -- Texto que irá receber ao usar a potion.
  textofinal = "The effect of the experience potion ended." -- Texto que irá receber quando o efeito da potion acabar.
  local exp = 2 -- O quanto que você quer que dobre sua experiencia, por exemplo 2 é 2x as rates do seu server.
  expfinal = 1 --Não mude, isso é para a experiencia voltar ao normal.
    if item.itemid == 7443 then
      doRemoveItem(item.uid,1)
      doPlayerSetExperienceRate(cid,exp)
      doSendMagicEffect(frompos,13)
      doPlayerSendTextMessage(cid,22,texto)
      addEvent(potion,pausa,cid)
    end
end

function potion(pos, cid)
  doPlayerSetExperienceRate(pos,expfinal)
  doPlayerSendTextMessage(pos,22,textofinal)
end