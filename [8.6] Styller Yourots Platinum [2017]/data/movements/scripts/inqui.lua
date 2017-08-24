function onStepIn(cid, item, position, fromPosition)

newnPosition = {x=103, y=36, z=6}

local tileConfig = {
        kickPos = fromPosition,
        kickEffect = CONST_ME_POFF,
        kickMsg = "Você precisa completar a Inquisition Quest.",
        }

poi = getPlayerStorageValue(cid,8560)
if poi == -1 then 
        doTeleportThing(cid, tileConfig.kickPos)
        doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
        doPlayerSendCancel(cid, tileConfig.kickMsg)
        return
    end


doTeleportThing(cid,newnPosition)
doSendMagicEffect(newnPosition,10)
        return true
end
