--[script by Renato Ribeiro to TibiaKing.com]--

local config = {
level = 200,                                             -- level que irá ganhar
storage = 32649,                                         -- storage
msg = "You received the Medal of Honour to reach level 200. Using you can know the VIP City.",        -- mensagem ao ganhar
qnt = 1;                                                -- quantidade de crystal coin
msgtp = MESSAGE_INFO_DESCR,                          -- tipo da mensagem
itemid = 5785,                                          -- id do crystal coin (pode mudar se quiser)
}

function onAdvance(cid, oldLevel, newLevel)
        if getPlayerStorageValue(cid, config.storage) < 1 and getPlayerLevel(cid) >= config.level then
                doPlayerAddItem(cid, config.itemid, config.qnt)
                setPlayerStorageValue(cid, config.storage, 1)
                doPlayerSendTextMessage(cid, config.msgtp, config.msg)
        end
return TRUE
end