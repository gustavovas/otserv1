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
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
local msg = string.lower(msg)
local itemid,count = 9020,5 -- edite o id e count do item aqui
if isInArray({"recover","recuperar","exp","experience"}, msg) then
npcHandler:say("você deseja recuperar a exp perdida após á sua morte por "..count.." "..getItemNameById(itemid).."? {yes}", cid)
talkState[talkUser] = 1
elseif (msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
if getPlayerStorageValue(cid, death_tabble.before_exp)  ~= -1 and getPlayerExperience(cid) < getPlayerStorageValue(cid, death_tabble.before_exp) then
if doPlayerRemoveItem(cid, itemid, count) == TRUE then
local count = (getPlayerStorageValue(cid, death_tabble.before_exp) - getPlayerStorageValue(cid, death_tabble.after_exp))
doPlayerAddExp(cid, count)
npcHandler:say("Obrigado! aqui está sua experiência.", cid)
else
npcHandler:say("Desculpe, você não tem "..getItemNameById(itemid).." suficientes!", cid)
talkState[talkUser] = 0
end
else
npcHandler:say("Desculpe, você não morreu ou já recuperou sua exp perdida!", cid)
talkState[talkUser] = 0
end
elseif msg == "no" then  
selfSay("Then not", cid)  
talkState[talkUser] = 0  
npcHandler:releaseFocus(cid)  
end
return TRUE
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())