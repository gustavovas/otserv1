function onStartup()
	db.query("UPDATE `players` SET `online` = 0 WHERE `world_id` = " .. getConfigValue('worldId') .. ";")
	return true
end

db.query("DELETE FROM `guild_wars` WHERE `status` = 0 AND `begin` < " .. (os.time() - 2 * 86400) .. ";")
  db.query("UPDATE `guild_wars` SET `status` = 5, `end` = " .. os.time() .. " WHERE `status` = 1 AND `end` > 0 AND `end` < " .. os.time() .. ";")
