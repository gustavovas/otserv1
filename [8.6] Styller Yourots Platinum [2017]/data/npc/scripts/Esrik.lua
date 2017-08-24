local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)



shopModule:addBuyableItem({'Drakinata'}, 11299, 10000, 'Drakinata')
shopModule:addBuyableItem({'Twin Hooks'}, 11303, 2, 'Twin Hooks')
shopModule:addBuyableItem({'Zaoan Halberd'}, 11317, 500, 'Zaoan Halberd')
shopModule:addBuyableItem({'Zaoan Sword'}, 11301, 30000, 'Zaoan Sword')
shopModule:addBuyableItem({'Dragon Scale Boots'}, 11114, 40000, 'Dragon Scale Boots')
shopModule:addBuyableItem({'Guardian Boots'}, 11234, 35000, 'Guardian Boots')
shopModule:addBuyableItem({'Zaoan Shoes'}, 11297, 5000, 'Zaoan Shoes')
shopModule:addBuyableItem({'Drachaku'}, 11302, 10000, 'Drachaku')
shopModule:addBuyableItem({'Broken Halberd'}, 11329, 100, 'Broken Halberd')
shopModule:addBuyableItem({'Cursed Shoulder Spikes'}, 11321, 320, 'Cursed Shoulder Spikes')
shopModule:addBuyableItem({'Legionnaire Flags'}, 11328, 500, 'Legionnaire Flags')
shopModule:addBuyableItem({'Sais'}, 11300, 16500, 'Sais')
shopModule:addBuyableItem({'Spiked Iron Ball'}, 11319, 100, 'Spiked Iron Ball')

shopModule:addSellableItem({'two handed sword'}, 2377, 950, 'two handed sword')
shopModule:addSellableItem({'broad sword'}, 2413, 950, 'broad sword')
shopModule:addSellableItem({'sword'}, 2376, 85, 'sword')
shopModule:addSellableItem({'crimson sword'}, 7385, 610, 'crimson sword')
shopModule:addSellableItem({'dagger'}, 2379, 5, 'dagger')
shopModule:addSellableItem({'rapier'}, 2384, 15, 'rapier')
shopModule:addSellableItem({'sabre'}, 2385, 35, 'sabre')

shopModule:addSellableItem({'battle hammer'}, 2417, 350, 'battle hammer')
shopModule:addSellableItem({'clerical mace'}, 2423, 540, 'clerical mace')
shopModule:addSellableItem({'mace'}, 2398, 90, 'mace')
shopModule:addSellableItem({'morning star'}, 2394, 430, 'morning star')

shopModule:addSellableItem({'hand axe'}, 2380, 8, 'hand axe')
shopModule:addSellableItem({'axe'}, 2386, 20, 'hand axe')
shopModule:addSellableItem({'barbarian axe'}, 2429, 590, 'barbarian axe')
shopModule:addSellableItem({'battle axe'}, 2378, 235, 'battle axe')

shopModule:addSellableItem({'leather helmet'}, 2461, 12, 'leather helmet')
shopModule:addSellableItem({'chain helmet'}, 2458, 52, 'chain helmet')
shopModule:addSellableItem({'chain legs'},2648, 80, 'chain legs')

shopModule:addSellableItem({'wooden shield'}, 2512, 15, 'wooden shield')
shopModule:addSellableItem({'steel shield'}, 2509, 240, 'steel shield')
shopModule:addSellableItem({'viking shield'}, 2531, 260, 'viking shield')

shopModule:addSellableItem({'chain legs'},2648, 80, 'chain legs')

shopModule:addSellableItem({'brass armor'}, 2465, 450, 'brass armor')
shopModule:addSellableItem({'chain armor'}, 2464, 200, 'chain armor')
shopModule:addSellableItem({'leather armor'}, 2467, 35, 'leather armor')
shopModule:addSellableItem({'scale armor'}, 2483, 260, 'scale armor')


npcHandler:addModule(FocusModule:new())