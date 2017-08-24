local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser,msg = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid, msg:lower()
local config = {
level = 30,
hours = 24,
storage = 58485,
rewards = {{itemid = 2173,chance = 15},{itemid = 2645,chance = 25},{itemid = 2160,chance = 30}} -- itens que ele poderá ganhar 
}
function doAddReward()
a = true
while a == true do
local m = math.random(1,#config.rewards)
if config.rewards[m].chance > math.random(1, 100) then
doPlayerAddItem(cid, config.rewards[m].itemid, isItemStackable(config.rewards[m].itemid) and 100 or 1)
npcHandler:say("seu prêmio foi: "..getItemNameById(config.rewards[m].itemid), cid)
a = false
end
end
end
if isInArray({"presente","present"}, msg) then
if getPlayerLevel(cid) < config.level then
npcHandler:say("Desculpe, mas você precisa ter no minimo level "..config.level.." para receber sua recompensa diaria.", cid)
else
npcHandler:say("você deseja receber seu presente agora?! {yes}", cid)
talkState[talkUser] = 1
end
elseif (msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
if getPlayerStorageValue(cid,config.storage) <= os.time() then
doAddReward()
setPlayerStorageValue(cid, config.storage, os.time()+config.hours*3600)
else
npcHandler:say("Desculpe, mas você deve aguardar até "..os.date("%d %B %Y %X ", getPlayerStorageValue(cid,config.storage)).." para pegar seu presente novamente!", cid)
talkState[talkUser] = 0
end
elseif msg == "no" then  
selfSay("Then not", cid)  
talkState[talkUser] = 0  
npcHandler:releaseFocus(cid)  
end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())