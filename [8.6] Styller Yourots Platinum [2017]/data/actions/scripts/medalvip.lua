function onUse(cid, item, pos)
local days = 7
vip.addVipByAccount(getPlayerAccount(cid) ,vip.getDays(days))
doPlayerSendTextMessage(cid, 25, "Foram adicionados "..tonumber(days).." dias de vip na sua account. !vipdays")
doRemoveItem(item.uid, 1)
return true
end