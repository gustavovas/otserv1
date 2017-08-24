function onLogin(cid)
registerCreatureEvent(cid, "Exp_P")
if getPlayerStorageValue(cid, death_tabble.check) >= 1 then
setPlayerStorageValue(cid, death_tabble.after_exp, getPlayerExperience(cid))
setPlayerStorageValue(cid, death_tabble.check, -1)
end
return true
end
function onPrepareDeath(cid, lastHitKiller, mostDamageKiller)
setPlayerStorageValue(cid, death_tabble.before_exp, getPlayerExperience(cid))
setPlayerStorageValue(cid, death_tabble.check, 1)
return TRUE
end