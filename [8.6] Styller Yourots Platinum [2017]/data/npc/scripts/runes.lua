local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 1, 'spellbook')
shopModule:addBuyableItem({'magic lightwand'}, 2163, 400, 1, 'magic lightwand')

shopModule:addBuyableItem({'small health'}, 8704, 20, 1, 'small health potion')
shopModule:addBuyableItem({'antidote potion'}, 8474, 50, 1, 'antidote potion')

shopModule:addSellableItem({'normal potion flask', 'normal flask'}, 7636, 5, 'empty small potion flask')
shopModule:addSellableItem({'strong potion flask', 'strong flask'}, 7634, 10, 'empty strong potion flask')
shopModule:addSellableItem({'great potion flask', 'great flask'}, 7635, 15, 'empty great potion flask')

shopModule:addBuyableItem({'blank rune'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'instense healing'}, 2265, 95, 1, 'intense healing rune')
shopModule:addBuyableItem({'ultimate healing'}, 2273, 75, 1, 'ultimate healing rune')
shopModule:addBuyableItem({'magic wall'}, 2293, 350, 1, 'magic wall rune')
shopModule:addBuyableItem({'wild growth'}, 2269, 350, 1, 'wild growth rune')
shopModule:addBuyableItem({'destroy field'}, 2261, 45, 1, 'destroy field rune')
shopModule:addBuyableItem({'light magic missile'}, 2287, 40, 1, 'light magic missile rune')
shopModule:addBuyableItem({'heavy magic missile'}, 2311, 120, 1, 'heavy magic missile rune')
shopModule:addBuyableItem({'great fireball'}, 2304, 180, 1, 'great fireball rune')
shopModule:addBuyableItem({'explosion'}, 2313, 250, 1, 'explosion rune')
shopModule:addBuyableItem({'sudden death'}, 2268, 95, 1, 'sudden death rune')
shopModule:addBuyableItem({'paralyze'}, 2278, 700, 1, 'paralyze rune')
shopModule:addBuyableItem({'animate dead'}, 2316, 375, 1, 'animate dead rune')
shopModule:addBuyableItem({'convince creature'}, 2290, 80, 1, 'convince creature rune')
shopModule:addBuyableItem({'chameleon'}, 2291, 210, 1, 'chameleon rune')
shopModule:addBuyableItem({'desintegrate'}, 2310, 80,  1, 'desintegreate rune')

shopModule:addBuyableItemContainer({'bp sd'}, 2003, 2268, 7020, 10, 'backpack of sudden deaths')
shopModule:addBuyableItemContainer({'bp hp'}, 2000, 7618, 900, 1, 'backpack of health potions')
shopModule:addBuyableItemContainer({'bp mp'}, 2001, 7620, 1000, 1, 'backpack of mana potions')
shopModule:addBuyableItemContainer({'bp shp'}, 2000, 7588, 2000, 1, 'backpack of strong health potions')
shopModule:addBuyableItemContainer({'bp smp'}, 2001, 7589, 1600, 1, 'backpack of strong mana potions')
shopModule:addBuyableItemContainer({'bp ghp'}, 2000, 7591, 3800, 1, 'backpack of great health potions')
shopModule:addBuyableItemContainer({'bp gmp'}, 2001, 7590, 2400, 1, 'backpack of great mana potions')
shopModule:addBuyableItemContainer({'bp gsp'}, 1999, 8472, 3800, 1, 'backpack of great spirit potions')
shopModule:addBuyableItemContainer({'bp uhp'}, 2000, 8473, 6200, 1, 'backpack of ultimate health potions')

shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 500, 1, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 1000, 1, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 5000, 1, 'wand of decay')
shopModule:addBuyableItem({'wand of draconia', 'draconia'}, 8921, 7500, 1, 'wand of draconia')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 10000, 1, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 15000, 1, 'wand of inferno')
shopModule:addBuyableItem({'wand of starstorm', 'starstorm'}, 8920, 18000, 1, 'wand of starstorm')
shopModule:addBuyableItem({'wand of voodoo', 'voodoo'}, 8922, 22000, 1, 'wand of voodoo')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 500, 1, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 1, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 5000, 1, 'necrotic rod')
shopModule:addBuyableItem({'northwind rod', 'northwind'}, 8911, 7500, 1, 'northwind rod')
shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 10000, 1, 'terra rod')
shopModule:addBuyableItem({'hailstorm rod', 'hailstorm'}, 2183, 15000, 1, 'hailstorm rod')
shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 18000, 1, 'springsprout rod')
shopModule:addBuyableItem({'underworld rod', 'underworld'}, 8910, 22000, 1,  'underworld rod')

shopModule:addSellableItem({'wand of vortex', 'vortex'}, 2190, 500, 'wand of vortex')
shopModule:addSellableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 1000, 'wand of dragonbreath')
shopModule:addSellableItem({'wand of decay', 'decay'}, 2188, 5000, 'wand of decay')
shopModule:addSellableItem({'wand of draconia', 'draconia'}, 8921, 7500, 'wand of draconia')
shopModule:addSellableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 10000, 'wand of cosmic energy')
shopModule:addSellableItem({'wand of inferno', 'inferno'}, 2187, 15000, 'wand of inferno')
shopModule:addSellableItem({'wand of starstorm', 'starstorm'}, 8920, 18000, 'wand of starstorm')
shopModule:addSellableItem({'wand of voodoo', 'voodoo'}, 8922, 22000, 'wand of voodoo')

shopModule:addSellableItem({'snakebite rod', 'snakebite'}, 2182, 500, 'snakebite rod')
shopModule:addSellableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 'moonlight rod')
shopModule:addSellableItem({'necrotic rod', 'necrotic'}, 2185, 5000, 'necrotic rod')
shopModule:addSellableItem({'northwind rod', 'northwind'}, 8911, 7500, 'northwind rod')
shopModule:addSellableItem({'terra rod', 'terra'}, 2181, 10000, 'terra rod')
shopModule:addSellableItem({'hailstorm rod', 'hailstorm'}, 2183, 15000, 'hailstorm rod')
shopModule:addSellableItem({'springsprout rod', 'springsprout'}, 8912, 18000, 'springsprout rod')
shopModule:addSellableItem({'underworld rod', 'underworld'}, 8910, 22000,  'underworld rod')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	local items = {[1] = 2190, [2] = 2182, [5] = 2190, [6] = 2182}
	if(msgcontains(msg, 'first rod') or msgcontains(msg, 'first wand')) then
		if(isSorcerer(cid) or isDruid(cid)) then
			if(getPlayerStorageValue(cid, 30002) == -1) then
				selfSay('So you ask me for a {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '} to begin your advanture?', cid)
				talkState[talkUser] = 1
			else
				selfSay('What? I have already gave you one {' .. getItemNameById(items[getPlayerVocation(cid)]) .. '}!', cid)
			end
		else
			selfSay('Sorry, you aren\'t a druid either a sorcerer.', cid)
		end
	elseif(msgcontains(msg, 'yes')) then
		if(talkState[talkUser] == 1) then
			doPlayerAddItem(cid, items[getPlayerVocation(cid)], 1)
			selfSay('Here you are young adept, take care yourself.', cid)
			setPlayerStorageValue(cid, 30002, 1)
		end
		talkState[talkUser] = 0
	elseif(msgcontains(msg, 'no') and isInArray({1}, talkState[talkUser]) == TRUE) then
		selfSay('Ok then.', cid)
		talkState[talkUser] = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
