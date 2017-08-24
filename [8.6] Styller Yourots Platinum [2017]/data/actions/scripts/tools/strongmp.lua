        smp_id = 7589 -- Item a ser vendido
        custosmp_id = 5000 -- Valor
		cargassmp_id = 100 -- Cargas

local name = getItemNameById(smp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custosmp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custosmp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,smp_id, cargassmp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custosmp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end