-- [( Script created by Doidin for XTibia.com )] --
function onUse(cid, item, fromPosition, item2, toPosisition)
local rskulls = {green = SKULL_GREEN, red = SKULL_RED, black = SKULL_BLACK}
if isInArray(rskulls, getPlayerSkullType(cid)) then doPlayerSendCancel(cid,"You don't remover your frags and skulls.") doSendMagicEffect(getPlayerPosition(cid), 2)else db.query("UPDATE `killers` SET `unjustified` = 0 WHERE `id` IN (SELECT `kill_id` FROM `player_killers` WHERE `player_id` = " .. getPlayerGUID(cid) .. ")") doCreatureSetSkullType(cid, 0) doCreatureSay(cid, "Your frags and skulls is cleaned!", 19) doSendMagicEffect(getPlayerPosition(cid), 26) doRemoveItem(item.uid, 1) return TRUE end end
