--Demon Oak 1.1 by Ta4e--
--Some scripts based in script of Mazen--

function onStepOut(cid, item, position, fromPosition)

    if item.uid == 32193 and item.itemid == 3612 then
        doTransformItem(item.uid,2717)
    end
end

function onStepIn(cid, item, position, fromPosition)

local yell = getPlayerStorageValue(cid, 15006)
local pos1= {x=1866, y =973, z=7} --Aqui a posição do lado da arvore, de onde sairá o grito dela.

    if item.uid == 32195 and item.itemid == 1387 then
        if getPlayerStorageValue(cid, 15005) == 7 then
            doCreatureSay(cid,"Tell Oldrak about your great victory against the demon oak.",TALKTYPE_ORANGE_1 )
        else
            doCreatureSay(cid,"You have escaped of Demon Oak.",TALKTYPE_ORANGE_1 )
            setPlayerStorageValue(cid, 15001,1)
            setPlayerStorageValue(cid, 15002,1)
            setPlayerStorageValue(cid, 15003,1)
            setPlayerStorageValue(cid, 15004,1)
            setPlayerStorageValue(cid, 15005,3)
        end
    end
    
    
        if getPlayerStorageValue(cid, 15006) < 5 then
            yell = yell + 1            
                    if item.actionid == 15002 and getPlayerStorageValue(cid, 15006) == -1 then
                        setPlayerStorageValue(cid, 15006,yell)
                        doCreatureSay(cid, "Find a way in here and release me! Pleeeease hurry!",TALKTYPE_ORANGE_1 )
                    elseif item.actionid == 15003 and getPlayerStorageValue(cid, 15006) == 0 then
                        setPlayerStorageValue(cid, 15006,yell)
                        doCreatureSay(cid, "I can bring your beloved back from the dead,just release me!",TALKTYPE_ORANGE_1 )
                    elseif item.actionid == 15004 and getPlayerStorageValue(cid, 15006) == 1 then
                        setPlayerStorageValue(cid, 15006,yell)
                        doCreatureSay(cid, pos1, "What is this? Demon legs lying here? Someone might have lost them.",TALKTYPE_ORANGE_1 )
                    elseif item.actionid == 15005 and getPlayerStorageValue(cid, 15006) == 2 then
                        setPlayerStorageValue(cid, 15006,yell)
                        doCreatureSay(cid, "I'm trapped come here and free me, fast!!!",TALKTYPE_ORANGE_1 )
                    elseif item.actionid == 15006 and getPlayerStorageValue(cid, 15006) == 3 then
                        setPlayerStorageValue(cid, 15006,yell)
                        doCreatureSay(cid, "I'm trapped come here and free me, fast!!!",TALKTYPE_ORANGE_1 )
                    end
        
                
    

    elseif item.actionid == 15001 then
        if getPlayerStorageValue(cid, 15005) <=7 then
            if math.random(1,4) == 2 then
                doTargetCombatHealth(0, cid, COMBAT_EARTHDAMAGE, -500, -500, CONST_ME_BIGPLANTS)
            end
        end
    end

end