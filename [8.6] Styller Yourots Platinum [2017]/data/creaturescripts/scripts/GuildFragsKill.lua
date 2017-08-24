function onKill(cid, target, lastHit)
local config = {MaxDifLevel = 200, MyGuild = getPlayerGuildName(cid)}
if isPlayer(cid) and isPlayer(target) and HaveGuild(cid) and getPlayerGuildId(cid) and math.abs(getPlayerLevel(cid) - getPlayerLevel(target)) <= config.MaxDifLevel and getGlobalStorageValue(frag_guild.start_frags) <= 0 then
addFragsByGuild(config.MyGuild,frag_guild.FragsPerKill)
doBroadCastGuild(config.MyGuild,20,'[Guild Frag System] Your guild received '..frag_guild.FragsPerKill..' frag because have killed a player, now your guild have '..getFragsByGuild(config.MyGuild)..' frags')
if getFragsByGuild(config.MyGuild) >= frag_guild.FragsToWinAcess then
addAcess(config.MyGuild, frag_guild.AcessTimeDays)
addHonorPoints(config.MyGuild, frag_guild.Honor_Point)
doBroadcastMessage("[Guild Frag System]\nThe guild ["..config.MyGuild.."] is dominant for having achieved "..frag_guild.FragsToWinAcess.." Frags!\nYour domain ends in "..getAcessDate(config.MyGuild))
cleanGuildFrags()
setGlobalStorageValue(frag_guild.start_frags, 1)
if frag_guild.MoreExpToGuild == true then
	   local players = {}
		for _, cid in pairs(getPlayersOnline()) do
				if getPlayerGuildName(cid) == config.MyGuild then
						table.insert(players, cid)
				end
	   end
	   for i = 1, #players do
	   doPlayerSetExperienceRate(players[i], frag_guild.Exp_Rate)
	   end
end
end
end
return TRUE
end