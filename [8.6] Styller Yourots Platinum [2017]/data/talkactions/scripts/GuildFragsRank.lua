function onSay(cid, words, param)
if words == "!myhonor" or  words == "/myhonor" then
return doPlayerPopupFYI(cid,"Honor Points can be exchanged for special items in npc\nAnd each domain, every guild players receive "..frag_guild.Honor_Point.." Honor Points!\n\n\nMy Honor Points: "..getHonorPoints(cid))
elseif words == "!guildfrags" or words == "/guildfrags" then
if param == "rank" then
local max_guild,str = 10,""
str = "--[ Rank Guild Frags ]--\n\n"
				query = db.getResult("SELECT `name`, `frags` FROM `guilds` WHERE `frags` ORDER BY `frags` DESC, `name` ASC;")
				if (query:getID() ~= -1) then k = 1 while true do
				str = str .. "\n " .. k .. ". " .. query:getDataString("name") .. " - [" .. query:getDataInt("frags") .. "]"
				k = k + 1
				if not(query:next()) or k > max_guild then break end end query:free()end
				if str ~= "" then doPlayerPopupFYI(cid, str) end
return true
end
doPlayerPopupFYI(cid,"".. (getGuildWinnerName() == "" and "The server does not have any dominant guild\n\nTo show the rank of frags enter !guildfrags rank" or "Currently guild dominant is ["..getGuildWinnerName().."]\n\nYour domain ends in "..getAcessDate(getGuildWinnerName()).."") .."")
end
return true
end