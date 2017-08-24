function onUse(cid, item, fromPosition, itemEx, toPosition)
treepos = {x=327, y=481, z=7, stackpos=1}
treepos2 = {x=325, y=487, z=7, stackpos=1} --- position of left arm
treepos3 = {x=327, y=485, z=7, stackpos=1} --- position of crow
treepos4 = {x=327, y=488, z=7, stackpos=1} --- position of mouth
newPosition = {x=327, y=482, z=7}
monster1 = {x=323, y=483, z=7}
monster2 = {x=323, y=490, z=7}
monster3 = {x=331, y=483, z=7}
monster4 = {x=331, y=490, z=7}
tree = getThingfromPos(treepos).uid
tree2 = getThingfromPos(treepos2).uid
tree3 = getThingfromPos(treepos3).uid
tree4 = getThingfromPos(treepos4).uid
playerPos = getCreaturePosition(cid)
local randomizer = math.random(1,6)
queststatus = getPlayerStorageValue(cid,8181)
queststatus2 = getPlayerStorageValue(cid,8282)
queststatus3 = getPlayerStorageValue(cid,8383)
queststatus4 = getPlayerStorageValue(cid,8484)
Level = getPlayerLevel(cid)

	if itemEx.itemid == 2709 and itemEx.actionid == 7787 and Level >= 120 then
		doRemoveItem(tree)
		doTeleportThing(cid, newPosition, TRUE)
		setPlayerStorageValue(cid,8181,1)
	else
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		end
	if itemEx.itemid == 2709 and itemEx.actionid == 7788 then
		doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "A player is already doing this quest.")
	end
	if itemEx.itemid == 8289 and itemEx.actionid == 8181 and (randomizer == 1) and queststatus == 1 then
		doSummonCreature("Crypt Shambler", monster1)
		doSummonCreature("Crypt Shambler", monster2)
		doSummonCreature("Crypt Shambler", monster3)
		doSummonCreature("Crypt Shambler", monster4)
	elseif itemEx.itemid == 8289 and itemEx.actionid == 8181 and (randomizer == 2) and queststatus == 1 then
		doSummonCreature("Bone Beast", monster1)
		doSummonCreature("Bone Beast", monster2)
		doSummonCreature("Bone Beast", monster3)
		doSummonCreature("Bone Beast", monster4)
	elseif itemEx.itemid == 8289 and itemEx.actionid == 8181 and (randomizer == 3) and queststatus == 1 then
		doSummonCreature("Betrayed Wraith", monster1)
		setPlayerStorageValue(cid,8181,-1)
		setPlayerStorageValue(cid,8282,1)
	elseif itemEx.itemid == 8289 and itemEx.actionid == 8181 and (randomizer >= 4) and queststatus == 1 then
		doSendMagicEffect(playerPos, 45)
		doCreatureAddHealth(cid, -300)
		doSendAnimatedText(playerPos, '300', TEXTCOLOR_LIGHTGREEN)
		end
	if itemEx.itemid == 8289 and itemEx.actionid == 8181 and queststatus == -1 then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		end
	if itemEx.itemid == 8288 and itemEx.actionid == 8282 and (randomizer == 1) and queststatus2 == 1 then
		doSummonCreature("Crypt Shambler", monster1)
		doSummonCreature("Crypt Shambler", monster2)
		doSummonCreature("Crypt Shambler", monster3)
		doSummonCreature("Crypt Shambler", monster4)
	elseif itemEx.itemid == 8288 and itemEx.actionid == 8282 and (randomizer == 2) and queststatus2 == 1 then
		doSummonCreature("Giant Spider", monster1)
		doSummonCreature("Giant Spider", monster4)
	elseif itemEx.itemid == 8288 and itemEx.actionid == 8282 and (randomizer == 3) and queststatus2 == 1 then
		doSummonCreature("Blightwalker", monster1)
		setPlayerStorageValue(cid,8282,-1)
		setPlayerStorageValue(cid,8383,1)
	elseif itemEx.itemid == 8288 and itemEx.actionid == 8282 and (randomizer >= 4) and queststatus2 == 1 then
		doSendMagicEffect(playerPos, 45)
		doCreatureAddHealth(cid, -300)
		doSendAnimatedText(playerPos, '300', TEXTCOLOR_LIGHTGREEN)
		end
	if itemEx.itemid == 8288 and itemEx.actionid == 8282 and queststatus2 == -1 then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		end
	if itemEx.itemid == 8290 and itemEx.actionid == 8383 and (randomizer == 1) and queststatus3 == 1 then
		doSummonCreature("Crypt Shambler", monster1)
		doSummonCreature("Crypt Shambler", monster2)
		doSummonCreature("Crypt Shambler", monster3)
		doSummonCreature("Crypt Shambler", monster4)
	elseif itemEx.itemid == 8290 and itemEx.actionid == 8383 and (randomizer == 2) and queststatus3 == 1 then
		doSummonCreature("Lich", monster1)
		doSummonCreature("Lich", monster2)
		doSummonCreature("Lich", monster3)
		doSummonCreature("Lich", monster4)
	elseif itemEx.itemid == 8290 and itemEx.actionid == 8383 and (randomizer == 3) and queststatus3 == 1 then
		doSummonCreature("Plaguesmith", monster1)
		setPlayerStorageValue(cid,8383,-1)
		setPlayerStorageValue(cid,8484,1)
	elseif itemEx.itemid == 8290 and itemEx.actionid == 8383 and (randomizer >= 4) and queststatus3 == 1 then
		doSendMagicEffect(playerPos, 45)
		doCreatureAddHealth(cid, -300)
		doSendAnimatedText(playerPos, '300', TEXTCOLOR_LIGHTGREEN)
		end
	if itemEx.itemid == 8290 and itemEx.actionid == 8383 and queststatus3 == -1 then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		end
	if itemEx.itemid == 8291 and itemEx.actionid == 8484 and (randomizer == 1) and queststatus4 == 1 then
		doSummonCreature("Crypt Shambler", monster1)
		doSummonCreature("Crypt Shambler", monster2)
		doSummonCreature("Crypt Shambler", monster3)
		doSummonCreature("Crypt Shambler", monster4)
	elseif itemEx.itemid == 8291 and itemEx.actionid == 8484 and (randomizer == 2) and queststatus4 == 1 then
		doSummonCreature("Lich", monster1)
		doSummonCreature("Lich", monster2)
		doSummonCreature("Giant Spider", monster2)
		doSummonCreature("Giant Spider", monster3)
	elseif itemEx.itemid == 8291 and itemEx.actionid == 8484 and (randomizer == 3) and queststatus4 == 1 then
		doSummonCreature("Demon", monster1)
		doSummonCreature("Juggernaut", monster2)
		setPlayerStorageValue(cid,8484,-1)
		setPlayerStorageValue(cid,8585,1)
	elseif itemEx.itemid == 8291 and itemEx.actionid == 8484 and (randomizer >= 4) and queststatus4 == 1 then
		doSendMagicEffect(playerPos, 45)
		doCreatureAddHealth(cid, -300)
		doSendAnimatedText(playerPos, '300', TEXTCOLOR_LIGHTGREEN)
		end
	if itemEx.itemid == 8291 and itemEx.actionid == 8484 and queststatus4 == -1 then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		end
end