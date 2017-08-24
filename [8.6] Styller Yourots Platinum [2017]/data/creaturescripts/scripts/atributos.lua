         function onAdvance(cid, skill, oldLevel, newLevel)
                if not (vocationPoints[getPlayerVocation(cid)]) then
                        return true
                end
                        if skill == 8 then
                                 if getPlayerStorageValue(cid, storagesUtilizadas.storageLevelJaPego) < newLevel then
                                    local pts = (newLevel - (1 + getPlayerStorageValue(cid, storagesUtilizadas.storageLevelJaPego))) * vocationPoints[getPlayerVocation(cid)]
                        addPontos(cid,pts)
                                        setPlayerStorageValue(cid,storagesUtilizadas.storageLevelJaPego,newLevel -1)
                                        doSendAnimatedText(getCreaturePosition(cid), "+"..pts, math.random(1,200))
                                end
                        end
                return true
                end
