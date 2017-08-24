local conditionBlack = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionBlack, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionBlack, {lookType = 134, lookHead = 114, lookBody = 114, lookLegs = 114, lookFeet = 114})
local conditionRed = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionRed, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionRed, {lookType = 143, lookHead = 94, lookBody = 94, lookLegs = 94, lookFeet = 94})

function onStepIn(cid, item, position, fromPosition)

if getPlayerAccess(cid) > 3 then 
	doTeleportThing(cid, battlefield.pos_team_1) 
	return true
elseif getGlobalStorageValue(battlefield.storage) == 0 then
	doTeleportThing(cid, battlefield.spectors[math.random(#battlefield.spectors)]) 
	return true
end        

if getGlobalStorageValue(battlefield.storage) > 0 then
	if getGlobalStorageValue(battlefield.storage) % 2 == 0 then
		setPlayerStorageValue(cid, battlefield.storage2, 1)
		doAddCondition(cid, conditionBlack)
		doTeleportThing(cid, battlefield.pos_team_1)   
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You will join the team " .. battlefield.team1Name .. "!")       
	else
		setPlayerStorageValue(cid, battlefield.storage2, 2)
		doAddCondition(cid, conditionRed)
		doTeleportThing(cid, battlefield.pos_team_2)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You will join the team " .. battlefield.team2Name .. "!")
	end
	setGlobalStorageValue(battlefield.storage, getGlobalStorageValue(battlefield.storage)-1)
	if getGlobalStorageValue(battlefield.storage) == 0 then
		doBroadcastMessage("Battlefield will start in 1 minute, please create your strategy!")
		addEvent(doBroadcastMessage, 60*1000, "BattleField will begin now!")
		addEvent(OpenWallBattle, 60*1000)
	else
		doBroadcastMessage("We are waiting "..getGlobalStorageValue(battlefield.storage).." players to Battlefield starts.")
	end
end

return true
end