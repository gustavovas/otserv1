local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)
setHealingFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 11, 15)

function onCastSpell(cid, var)
	local storage = 23012
	local spellname = "Intense Wound Cleansing"
	local time = 600

        if exhaustion.check(cid, storage) == false then
                exhaustion.set(cid, storage, time)
                return doCombat(cid, combat, var) and doCombat(cid, combat, var) and doRemoveCondition(cid, CONDITION_PARALYZE)
        else
                doPlayerSendCancel(cid, "You are exhausted in " .. spellname .. " for: " ..exhaustion.get(cid, storage).." seconds.")
        end
end
