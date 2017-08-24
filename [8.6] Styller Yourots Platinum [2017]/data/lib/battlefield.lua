battlefield = {
	storage = 201206300801,
	storage2 = 201206300802,
	tpPos = {x=154, y=52, z=7}, -- aonde aparecerá o teleport
    pos_team_1 = {x=2776,y=1505,z=8}, -- posição do team 1 (do lado direito)
    pos_team_2 = {x=2732,y=1505,z=8}, -- posição do team 2 (do lado esquerdo)
	spectors = {{x=2758,y=1497,z=6},{x=2774,y=1497,z=6},{x=2774,y=1512,z=6},{x=2758,y=1512,z=6}}, -- aonde aparecerá os espectadores (em volta do battlefield)
	team1Name = "Black Assassins",
    team2Name = "Red Barbarians",	
}

function doBroadCastBattle(type,msg)

for _, cid in pairs(getPlayersOnline()) do
	if getPlayerStorageValue(cid, battlefield.storage2) ~= -1 then
		doPlayerSendTextMessage(cid,type,msg) 
	end 
end

return true 
end

function removeTp()

local t = getTileItemById(battlefield.tpPos, 1387)
	if t then
		doRemoveItem(t.uid, 1)
		doSendMagicEffect(battlefield.tpPos, CONST_ME_POFF)
	end
	
end

function OpenWallBattle()

local x = true
local B  = {  
	[1] = {1056,{x=2766, y=1503, z=6, stackpos = 1}},  -- posição da barreira 
	[2] = {1056,{x=2766, y=1504, z=6, stackpos = 1}},  -- posição da barreira 
	[3] = {1056,{x=2766, y=1505, z=6, stackpos = 1}},	 -- posição da barreira 
	[4] = {1056,{x=2766, y=1506, z=6, stackpos = 1}}   -- posição da barreira 
	} 

for i = 1, #B do
	if getTileItemById(B[i][2], B[i][1]).uid == 0 then 
		x = false 
	end
	if x == true then
		doRemoveItem(getThingfromPos(B[i][2]).uid,1)
	else
		doCreateItem(B[i][1], 1, B[i][2]) 
	end
end

end

function getWinnersBattle(storage)

local team = storage == 1 and battlefield.team1Name or battlefield.team2Name

doBroadcastMessage("Players from team ".. team .." won the event battlefield,they received a Addon Doll!")
setGlobalStorageValue(battlefield.storage, -1)
removeTp()
OpenWallBattle()

for _, cid in pairs(getPlayersOnline()) do
	if getPlayerStorageValue(cid, battlefield.storage2) ~= -1 then 
		doRemoveCondition(cid, CONDITION_OUTFIT)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		if getPlayerStorageValue(cid, battlefield.storage2) == storage then
			doPlayerAddItem(cid,9693,1)
		end
		setPlayerStorageValue(cid, battlefield.storage2, -1)
	end
end

end