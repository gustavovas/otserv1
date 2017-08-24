local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

function onLogin(cid)
	local loss = getConfigValue('deathLostPercent')
	if(loss ~= nil) then
		doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	end

	local accountManager = getPlayerAccountManager(cid)
	if(accountManager == MANAGER_NONE) then
		local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		if(lastLogin > 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
		else
			str = str .. " Please choose your outfit."
			doPlayerSendOutfitWindow(cid)
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
	elseif(accountManager == MANAGER_NAMELOCK) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
	elseif(accountManager == MANAGER_ACCOUNT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to manage your account and if you want to start over then type 'cancel'.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to create an account or type 'recover' to recover an account.")
	end

	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end

	registerCreatureEvent(cid, "Mail")

registerCreatureEvent(cid, "DeathList")	registerCreatureEvent(cid, "GuildMotd")

	registerCreatureEvent(cid, "anunciarmorte") registerCreatureEvent(cid, "fraglook")

	registerCreatureEvent(cid, "Idle")
	if(config.useFragHandler) then
		registerCreatureEvent(cid, "SkullCheck")

registerCreatureEvent(cid, "hmup")		registerCreatureEvent(cid, "Reward")
	end

	registerCreatureEvent(cid, "ReportBug")

registerCreatureEvent(cid, "BlessDrop")	registerCreatureEvent(cid, "AdvanceSave")

registerCreatureEvent(cid, "advance")
registerCreatureEvent(cid, "FimVip")
registerCreatureEvent(cid,"presente")

registerCreatureEvent(cid, "EvoluirStaff")registerCreatureEvent(cid, "ExpGuild")
	registerCreatureEvent(cid, "ExpGuild_out")
registerCreatureEvent(cid, "ProtectLevel")
registerCreatureEvent(cid, "LootEventKill")
registerCreatureEvent(cid, "SkullCheck")
	registerCreatureEvent(cid, "ReportBug")

registerCreatureEvent(cid, VipReceive)
registerCreatureEvent(cid, "PlayerKill")
    if (InitArenaScript ~= 0) then
    InitArenaScript = 1
    -- make arena rooms free
        for i = 42300, 42309 do
            setGlobalStorageValue(i, 0)
            setGlobalStorageValue(i+100, 0)
        end
    end
    -- if he did not make full arena 1 he must start from zero
    if getPlayerStorageValue(cid, 42309) < 1 then
        for i = 42300, 42309 do
            setPlayerStorageValue(cid, i, 0)
        end
    end
    -- if he did not make full arena 2 he must start from zero
    if getPlayerStorageValue(cid, 42319) < 1 then
        for i = 42310, 42319 do
            setPlayerStorageValue(cid, i, 0)
        end
    end
    -- if he did not make full arena 3 he must start from zero
    if getPlayerStorageValue(cid, 42329) < 1 then
        for i = 42320, 42329 do
            setPlayerStorageValue(cid, i, 0)
        end
    end
    if getPlayerStorageValue(cid, 42355) == -1 then
        setPlayerStorageValue(cid, 42355, 0) -- did not arena level
    end
    setPlayerStorageValue(cid, 42350, 0) -- time to kick 0
    setPlayerStorageValue(cid, 42352, 0) -- is not in arena  
       ---------- STAMINA FILLER ---------------
registerCreatureEvent(cid, "staminafiller")
if getPlayerStorageValue(cid, 19387) ~= 0 then
        setPlayerStorageValue(cid, 19387, 0) 
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[DICA] Itens VIPs podem ser adquiridos na POI e usando Refinador!")
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Seja VIP tenha 20% de exp rate a mais. Compre no NPC Hagar (!buyvip)")

return true
end

