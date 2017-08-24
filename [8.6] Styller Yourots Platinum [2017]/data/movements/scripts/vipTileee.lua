function onStepIn(cid, item, position, fromPosition)

newnPosition = {x=284, y=68, z=11}

local tileConfig = {
        kickPos = fromPosition,
        kickEffect = CONST_ME_POFF,
        kickMsg = "Você precisa completar a Pits of Inferno Quest.",
        }

poi = getPlayerStorageValue(cid,5955)
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
