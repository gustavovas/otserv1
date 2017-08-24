function onDeath(cid, corpse, killer)

registerCreatureEvent(cid, "inquisitionPortals")

local creaturename = getCreatureName(cid)

--- positions where the teleports will be created:

local madareth_in_pos = {x=603, y=586, z=9, stackpos=2}
local infernatil_in_pos = {x=59, y=124, z=7, stackpos=2}
local hellgorak_in_pos = {x=626, y=536, z=9, stackpos=2}
local ushuriel_in_pos = {x=604, y=586, z=9, stackpos=2}
local zugurosh_in_pos = {x=509, y=1190, z=7, stackpos=2}
local brothers_in_pos = {x=219, y=1041, z=7, stackpos=1}

--- positions where the teleports will be teleported you:

local madareth_to_pos = {x=211, y=292, z=9, stackpos=1}
local infernatil_to_pos = {x=22, y=112, z=8, stackpos=1}
local hellgorak_to_pos = {x=782, y=237, z=8, stackpos=1}
local ushuriel_to_pos = {x=211, y=292, z=9, stackpos=1}
local zugurosh_to_pos = {x=424, y=1119, z=7, stackpos=1}
local brothers_to_pos = {x=46, y=1109, z=7, stackpos=1}

local time_to_pass = 30 -- in seconds
local tpID = 1387
local doEffect = CONST_ME_TELEPORT
local message = "You now have 30 seconds to exit this room through the teleporter."

if creaturename == 'Madareth' then

teleport = doCreateTeleport(tpID, ushuriel_to_pos, ushuriel_in_pos)

doSendMagicEffect(ushuriel_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInushurielWard, (1000*time_to_pass))

elseif creaturename == 'Infernatil' then

teleport = doCreateTeleport(tpID, Infernatil_to_pos, 
Infernatil_in_pos)

doSendMagicEffect(Infernatil_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInInfernatilWard, (1000*time_to_pass))

elseif creaturename == 'Ushuriel' then

teleport = doCreateTeleport(tpID, ushuriel_to_pos, ushuriel_in_pos)

doSendMagicEffect(ushuriel_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInUshurielWard, (1000*time_to_pass))

elseif creaturename == 'Hellgorak' then

teleport = doCreateTeleport(tpID, hellgorak_to_pos, hellgorak_in_pos)

doSendMagicEffect(hellgorak_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInHellgorakWard, (1000*time_to_pass))

elseif creaturename == 'Zugurosh' then

teleport = doCreateTeleport(tpID, zugurosh_to_pos, zugurosh_in_pos)

doSendMagicEffect(zugurosh_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInZuguroshWard, (1000*time_to_pass))

elseif creaturename == 'Latrivan' then

teleport = doCreateTeleport(tpID, brothers_to_pos, brothers_in_pos)

doSendMagicEffect(brothers_in_pos, doEffect)

doCreatureSay(cid, message, TALKTYPE_ORANGE_1)

addEvent(removeTeleportInBrothersWard, (1000*time_to_pass))


end
end

function removeTeleportInMadarethWard()
if getThingfromPos({605, y=586, z=9, stackpos=2}).itemid == 1387 then
doRemoveItem(getThingfromPos({605, y=586, z=9, stackpos=1}).uid,1)
doSendMagicEffect({605, y=586, z=9, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end

function removeTeleportIninfernatilWard()
if getThingfromPos({x=59, y=124, z=7, stackpos=1}).itemid == 1387 then
doRemoveItem(getThingfromPos({x=59, y=124, z=7, stackpos=1}).uid,1)
doSendMagicEffect({x=59, y=124, z=7, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end

function removeTeleportInHellgorakWard()
if getThingfromPos({x=626, y=536, z=9, stackpos=1}).itemid == 1387 then
doRemoveItem(getThingfromPos({x=626, y=536, z=9, stackpos=1}).uid,1)
doSendMagicEffect({x=626, y=536, z=9, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end

function removeTeleportInUshurielWard()
if getThingfromPos({604, y=586, z=9, stackpos=2}).itemid == 1387 then
doRemoveItem(getThingfromPos({604, y=586, z=9, stackpos=1}).uid,1)
doSendMagicEffect({604, y=586, z=9, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end

function removeTeleportInZuguroshWard()
if getThingfromPos({x=509, y=1190, z=7, stackpos=2}).itemid == 1387 then
doRemoveItem(getThingfromPos({x=509, y=1190, z=7, stackpos=2}).uid,1)
doSendMagicEffect({x=509, y=1190, z=7, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end

function removeTeleportInBrothersWard()
if getThingfromPos({x=219, y=1041, z=7, stackpos=1}).itemid == 1387 then
doRemoveItem(getThingfromPos({x=219, y=1041, z=7, stackpos=1}).uid,1)
doSendMagicEffect({x=219, y=1041, z=7, stackpos=1}, CONST_ME_POFF)
return TRUE
end
end