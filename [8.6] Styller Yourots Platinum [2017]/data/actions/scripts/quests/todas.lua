local quests =
{


[2432] = {
storageId = 12070,
rewardId = 2432,
count = 1
},


[8166] = {
storageId = 12071,
rewardId = 2160,
count = 1
},


[8168] = {
storageId = 12072,
rewardId = 2438,
count = 1
},


[8167] = {
storageId = 12073,
rewardId = 2392,
count = 1
},


[8169] = {
storageId = 12074,
rewardId = 2323,
count = 1
},


[8170] = {
storageId = 12075,
rewardId = 2477,
count = 1
},


[8171] = {
storageId = 12076,
rewardId = 2516,
count = 1
},


[8172] = {
storageId = 12077,
rewardId = 2517,
count = 1
},


[8173] = {
storageId = 12078,
rewardId = 2492,
count = 1
},


[8174] = {
storageId = 12079,
rewardId = 8852,
count = 1
},


[2175] = {
storageId = 12080,
rewardId = 2195,
count = 1
},


[8176] = {
storageId = 12081,
rewardId = 8867,
count = 1
},


[8177] = {
storageId = 12083,
rewardId = 8904,
count = 1
},

[8178] = {
storageId = 12084,
rewardId = 11296,
count = 1
},

[8179] = {
storageId = 12085,
rewardId = 12606,
count = 1
},

[8180] = {
storageId = 12086,
rewardId = 11301,
count = 1
},

[8181] = {
storageId = 12087,
rewardId = 11296,
count = 1
},

[8182] = {
storageId = 12088,
rewardId = 11298,
count = 1
},

[8183] = {
storageId = 12089,
rewardId = 11350,
count = 1
},

[8184] = {
storageId = 12090,
rewardId = 2495,
count = 1
},

[8185] = {
storageId = 12091,
rewardId = 11138,
count = 1
},

[8186] = {
storageId = 12092,
rewardId = 7730,
count = 1
},

[8187] = {
storageId = 12093,
rewardId = 2160,
count = 2
},

[1750] = {
storageId = 12094,
rewardId = 2519,
count = 1
},
}

function useQuestChest(cid, quest)
local queststatus = getPlayerStorageValue(cid, quest.storageId)
if queststatus == -1 then
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You have found a " .. getItemNameById(quest.rewardId) .. ".")
doPlayerAddItem(cid, quest.rewardId, quest.count)
setPlayerStorageValue(cid, quest.storageId, 1)
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "It is empty.")
end
end

function onUse(cid, item, frompos, item2, topos)
if quests[item.uid] ~= nil then
useQuestChest(cid, quests[item.uid])
end
return TRUE
end