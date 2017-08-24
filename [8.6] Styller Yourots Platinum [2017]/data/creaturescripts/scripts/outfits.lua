local hunter = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(hunter, CONDITION_PARAM_TICKS, -1)
setConditionParam(hunter, CONDITION_PARAM_SKILL_DISTANCE, 3)
 
local knight = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(knight, CONDITION_PARAM_TICKS, -1)
setConditionParam(knight, CONDITION_PARAM_SKILL_SWORD, 3)
 
local mage = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(mage, CONDITION_PARAM_TICKS, -1)
setConditionParam(mage, CONDITION_PARAM_STAT_MAGICLEVEL, 2)
 
local barbarian = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(barbarian, CONDITION_PARAM_TICKS, -1)
setConditionParam(barbarian, CONDITION_PARAM_SKILL_AXE, 3)
 
local norse = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(norse, CONDITION_PARAM_TICKS, -1)
setConditionParam(norse, CONDITION_PARAM_SKILL_SHIELD, 2)
 
local nightmare = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(norse, CONDITION_PARAM_TICKS, -1)
setConditionParam(norse, CONDITION_PARAM_SKILL_SHIELD, 3)
 
local speed1 = createConditionObject(CONDITION_HASTE)
setConditionParam(speed1, CONDITION_PARAM_TICKS, -1)
setConditionParam(speed1, CONDITION_PARAM_SPEED, 10)
 
local speed2 = createConditionObject(CONDITION_HASTE)
setConditionParam(speed2, CONDITION_PARAM_TICKS, -1)
setConditionParam(speed2, CONDITION_PARAM_SPEED, 20)
 
outfitBonusTable = { --- [] = {condition = , maxHealth = , maxMana = }
        [128] = {maxHealth = 100, condition = speed1, typ = CONDITION_HASTE}, [136] = {maxHealth = 100, condition = speed1, typ = CONDITION_HASTE}, --Citizen
        [129] = {condition = hunter}, [137] = {condition = hunter}, --Hunter
        [130] = {maxMana = 200}, [138] = {maxMana = 200}, --Mage
        [131] = {condition = knight}, [139] = {condition = knight}, --Knight
        [133] = {maxMana = 100}, [141] = {maxMana = 100}, --Summoner
        [134] = {condition = knight}, [142] = {condition = knight}, --Warrior
        [143] = {condition = barbarian}, [147] = {condition = barbarian}, --Barbarian
        [144] = {condition = mage}, [148] = {condition = mage}, --Druid
        [145] = {maxHealth = 100, maxMana = 100}, [149] = {maxHealth = 100, maxMana = 100}, --Wizard
        [146] = {maxHealth = 200, maxMana = 200, condition = speed1, typ = CONDITION_HASTE}, [150] = {maxHealth = 200, maxMana = 200, condition = speed1, typ = CONDITION_HASTE}, --Oriental
        [152] = {condition = speed2, typ = CONDITION_HASTE}, [156] = {condition = speed2, typ = CONDITION_HASTE}, --Assassin
        [154] = {condition = mage}, [158] = {condition = mage}, --Shaman
        [251] = {condition = norse, maxHealth = 200}, [252] = {condition = norse, maxHealth = 200}, --Norse
        [268] = {condition = nightmare, maxHealth = 100}, [269] = {condition = nightmare, maxHealth = 100}, --Nightmare
        [270] = {maxHealth = 100, maxMana = 100, condition = speed1, typ = CONDITION_HASTE}, [273] = {maxHealth = 100, maxMana = 100, condition = speed1, typ = CONDITION_HASTE}, --Jester
        [278] = {maxHealth = 200}, [279] = {maxHealth = 200}, --Brotherhood
        [288] = {maxHealth = 500, maxMana = 500, condition = speed2, typ = CONDITION_HASTE}, [289] = {maxHealth = 500, maxMana = 500, condition = speed2, typ = CONDITION_HASTE}, --Demonhunter
        [324] = {condition = mage, maxHealth = 200, maxMana = 200}, [325] = {condition = mage, maxHealth = 200, maxMana = 200} --Yalaharian
}
 
function onLogin(cid)
        registerCreatureEvent(cid, "Addons")
        local oldOutfit = getCreatureOutfit(cid)
 
        if (oldOutfit.lookAddons ~= 3) or (outfitBonusTable[oldOutfit.lookType] == nil) or ((outfitBonusTable[oldOutfit.lookType]).condition == nil) then
                return true
        end
        doAddCondition(cid, (outfitBonusTable[oldOutfit.lookType]).condition)
        return true
end
 
function onOutfit(cid, old, current)
        if old.lookAddons == 3 and outfitBonusTable[old.lookType] then --Bonus off
                if (outfitBonusTable[old.lookType]).maxHealth ~= nil then
                        setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) -(outfitBonusTable[old.lookType]).maxHealth)
                        doCreatureAddHealth(cid, -(outfitBonusTable[old.lookType]).maxHealth)
                                                doRemoveCondition(cid, CONDITION_INFIGHT)
                end
                if (outfitBonusTable[old.lookType]).maxMana ~= nil then
                        setCreatureMaxMana(cid, getCreatureMaxMana(cid) -(outfitBonusTable[old.lookType]).maxMana)
                        doCreatureAddMana(cid, -(outfitBonusTable[old.lookType]).maxMana)
                                                doRemoveCondition(cid, CONDITION_INFIGHT)
                end
                if (outfitBonusTable[old.lookType]).condition ~= nil then
                                        (outfitBonusTable[old.lookType]).typ = ( (outfitBonusTable[old.lookType]).typ == nil) and CONDITION_ATTRIBUTES or (outfitBonusTable[old.lookType]).typ
                                        doRemoveCondition(cid, (outfitBonusTable[old.lookType]).typ)
                end
        end
        if current.lookAddons == 3 and outfitBonusTable[current.lookType] then --Bonus on
                if (outfitBonusTable[current.lookType]).maxHealth ~= nil then
                        setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) +(outfitBonusTable[current.lookType]).maxHealth)
                        doCreatureAddHealth(cid, (outfitBonusTable[current.lookType]).maxHealth)
                end
                if (outfitBonusTable[current.lookType]).maxMana ~= nil then
                        setCreatureMaxMana(cid, getCreatureMaxMana(cid) +(outfitBonusTable[current.lookType]).maxMana)
                        doCreatureAddMana(cid, (outfitBonusTable[current.lookType]).maxMana)
                end
                if (outfitBonusTable[current.lookType]).condition ~= nil then
                        doAddCondition(cid, (outfitBonusTable[current.lookType]).condition)
                end
        end
        return true
end