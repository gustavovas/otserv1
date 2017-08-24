local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_SUBID, 1)
setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setConditionParam(condition, CONDITION_PARAM_TICKS, 1 * 60 * 1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 20)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 3000)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	local storage = 23015
	local spellname = "Recovery"
	local time = 60

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." segundos.")
        end
end
