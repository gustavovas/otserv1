local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_POISONAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_POISON)

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 5, 3000, -45)
addDamageCondition(condition, 10, 3000, -35)
addDamageCondition(condition, 15, 3000, -25)
addDamageCondition(condition, 20, 3000, -15)
addDamageCondition(condition, 25, 3000, -5)
setCombatCondition(combat, condition)


function onCastSpell(cid, var)
	local storage = 23007
	local spellname = "Envenom"
	local time = 40

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." segundos.")
        end
end