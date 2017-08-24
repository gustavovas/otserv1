        uhp_id = 8473 -- Item a ser vendido
        custouhp_id = 10000 -- Valor
		cargasuhp_id = 100 -- Cargas

local name = getItemNameById(uhp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custouhp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custouhp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,uhp_id, cargasuhp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custouhp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end