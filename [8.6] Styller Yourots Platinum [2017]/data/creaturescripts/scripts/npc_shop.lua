function onLogin(cid)
if getPlayerStorageValue(cid, _config_npc_shop.WithDraw_storage) == -1 then
setPlayerStorageValue(cid, _config_npc_shop.WithDraw_storage , 0)
end
 local file = io.open(OfflineMessagesConfig.messageSavingDirectory .. getCreatureName(cid) .. '.Gandhi', 'r')
		if(not file) then
			return true
		end
		if(not OfflineMessagesConfig.delayBeetwenShowMessageOnLogin) then
			for line in file:lines() do
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, line)
			end
		else
			local function sendLine(cid, msgType, filename)
				if(not isPlayer(cid)) then -- check player is still online
					return 
				end
				local file = io.open(filename, 'r')
				if(not file) then
					return 
				end
				local first, str = true, ''
				for line in file:lines() do
					if(first) then
						doPlayerSendTextMessage(cid, msgType, line)
						first = false
					else
						str = str .. line .. '\n'
					end
				end
				file:close()
				if(str ~= '') then
					file = io.open(filename, 'w')
					file:write(str)
					file:close()
 
					addEvent(sendLine, OfflineMessagesConfig.delayBeetwenShowMessageOnLogin, cid, msgType, filename)
				else
					os.remove(filename)
				end
			end
			addEvent(sendLine, OfflineMessagesConfig.delayBeetwenShowMessageOnLogin, cid, MESSAGE_STATUS_CONSOLE_ORANGE, OfflineMessagesConfig.messageSavingDirectory .. getCreatureName(cid) .. '.Gandhi')
		end
		file:close()
return true
end