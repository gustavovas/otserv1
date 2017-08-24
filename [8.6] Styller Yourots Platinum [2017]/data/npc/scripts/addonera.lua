local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg) end
function onThink()					npcHandler:onThink() end
 
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)
 
--citizen addon
shopModule:addBuyableItem({'Minotaur leather'}, 5878, 100)
shopModule:addBuyableItem({'Chicken feather'}, 5890, 100)
shopModule:addBuyableItem({'Honeycomb'}, 5902, 500)
shopModule:addBuyableItem({'Lizard Scales'}, 5881, 500)
shopModule:addBuyableItem({'Legion helmet'}, 2480, 10000)
 
--hunter addon
shopModule:addBuyableItem({'Sniper gloves'}, 5875, 10000)
shopModule:addBuyableItem({'Nose Ring'}, 5804, 90000)
shopModule:addBuyableItem({'Enchanted chicken wings'}, 5891, 35000)
shopModule:addBuyableItem({'Piece of royal steel'}, 5887, 25000)
shopModule:addBuyableItem({'Piece of draconian steel'}, 5889, 25000)
shopModule:addBuyableItem({'Piece of hell steal'}, 5888, 25000)
shopModule:addBuyableItem({'Red dragon leather'}, 5948, 1000)
shopModule:addBuyableItem({'Lizard leather'}, 5876, 200)
shopModule:addBuyableItem({'Elanes crossbow'}, 5947, 100000)
 
--mage addon
shopModule:addBuyableItem({'Ankh'}, 2193, 200)
 
--knight addon
shopModule:addBuyableItem({'Damaged steel helmet'}, 5924, 50000)
shopModule:addBuyableItem({'Huge chunk of crude iron'}, 5892, 57000)
shopModule:addBuyableItem({'Perfect behemoth fang'}, 5893, 4500)
shopModule:addBuyableItem({'Warrior sweat'}, 5885, 20000)
shopModule:addBuyableItem({'Iron ore'}, 5880, 1000)
 
--nobleman addon
--Only money
 
--summoner addon
shopModule:addBuyableItem({'Vampire dust'}, 5905, 3000)
shopModule:addBuyableItem({'Giant spider silk'}, 5879, 5000)
shopModule:addBuyableItem({'Holy orshid'}, 5922, 3000)
shopModule:addBuyableItem({'Ape fur'}, 5883, 800)
shopModule:addBuyableItem({'Red piece of cloth'}, 5911, 5000)
shopModule:addBuyableItem({'Bat wing'}, 5894, 500)
shopModule:addBuyableItem({'Soul stone'}, 5809, 1000000)
 
--warrior addon
shopModule:addBuyableItem({'Dragon claw'}, 5919, 1000000)
shopModule:addBuyableItem({'Turtle shell'}, 5899, 600)
shopModule:addBuyableItem({'Fighting spirit'}, 5884, 60000)
shopModule:addBuyableItem({'Hardened bones'}, 5925, 1000)
 
--barbarian addon
shopModule:addBuyableItem({'Green piece of cloth'}, 5910, 1000)
 
--druid addon
shopModule:addBuyableItem({'Bear Paw'}, 5896, 100)
shopModule:addBuyableItem({'Wolf Paw'}, 5897, 100)
shopModule:addBuyableItem({'waterhose'}, 5938, 2000)
shopModule:addBuyableItem({'ceiron wolf tooth chain.'}, 5940, 3000)
shopModule:addBuyableItem({'Demon Dust'}, 5906, 10000) 
 
--wizard addon
shopModule:addBuyableItem({'Holy Orchid'}, 5922, 2000) 
 
--oriental addon
shopModule:addBuyableItem({'Mermaid Comb'}, 5945, 200000) 
shopModule:addBuyableItem({'Fish Fin'}, 5895, 3000) 
shopModule:addBuyableItem({'Blue Piece of Cloth'}, 5912, 1000) 
 
--pirate addon
shopModule:addBuyableItem({'Eye Patch'}, 6098, 1000) 
shopModule:addBuyableItem({'Hook'}, 6097, 1000) 
shopModule:addBuyableItem({'Peg leg'}, 6126, 1000) 
shopModule:addBuyableItem({'Ron the Ripper sabre'}, 6101, 150000) 
shopModule:addBuyableItem({'Lethal Lissy Shirt'}, 6100, 150000) 
shopModule:addBuyableItem({'Brutus Bloodbeard hat'}, 6099, 150000) 
shopModule:addBuyableItem({'Deadeye Devious Eye Patch'}, 6102, 150000) 
 
--assassin addon
shopModule:addBuyableItem({'White Piece of Cloth'}, 5909, 1000) 
shopModule:addBuyableItem({'Red Piece of Cloth'}, 5911, 2000) 
shopModule:addBuyableItem({'Brown Piece of Cloth'}, 5913, 1000) 
shopModule:addBuyableItem({'Yellow Piece of Cloth'}, 5914, 2000) 
shopModule:addBuyableItem({'Green Piece of Cloth'}, 5910, 1000) 
shopModule:addBuyableItem({'Behemoth Claw'}, 5930, 4000) 
 
--beggar addon
shopModule:addBuyableItem({'Heaven Blossom'}, 5921, 300) 
shopModule:addBuyableItem({'Simon the beggar favorite staff'}, 6107, 15000) 
 
--shaman addon
shopModule:addBuyableItem({'Mandrake'}, 5015, 700000) 
shopModule:addBuyableItem({'Tribal Mask'}, 3967, 6000) 
shopModule:addBuyableItem({'Banana Staff'}, 3966, 4000) 
shopModule:addBuyableItem({'Voodoo Doll'}, 3955, 1000)
shopModule:addBuyableItem({'Green Dragon Scales'}, 5920, 600)
shopModule:addBuyableItem({'Red Dragon Scales'}, 5882, 600) 
shopModule:addBuyableItem({'Pirate Voodoo Doll'}, 5810, 1000) 
 
--norseman addon
shopModule:addBuyableItem({'Shard'}, 7290, 2000) 
 
--nightmare addon
 
--jester addon
--Already Sold
 
--brotherhood addon
--Already Sold
 
--demonhunter addon
shopModule:addBuyableItem({'Demon Horn'}, 5954, 3500) 
shopModule:addBuyableItem({'Talon'}, 2151, 600) 
 
--yalaharian addon
shopModule:addBuyableItem({'Vampiric Crest'}, 9955, 70000) 
 
--warmaster addon
shopModule:addBuyableItem({'Tribal Crest'}, 11111, 350000) 
shopModule:addBuyableItem({'Serpent Crest'}, 11112, 350000)
 
--wayfarer addon
--Quest
 
 
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())