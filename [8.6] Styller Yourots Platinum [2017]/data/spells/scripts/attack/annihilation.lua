local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)
setCombatParam(combat1, COMBAT_PARAM_USECHARGES, true)

function onGetFormulaValues(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack * 4, level / 5 * 4
	return -(skillTotal / 3 + levelTotal), -(skillTotal + levelTotal)
end

setCombatCallback(combat1, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
        if exhaustion.check(cid, 23000) == false then
                exhaustion.set(cid, 23000, 30)
                return doCombat(cid, combat1, var)
        else
                doPlayerSendCancel(cid, "You are exhausted.")
        end
end