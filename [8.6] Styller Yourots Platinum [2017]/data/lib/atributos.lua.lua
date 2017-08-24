                vocationPoints = {
                        [0] = 3,
                        [1] = 3,
                        [2] = 3,
                        [3] = 3,
                        [4] = 3,
                        [5] = 5,
                        [6] = 5,
                        [7] = 5,
                        [8] = 5,
                }
               
                skills = {
                        ["vitality"] = {id = 30,neededPoints = 50,quantoGanha = 5, vocationNeeded={0,1,2,3,4,5,6,7,8,9,10,11,12}},
                        ["mana"] = {id = 35,neededPoints = 50,quantoGanha = 5, vocationNeeded={0,1,2,3,4,5,6,7,8,9,10,11,12}},
                }
               
                resetPreco = 50
 
                storagesUtilizadas = {
                        storageLevelJaPego = 12448,
                        storagePontos = 12449,                        
                        storageVitalityPoints = 12457,
                        storageManaPoints = 12458,
                        storageVitality = 12466,
   storageMana = 12467,
  }
  function getPontos(cid)
   return (getPlayerStorageValue(cid,storagesUtilizadas.storagePontos))
  end
 
  function addPontos(cid,qtd)
   setPlayerStorageValue(cid,storagesUtilizadas.storagePontos,getPontos(cid) + qtd)
  end
 
  function addSkill(cid,id,pontosUsados,quantoGanha,vocationNeeded)
   if not isInArray(vocationNeeded,getPlayerVocation(cid)) then
    return "Sua vocacao nao pode adicionar esse atributo!"
   end
   if getPontos(cid) < pontosUsados then
    return "Voce nao tem pontos o suficiente para adicionar esse atributo!"
   end
   local storage = {
    [30] = {st1 = storagesUtilizadas.storageVitality,st2 = storagesUtilizadas.storageVitalityPoints},
    [35] = {st1 = storagesUtilizadas.storageMana,st2 = storagesUtilizadas.storageManaPoints},
   }
 
   if id == 30 then
    setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) + quantoGanha)
    doCreatureAddHealth(cid, quantoGanha)
   elseif id == 35 then
    setCreatureMaxMana(cid, getCreatureMaxMana(cid) + quantoGanha)
    doCreatureAddMana(cid, quantoGanha)   
    end
       setPlayerStorageValue(cid,storage[id].st1,getPlayerStorageValue(cid,storage[id].st1) + quantoGanha)
    setPlayerStorageValue(cid,storage[id].st2,getPlayerStorageValue(cid,storage[id].st2) + pontosUsados)
    addPontos(cid,- pontosUsados)
    doSendMagicEffect(getCreaturePosition(cid), 30)
    return "Atributo adicionado!"
  end
 
  function resetPontos(cid)
   for i = storagesUtilizadas.storageFistPoints,storagesUtilizadas.storageManaPoints do
    addPontos(cid,getPlayerStorageValue(cid,i))
    setPlayerStorageValue(cid,i,0)
   end
   local guid = getPlayerGUID(cid)
   local atuais = {
   hp = getCreatureMaxHealth(cid) - (getPlayerStorageValue(cid,storagesUtilizadas.storageVitality)),
   mp = getPlayerMaxMana(cid) - (getPlayerStorageValue(cid,storagesUtilizadas.storageMana)),
   }
   doRemoveCreature(cid)
                       
                                        
                        db.query("UPDATE `players` SET `health` = " .. atuais.hp .. " WHERE `id` = "..guid)
                        db.query("UPDATE `players` SET `healthmax` = " .. atuais.hp .. " WHERE `id` = "..guid)
                       
                        db.query("UPDATE `players` SET `mana` = " .. atuais.mp .. " WHERE `id` = "..guid)
                        db.query("UPDATE `players` SET `manamax` = " .. atuais.mp .. " WHERE `id` = "..guid)
                       
                         
                        for i = storagesUtilizadas.storageFist, storagesUtilizadas.storageMana do
                                db.query("UPDATE `player_storage` SET `value` = 0 WHERE `key` = "..i .. " and `player_id` = " ..guid)
                        end
                        return true
                end
