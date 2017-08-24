local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setHealingFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 18.5, 25)

function onCastSpell(cid, var)
	local storage = 23016
	local spellname = "Salvation"
	local time = 5

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var) and doCombat(cid, combat, var)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." segundos.")
        end
end
