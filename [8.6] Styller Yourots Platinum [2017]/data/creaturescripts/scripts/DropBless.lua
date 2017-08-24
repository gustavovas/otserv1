function onDeath(cid, corpse, deathList)
function HaveBless(cid)
for i = 1,5 do
if getPlayerBlessing(cid, i) then
return true
end
end
return false
end
if isPlayer(cid) and HaveBless(cid) and getPlayerSkullType(cid) < SKULL_RED then
doCreatureSetDropLoot(cid, false)
end
return true
end