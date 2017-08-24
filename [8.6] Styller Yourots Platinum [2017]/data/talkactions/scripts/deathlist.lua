limit = 5
function onSay(cid, words, param, channel)
str = ""
if param == "" then
local qry = db.getResult("SELECT `player_id`, `date`, `level`, `killer_name` FROM `death_list` ORDER BY `date` DESC LIMIT 0, " .. limit)
if(qry:getID() ~= -1) then
repeat
str = str .."\n "..os.date("%d %B %Y %X ", qry:getDataInt("date")).." "..getPlayerNameByGUID(qry:getDataString("player_id")).." died at level "..qry:getDataInt("level").." by:\n"..qry:getDataString("killer_name")
until not(qry:next())
qry:free()
else
str = "Não há mortes no servidor."
end
doPlayerPopupFYI(cid, "Last Deaths:\n\n" .. str)
return true
end
local getPlayer = db.getResult("SELECT `name`, `id` FROM `players` WHERE `name` = " .. db.escapeString(param) .. ";")
if(getPlayer:getID() == -1) then doPlayerSendCancel(cid, "Este Player não existe.") return true end
local getGuid = getPlayer:getDataInt("id")
getPlayer:free()
local qry = db.getResult("SELECT `id`, `date`, `level`, `killer_name` FROM `death_list` WHERE `player_id` = " .. getGuid .." ORDER BY `date` DESC LIMIT 0, " .. limit)
if(qry:getID() ~= -1) then
repeat
str = str .."\n "..os.date("%d %B %Y %X ", qry:getDataInt("date")).." died at level "..qry:getDataInt("level").." by:\n"..qry:getDataString("killer_name")
until not(qry:next())
qry:free()
else
str = "Não há mortes."
end
doPlayerPopupFYI(cid, "Last Deaths of: " .. param .. ".\n\n" .. str)
return true
end