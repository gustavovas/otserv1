local keywordHandler = KeywordHandler:new()   
local npcHandler = NpcHandler:new(keywordHandler)   
NpcSystem.parseParameters(npcHandler)   
   
function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end   
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end   
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end   
function onThink()                npcHandler:onThink()                end   
 
 
function GSS(cid, message, keywords, parameters, node)   
    if(not npcHandler:isFocused(cid)) then   
        return false   
    end   
        if getPlayerItemCount(cid,5879) >= 1 then   
        if doPlayerRemoveItem(cid,5879,10) then   
            npcHandler:say('Here is your spool of yarn!', cid)   
            doPlayerAddItem(cid,5886,1)   
        end   
        else   
            npcHandler:say('Sorry, you don\'t have the giant spider silk!', cid)   
   end      
end 


keywordHandler:addKeyword({'giant spider silk'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you wanna exchange a giant spider silk into a {spool of yarn}?.'}) 
 
local node1 = keywordHandler:addKeyword({'spool of yarn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Are you sure?'})   
    node1:addChildKeyword({'yes'}, GSS, {npcHandler = npcHandler, onlyFocus = true, reset = true})   
    node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Come back when you want.', reset = true})
        
        npcHandler:addModule(FocusModule:new())