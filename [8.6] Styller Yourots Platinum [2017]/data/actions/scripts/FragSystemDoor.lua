function onUse(cid, item, frompos, item2, topos)
local MyGuild = getPlayerGuildName(cid)
if not HaveGuild(cid) then
return doPlayerSendTextMessage(cid,22,"Sorry, you're not in a guild.")
elseif not HaveAcess(MyGuild) then
return doPlayerSendTextMessage(cid,22,"Your guild no has access to this area.") end
doTransformItem(item.uid, door_opened)
doTeleportThing(cid, topos, TRUE)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Welcome,The access of your guild in this area ends in "..getAcessDate(getGuildWinnerName()))
return true
end