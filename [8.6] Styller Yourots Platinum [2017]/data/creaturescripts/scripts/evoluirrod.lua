local items = {
{13,2191,2186,-1},
{19,2188,2185,0},
{22,8921,8911,1},
{26,2189,2181,2},
{33,2187,2183,3},
{37,8920,8912,4},
{45,8922,8910,5},
{99999999999}
}
local stuff = {2190,2182,2191,2188,8921,2189,2187,8920,8922,2186,2185,8911,2181,2183,8912,8910}
function onAdvance(cid, skill, oldlevel, newlevel)
local place = 0
local st = 23636
local blala = newLevel
if isInArray({1,2,5,6},getPlayerVocation(cid)) then
if skill == 8 then
for x = 1, #items do
if newlevel >= items[x][1] and newlevel < items[x+1][1] then
place = x
end
end
if place > 0 then
if getPlayerStorageValue(cid,st) <= items[place][4] then
local byvoc = getPlayerVocation(cid)
if getPlayerVocation(cid) > 4 then
byvoc = getPlayerVocation(cid)-4
end
if isInArray(stuff,getPlayerSlotItem(cid,5).itemid) then
doRemoveItem(getPlayerSlotItem(cid,5).uid)
elseif isInArray(stuff,getPlayerSlotItem(cid,6).itemid) then
doRemoveItem(getPlayerSlotItem(cid,6).uid)
end
doPlayerAddItem(cid,items[place][byvoc+1],1)
doPlayerSendTextMessage(cid,4,"Você evoluiu e ganhou uma nova wand: "..getItemNameById(items[place][byvoc+1])..".")
setPlayerStorageValue(cid,st,items[place][4]+1)
end
end
end
end
return TRUE
end