function onUse(cid, item, frompos, item2, topos)
        local config =
        {
                STORAGE_GUILD = 123123, -- A 3ª storage configurada em Castle.lua
                MSG_WELCOME = "Seja bem vindo a vosso castelo!",
                MSG_FAIL = "Este castelo nao pertence a sua guild."
        }
        if getPlayerGuildId(cid) == getGlobalStorageValue(config.STORAGE_GUILD) and getGlobalStorageValue(123124) >= os.time() then
                doTeleportThing(cid,getThingPos(item.uid))
                doTransformItem(item.uid, 5122)
                doPlayerSendTextMessage(cid, 22, config.MSG_WELCOME)  
        else
                doPlayerSendTextMessage(cid, 22, config.MSG_FAIL)
    end

        return true
end