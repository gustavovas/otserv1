function onStepIn(cid, item, pos)
msg = "Fight!"
pausa = 1000 -- 1 segundos (leo nao mexe k� nao)
wall0pos = {x=580, y=612, z=7, stackpos=1} -- posi��o da parede - nao mexer na stackpos.
wall = 1354 -- id da parede que ir� aparecer
xp1pos = {x=583, y=612, z=7} -- Posi�ao da criatura
doSummonCreature("frostfur", xp1pos) -- Criatura
parametro = cid, item, pos
          if item.actionid == 9900 then

                  if isPlayer(cid) == 1 then
                  wall0 = getThingfromPos(wall0pos)
                        if wall0.itemid ~= 0 then
                        doRemoveItem(wall1.uid,1)
                        doPlayerSendTextMessage(cid,22,msg)
                        addEvent(tempo, pausa, parametro)  
            
                        end

                  end

                  return 1

          end

end

                         function tempo(parametro)

                         doCreateItem(wall,1,wall0pos)

                         end
