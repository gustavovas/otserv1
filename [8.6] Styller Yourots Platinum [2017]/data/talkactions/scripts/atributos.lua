function onSay(cid, words, param)
                        local param = param:lower()
                local op = string.explode(param, ",")
                        local text = ""
                        if param == nil or (op[1] ~= "reset" and op[1] ~= "add" and op[1] ~= "build") then
                         
                                text = text ..
                                "Pontos: " .. getPontos(cid) ..
                                "\nSua vocação ganha: " .. vocationPoints[getPlayerVocation(cid)] .. " pontos por level" ..
                                "\n\nNome - Precisa - Ganha -- Para sua voc"
                                for i, x in pairs(skills) do
                                        if isInArray(x.vocationNeeded,getPlayerVocation(cid)) then
                                                text = text .. "\n"..i.. " - " ..x.neededPoints.. " - " .. x.quantoGanha .. ""
                                        end
                                end
                                text = text .. "\n\nExemplos:\n/atributos add,mana\n/atributos add,vitality"
                                text = text .. "\nVoce pode resetar seus atributos: Digite /atributos reset   (custa " .. resetPreco.."k)\nVeja sua build: /atributos build"
                                return doShowTextDialog(cid, 1976, text)
                        end
                       
                        if op[1] == "reset" then
                                if getCreatureCondition(cid, CONDITION_INFIGHT) == true then
                                        return doPlayerSendCancel(cid,"Voce tem que estar sem battle para resetar seus atributos")
                                end
                               
                                if getPlayerMoney(cid) < (resetPreco*1000) then
                                        return doPlayerSendCancel(cid,"Voce nao tem dinheiro suficiente para resetar seus atributos!")
                                end
                               
                                doPlayerRemoveMoney(cid, resetPreco*1000)
                                return resetPontos(cid)
                        end
                       
                        if op[1] == "add" then
                                if skills[op[2]] == nil then
                                        return doPlayerSendTextMessage(cid,19,"atributo nao existente. Verifique sua ortografia!")
                                end
                                doPlayerSendTextMessage(cid,19,addSkill(cid,skills[op[2]].id,skills[op[2]].neededPoints,skills[op[2]].quantoGanha,skills[op[2]].vocationNeeded))
                                return true
                        end
                       
                        if op[1] == "build" then
                        local atuais = {
                                hp = (getPlayerStorageValue(cid,storagesUtilizadas.storageVitality)),
                                mp = (getPlayerStorageValue(cid,storagesUtilizadas.storageMana)),
                                
                        }
                                text = "Quantidades de atributos ja recebidos: \n" ..
                                "Vitality: "..atuais.hp.." \n" ..
                                "Mana: "..atuais.mp.." \n" ..
                                "Pontos restantes: " .. getPontos(cid)
                               
                                doShowTextDialog(cid, 1976, text)
                                return true
                        end
return true
end