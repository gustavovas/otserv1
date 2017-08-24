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

local price = 50000
local vocations = {5,6,7,8}

if(msgcontains(msg, 'second promote') or msgcontains(msg, 'second promotion')) then 
selfSay('Você quer receber a second promotion por '..price..' gps? {yes} ', cid) 
talkState[talkUser] = 1 
elseif msgcontains(msg, 'yes') and talkState[talkUser] == 1 then
if isInArray(vocations, getPlayerVocation(cid)) then  
if doPlayerRemoveMoney(cid,price) == TRUE then
setPlayerPromotionLevel(cid, 2)
selfSay('Parabens,você foi promovido para a Vocação VIP!', cid) 
talkState[talkUser] = 0 
else 
selfSay('Você não tem ' .. price .. ' gps para ser promovido', cid) 
talkState[talkUser] = 0 
end
else
selfSay('Desculpe, mais você não possui a primeira promotion.', cid) 
talkState[talkUser] = 0 
end
elseif msg == "no" and talkState[talkUser] >= 1 then 
selfSay("Then not", cid) 
talkState[talkUser] = 0 
npcHandler:releaseFocus(cid) 
end 
return TRUE 
end 

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback) 
npcHandler:addModule(FocusModule:new())