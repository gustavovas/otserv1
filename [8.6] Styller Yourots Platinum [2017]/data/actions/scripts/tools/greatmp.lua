        gmp_id = 7590 -- Item a ser vendido
       	custogmp_id = 8000 -- Valor
		cargasgmp_id = 100 -- Cargas

local name = getItemNameById(gmp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custogmp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custogmp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,gmp_id, cargasgmp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custogmp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end