        ghp_id = 7591 -- Item a ser vendido
        custoghp_id = 8000 -- Valor
		cargasghp_id = 100 -- Cargas

local name = getItemNameById(ghp_id)
----- End Config -----
function onUse(cid, item, fromPosition, itemEx, toPosition)
        if doPlayerRemoveMoney(cid, custoghp_id) == TRUE then
                        doSendAnimatedText(fromPosition, "", TEXTCOLOR_YELLOW)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have purchased a 100 ".. name .."s for ".. custoghp_id .." gold.")
						for i=1,1 do
                        doPlayerAddItem(cid,ghp_id, cargasghp_id)
                end
                else
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You need ".. custoghp_id .." gold coins for a 100 ".. name .."s.")
                end
        return FALSE
end