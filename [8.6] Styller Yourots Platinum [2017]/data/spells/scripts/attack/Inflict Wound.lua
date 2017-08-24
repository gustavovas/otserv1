local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 0)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, true)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)


local condition = createConditionObject(CONDITION_PHYSICAL)

setConditionParam(condition, CONDITION_PARAM_DELAYED, 10)

addDamageCondition(condition, 15, 2000, -50)

setCombatCondition(combat, condition)


function onCastSpell(cid, var)
	local storage = 24009
	local spellname = "Inflict Wound"
	local time = 30

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." segundos.")
        end
end