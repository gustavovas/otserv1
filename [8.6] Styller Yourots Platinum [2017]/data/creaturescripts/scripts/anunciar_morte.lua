function onKill(cid, target, lastHit)

	if not isPlayer(target) or not isPlayer(cid) then
		return true
	end

	doBroadcastMessage("DeathCast: "..getCreatureName(target).."["..getPlayerLevel(target).."] acabou de ser humilhado pelo jogador "..getCreatureName(cid).."["..getPlayerLevel(cid).."].", 22)
    return true
end