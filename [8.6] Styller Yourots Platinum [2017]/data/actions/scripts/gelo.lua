function onUse(cid, item, frompos, item2, topos)

item1pos = {x=995, y=1001, z=8, stackpos=255} --posi��o da arma normal
item3pos = {x=993, y=1001, z=8, stackpos=255} --posi��o em que arma de gelo aparecer�
item1 = getThingfromPos(item1pos)
item3 = getThingfromPos(item3pos)


if item.itemid == 1945 and item1.itemid == 2383 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7763,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7383 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7764,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7384 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7765,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7406 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7766,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7402 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7767,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2429 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7768,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2430 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7769,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7389 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7770,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7380 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7771,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2454 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7772,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2423 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7773,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2445 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7774,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7415 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7775,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 7392 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7776,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.itemid == 1945 and item1.itemid == 2391 then
doRemoveItem(item1.uid,1)
doSendMagicEffect(item1pos,13)
doTransformItem(item.uid,item.itemid+1)
doCreateItem(7777,1, item3pos)
doSendMagicEffect(item3pos,13)

elseif item.uid == 9011 and item.itemid == 1946 then
doTransformItem(item.uid,item.itemid-1)
else
return 0
end

return 1

end