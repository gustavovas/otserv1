function onUse(cid, item, fromPosition, itemEx, toPosition)

local team = getPlayerStorageValue(cid, battlefield.storage2)

if (item.actionid == 45001 and team == 1) or (item.actionid == 45002 and team == 2) then
	getWinnersBattle(team)
end

return true
end