function onStepIn(cid, item, pos)
    if item.uid == 4059 then
        if getPlayerStorageValue(cid,4058) == -1 then
            setPlayerStorageValue(cid,4058,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Verminor큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have absorved the spirit of Verminor, the Plaguelord.')
        end
    elseif item.uid == 4061 then
        if getPlayerStorageValue(cid,4060) == -1 then
            setPlayerStorageValue(cid,4060,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Infernatil큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have absorved the spirit of Infernatil, the Incendiary of Hell.')
        end
    elseif item.uid == 4063 then
        if getPlayerStorageValue(cid,4062) == -1 then
            setPlayerStorageValue(cid,4062,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Tafariel큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have absorved the spirit of Tafariel, the Mistress of the Damned.')
        end
    elseif item.uid == 4067 then
        if getPlayerStorageValue(cid,4066) == -1 then
            setPlayerStorageValue(cid,4066,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Apocalypse큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have absorved the spirit of Apocalypse, Total Destruction.')
        end
    elseif item.uid == 10278 then
        if getPlayerStorageValue(cid,10278) == -1 then
            setPlayerStorageValue(cid,10278,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Pumin큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Pumin큦 spirit.')
        end
    elseif item.uid == 10279 then
        if getPlayerStorageValue(cid,10279) == -1 then
            setPlayerStorageValue(cid,10279,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Bazir큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have already absorbed some of Bazir큦 spirit.')
        end
    elseif item.uid == 4065 then
        if getPlayerStorageValue(cid,4064) == -1 then
            setPlayerStorageValue(cid,4064,1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have touched Ashfalor큦 throne and absorbed some of his spirit.')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You have absorved the spirit of Ashfalor, the Right Hand of Urgith. The general of the undead hordes.')
        end
    elseif item.uid == 10281 and item.itemid == 1210 and pos == {x=345, y=1419, z=12} then
        if getPlayerStorageValue(cid,10274) == -1 or getPlayerStorageValue(cid,10275) == -1 or getPlayerStorageValue(cid,10276) == -1 or getPlayerStorageValue(cid,10277) == -1 or getPlayerStorageValue(cid,10278) == -1 then
            doTransformItem(item.uid,item.itemid+1)
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'Sorry, but you did not absorb enough energy!')
        else
            doPlayerSendTextMessage(cid,MESSAGE_EVENT_ADVANCE,'You absorbed enough energy! You may pass.')
        end
    end
    return 1
end