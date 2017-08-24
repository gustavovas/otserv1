        shp_id = 7588 -- Item a ser vendido
		custoshp_id = 5000 -- Valor
		cargasshp_id = 100 -- Cargas

local name = getItemNameById(shp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custoshp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custoshp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,shp_id, cargasshp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custoshp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end