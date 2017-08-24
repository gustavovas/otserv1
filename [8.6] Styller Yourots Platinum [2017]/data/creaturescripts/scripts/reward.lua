-- Credits to LeozeraRox
function onDeath(cid, corpse, deathList)
if isPlayer(cid) and isPlayer(deathList[1]) then
local v = { 
rewardid = 5943,
killer_name = getCreatureName(deathList[1]),
killer_level = getPlayerLevel(deathList[1]), 
target_name = getCreatureName(cid), 
target_level = getPlayerLevel(cid),
pos = getCreaturePosition(cid),
text = 'TO HELL!'
} 
local reward = doPlayerAddItem(deathList[1], v.rewardid, 1)
doItemSetAttribute(reward, "description", "Killed at level " .. v.target_level .. " by " .. v.killer_name .. " I was at level " .. v.killer_level .. " when. " .. (getCreatureSkullType(cid) <= SKULL_GREEN and "[Not-Justified]" or "[Justified]"))
doItemSetAttribute(reward, "name", v.target_name .."'s Heart")
doPlayerSendTextMessage(deathList[1], MESSAGE_STATUS_CONSOLE_ORANGE, "You killed ".. v.target_name .." " .. (getCreatureSkullType(cid) <= SKULL_GREEN and "wrong." or "just."))
doSendAnimatedText(v.pos, v.text, TEXTCOLOR_RED)
end
return true
end