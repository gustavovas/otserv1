local shield = 2538
function onSay(cid, words, param, channel)
	local guild = getPlayerGuildId(cid)
	local guilds = {}
	tmp = -1
	if guild > 0 then 
 
		 tmp = db.getResult("SELECT `guild_id`,  `enemy_id` FROM `guild_wars` WHERE `status` = 1 AND (`guild_id` = "..guild.. " OR  `enemy_id` = "..guild..")  ;")  
 
	else
		doPlayerSendCancel(cid, "You are not in a guild.")
		return true
	end
	warString = ""
 
	if tmp:getID() ~= -1 then 
			i = 1
 
 
			repeat
 
				if tmp:getDataInt("guild_id") == guild   then
					enemy = tmp:getDataInt("enemy_id")
				else
					enemy = tmp:getDataInt("guild_id")
				end
 
				local enemyName, _tmp = "", db.getResult("SELECT `name` FROM `guilds` WHERE `id` = " .. enemy)
 
				if(_tmp:getID() ~= -1) then
					enemyName = _tmp:getDataString("name")
					_tmp:free()
 
				end
 
				guilds[i] = {}
				guilds[i].name = enemyName
				guilds[i].id = enemy
 
 
 
				i = i + 1
			until not(tmp:next())
			tmp:free()
	else
		doPlayerSendCancel(cid, "Your guild is not in war now.")
		return true
	end
 
 
	enemies = {}
	for i,x in pairs (guilds) do 
 
		enemies[x.name] = {}
		for _, pid in pairs(getPlayersOnline()) do
			if (getPlayerGuildId(pid) == x.id) then
				table.insert(enemies[x.name], getPlayerName(pid) .." ["..getPlayerLevel(pid).."]" .." ["..getPlayerVocationName(pid) .."]" )
			end
		end
 
 
	end
 
	str = "Guilds: \n"
	for v,w in pairs(enemies) do 
		str = str.. "•"..v.."("..#w.."): "..table.concat(w, "\n").."\n" 
	end
	doShowTextDialog(cid, shield, str)
 
 
	return true
end