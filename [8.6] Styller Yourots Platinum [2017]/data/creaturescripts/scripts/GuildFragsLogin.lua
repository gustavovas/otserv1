function onLogin(cid)
registerCreatureEvent(cid, "FragsGuildLogin")
registerCreatureEvent(cid, "FragsGuildKill")
if getPlayerStorageValue(cid,frag_guild.Honor_Storage) == -1 then
setPlayerStorageValue(cid, frag_guild.Honor_Storage, 0)
end
local MyGuild,StorCheck = getPlayerGuildName(cid),17595
if HaveGuild(cid) then
if HaveAcess(MyGuild) then
setPlayerStorageValue(cid, StorCheck, 1)
if frag_guild.MoreExpToGuild == true then
doPlayerSetExperienceRate(cid, frag_guild.Exp_Rate)
end
elseif getPlayerStorageValue(cid, StorCheck) == 1 and not HaveAcess(MyGuild) then
doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
doPlayerPopupFYI(cid, "[Guild Frag System]\nThe domain of your guild is over and you've been teleported to the temple.")
setPlayerStorageValue(cid, StorCheck, -1)
if getGlobalStorageValue(frag_guild.start_frags) >= 1 then setGlobalStorageValue(frag_guild.start_frags, 0) end
end
end
return TRUE
end