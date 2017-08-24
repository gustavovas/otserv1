local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, true)

function onGetFormulaValues(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack * 2, level / 5 * 2
	return -(skillTotal / 3 + levelTotal), -(skillTotal + levelTotal)
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	local storage = 23001
	local spellname = "Brutal Strike"
	local time = 6

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." segundos.")
        end
end
