        mp_id = 7620 -- Item a ser vendido
        customp_id = 3000 -- Valor
		cargasmp_id = 100 -- Cargas

local name = getItemNameById(mp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, customp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. customp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,mp_id, cargasmp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. customp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end