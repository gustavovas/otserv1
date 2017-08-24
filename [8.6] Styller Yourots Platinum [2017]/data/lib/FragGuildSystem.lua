frag_guild = {
start_frags = 120155, -- dont edit
FragsToWinAcess = 10, -- to win guild acess
FragsPerKill = 1,
AcessTimeDays = 1,
MoreExpToGuild = true,
Exp_Rate = 1.1, -- 10%
Honor_Storage = 215548,
Honor_Point = 5
}


function getFragsByGuild(GuildName)
local check = db.getResult("SELECT `frags` FROM `guilds` WHERE `id` = " ..getGuildId(GuildName))
return check:getDataInt("frags") <= 0 and 0 or check:getDataInt("frags") end
function addFragsByGuild(GuildName,amount)
db.query("UPDATE `guilds` SET `frags` = "..getFragsByGuild(GuildName).."+"..amount.." WHERE `guilds`.`id` = "..getGuildId(GuildName)) end
function removeFragsByGuild(GuildName,amount)
db.query("UPDATE `guilds` SET `frags` = "..getFragsByGuild(GuildName).."-"..amount.." WHERE `guilds`.`id` = "..getGuildId(GuildName)) end
function setFragsByGuild(GuildName,value)
db.query("UPDATE `guilds` SET `frags` = "..value.." WHERE `guilds`.`id` = "..getGuildId(GuildName)) end
function cleanGuildFrags()
db.query("UPDATE guilds SET frags = 0;")
end
function getAcessTime(GuildName)
		local query = db.getResult("SELECT `acesstime` FROM `guilds` WHERE `id` = " ..getGuildId(GuildName))
		if query:getID() ~= -1 then return query:getDataInt("acesstime") end
end
function removeAcessGuildServer()
return db.query("UPDATE guilds SET acesstime = 0;")
end
function HaveGuild(cid)
return getPlayerGuildId(cid) > 0 and TRUE or FALSE
end
function doBroadCastGuild(GuildName,type,msg)
local players = {}
for _, cid in pairs(getPlayersOnline()) do
if getPlayerGuildName(cid) == GuildName then
table.insert(players, cid) end end
for i = 1, #players do doPlayerSendTextMessage(players[i],type,msg) end
return true end
function setAcessTime(GuildName, time)
return db.query("UPDATE `guilds` SET `acesstime` = "..time.." WHERE `guilds`.`id` = "..getGuildId(GuildName))
end
function getDaysAcess(GuildName)
local acess = math.ceil((getAcessTime(GuildName) - os.time())/(86400))
return acess <= 0 and 0 or acess
end
function HaveAcess(GuildName)
		return getDaysAcess(GuildName) > 0 and TRUE or FALSE
end
function getGuildWinnerName()
local guildname = ''
local query = db.getResult("SELECT `name` FROM `guilds`;")  
if(query:getID() ~= -1) then  
repeat  
if HaveAcess(query:getDataString("name")) then
guildname = query:getDataString("name")
end
until not query:next()  
query:free()
end
return guildname
end
function addAcess(GuildName, days)
if days > 0 then
local add = days*86400
local time = getDaysAcess(GuildName) == 0 and (os.time() + add) or (getAcessTime(GuildName) + add)
return setAcessTime(GuildName, time) end
return nil end
function doRemoveAcess(GuildName, days)
if days > 0 then
local remove = days*86400
local time = getAcessTime(GuildName) - remove
return setAcessTime(GuildName, (time <= 0 and 1 or time)) end
return nil end
function getAcessDate(GuildName)
if HaveAcess(GuildName) then return os.date("%d/%m/%y %X", getAcessTime(GuildName)) end
return FALSE
end
function getHonorPoints(cid)
local Honor = getPlayerStorageValue(cid, frag_guild.Honor_Storage)
return Honor < 0 and 0 or Honor
end
function addHonorPoints(GuildName, amount)
local PlayersGuild = db.getResult("SELECT `name` FROM `players` WHERE `rank_id` IN (SELECT `id` FROM `guild_ranks` WHERE `guild_id` = " .. getGuildId(GuildName) .. ");")  
if (PlayersGuild:getID() ~= -1) then
repeat
local pid,Guid = getPlayerByNameWildcard(PlayersGuild:getDataString("name")),getPlayerGUIDByName(PlayersGuild:getDataString("name"))
if(not pid or isPlayerGhost(pid)) then
local getHonor = db.getResult("SELECT `value` FROM `player_storage` WHERE `player_id` = ".. Guid .." AND `key` = ".. frag_guild.Honor_Storage)
if (getHonor:getID() ~= -1) then
repeat
db.query("UPDATE `player_storage` SET `value` = ".. (getHonor:getDataInt("value")+amount) .." WHERE `player_id` = ".. Guid .." AND `key` = ".. frag_guild.Honor_Storage)
until not(getHonor:next())
getHonor:free()
end
else
setPlayerStorageValue(getPlayerByName(PlayersGuild:getDataString("name")), frag_guild.Honor_Storage, getHonorPoints(getPlayerByName(PlayersGuild:getDataString("name")))+amount)
end
until not PlayersGuild:next()
PlayersGuild:free()
end
return true
end