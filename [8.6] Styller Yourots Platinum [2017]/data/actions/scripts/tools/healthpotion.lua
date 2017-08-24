        hp_id = 7618 -- Item a ser vendido
        	custohp_id = 3000 -- Valor
		cargashp_id = 100 -- Cargas

local name = getItemNameById(hp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custohp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custohp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,hp_id, cargashp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custohp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end