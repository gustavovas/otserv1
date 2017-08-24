--[[
Script By mock the bear
Config
]]
function choose(...)
   local arg = {...}
   return arg[math.random(1,#arg)]
end
local conf = {
	effectlist = {12,13,14,3,28,29,30,39,68},
	soulPerSec=1,
	soulToStart=25,
	allPercent=5,
}
---Load combat
local combat  = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, -1)
setConditionParam(condition, CONDITION_PARAM_SUBID, 49)
local cond = {
	CONDITION_PARAM_STAT_MAXHEALTHPERCENT = 31,
	CONDITION_PARAM_STAT_MAXMANAPERCENT = 32,
	CONDITION_PARAM_STAT_MAGICLEVELPERCENT = 34,
	CONDITION_PARAM_SKILL_MELEEPERCENT = 35,
	CONDITION_PARAM_SKILL_FISTPERCENT = 36,
	CONDITION_PARAM_SKILL_CLUBPERCENT = 37,
	CONDITION_PARAM_SKILL_SWORDPERCENT = 38,
	CONDITION_PARAM_SKILL_AXEPERCENT = 39,
	CONDITION_PARAM_SKILL_DISTANCEPERCENT = 40,
	CONDITION_PARAM_SKILL_SHIELDPERCENT = 41,
}
for i,b in pairs(cond) do
	setConditionParam(condition, b, 100+conf.allPercent)
end
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setCombatCondition(combat, condition)
local function rot(cid,n) --- Script by mock
   local tb_rot = {{0,2},{6,5},{1,3},{7,4},false}
   if not isPlayer(cid) or tb_rot[n] == nil or getPlayerSoul(cid) == 0 or getPlayerStorageValue(cid,32481) == -1 then
      return false
   end
   if tb_rot[n] == false then
      doSendMagicEffect(getPosByDir(getCreaturePosition(cid), tb_rot[1][1]) , choose(unpack(conf.effectlist)))
      doSendMagicEffect(getPosByDir(getCreaturePosition(cid), tb_rot[1][2]) ,choose(unpack(conf.effectlist)))
      addEvent(rot, 200,cid,2)
      return false
   end
   doSendMagicEffect(getPosByDir(getCreaturePosition(cid), tb_rot[n][1]) , choose(unpack(conf.effectlist)))
   doSendMagicEffect(getPosByDir(getCreaturePosition(cid), tb_rot[n][2]) , choose(unpack(conf.effectlist)))
   n = n+1
   addEvent(rot, 200,cid,n)
end
function checkBuff(cid)
	if not isPlayer(cid) then return end
	if getPlayerSoul(cid) > 0 and getPlayerStorageValue(cid,32481) == 1 then
		doPlayerAddSoul(cid,-conf.soulPerSec)
		doSendMagicEffect(getCreaturePosition(cid) , 49)
		addEvent(checkBuff,1000,cid)
	else
		doRemoveCondition(cid, CONDITION_ATTRIBUTES,49)
		setPlayerStorageValue(cid,32481,-1)
		return false
	end
end
function onSay(cid, words, param, channel) --- Script by mock
	if getPlayerStorageValue(cid,32481) == 1 then
		setPlayerStorageValue(cid,32481,-1)
		doCreatureSay(cid,'BERSERK MODE OFF!',19)
		return true
	end
	if getPlayerSoul(cid) >= conf.soulToStart then
		doPlayerAddSoul(cid,-conf.soulToStart)
		setPlayerStorageValue(cid,32481,1)
		checkBuff(cid)
		rot(cid,1)
		doCreatureSay(cid,'BERSERK MODE ON!',19)
		doCombat(cid, combat, numberToVariant(cid))
	else
		doPlayerSendTextMessage(cid,25,'You need more than 25 soul!')
	end
	return true
end