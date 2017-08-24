local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ICEATTACK)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 2, 5, 2)

function onCastSpell(cid, var)
	local storage = 23020
	local spellname = "Strong Ice Strike"
	local time = 8

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var) and doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "")
        end
end
