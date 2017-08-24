        spr_id = 8472 -- Item a ser vendido
        custospr_id = 8000 -- Valor
		cargasspr_id = 100 -- Cargas

local name = getItemNameById(spr_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custospr_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custospr_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,spr_id, cargasspr_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custospr_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end