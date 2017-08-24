local c = {
   [{1,5}] = { -- this is the Mage (sorcerer) part...
     [25] = {items = {{itemid = 2160, count = 2}}, storage = 40953},
     [40] = {items = {{itemid = 11297, count = 1}}, storage = 40954},
     [45] = {items = {{itemid = 2268, count = 1}}, storage = 40955},
     [60] = {items = {{itemid = 8867, count = 1}}, storage = 40956},
     [90] = {items = {{itemid = 8306, count = 1}}, storage = 40969},
     [120] = {items = {{itemid = 8902, count = 1}, {itemid = 7590, count = 10}}, storage = 40958},
     [200] = {items = {{itemid = 9693, count = 1}}, storage = 40959}
   },
   [{2,6}] = { -- these are the Druid items...
     [25] = {items = {{itemid = 2160, count = 2}}, storage = 40953},
     [40] = {items = {{itemid = 11297, count = 1}}, storage = 40954},
     [45] = {items = {{itemid = 2268, count = 1}}, storage = 40955},
     [60] = {items = {{itemid = 8867, count = 1}}, storage = 40956},
     [90] = {items = {{itemid = 8306, count = 1}}, storage = 40969},
     [120] = {items = {{itemid = 8902, count = 1}, {itemid = 7590, count = 10}}, storage = 40958},
     [200] = {items = {{itemid = 9693, count = 1}}, storage = 40959}
   },
   [{3,7}] = { -- These are the pally items...
     [25] = {items = {{itemid = 2160, count = 2}}, storage = 40953},
     [40] = {items = {{itemid = 11297, count = 1}}, storage = 40954},
     [60] = {items = {{itemid = 8850, count = 1}}, storage = 40955},
     [90] = {items = {{itemid = 8306, count = 1}}, storage = 40969},
     [120] = {items = {{itemid = 2500, count = 1}, {itemid = 6529, count = 1}}, storage = 40957},
     [200] = {items = {{itemid = 9693, count = 1}}, storage = 40959}
   },
   [{4,8}] = { -- These are the Knight items...
     [25] = {items = {{itemid = 2160, count = 2}}, storage = 40953},
     [40] = {items = {{itemid = 11297, count = 1}}, storage = 40957},
     [60] = {items = {{itemid = 11301, count = 1}}, storage = 40959},
	 [90] = {items = {{itemid = 8306, count = 1}}, storage = 40969},
	 [120] = {items = {{itemid = 7429, count = 1}, {itemid = 12610, count = 1}, {itemid = 7455, count = 1}}, storage = 40961},
	 [200] = {items = {{itemid = 9693, count = 1}}, storage = 40962}
   }
}
function onAdvance(cid, skill, oldlevel, newlevel)
         if skill ~= SKILL__LEVEL then
             return true
         end
         for voc, x in pairs(c) do
             if isInArray(voc, getPlayerVocation(cid)) then
                     for level, z in pairs(x) do
                         if newlevel >= level and getPlayerStorageValue(cid, z.storage) ~= 1 then -- edit it to the level you want (i left it blank..)
                    local text = ""
                    for v = 1, #z.items do
                        count, info = z.items[v].count, getItemInfo(z.items[v].itemid)
                        local ret = ", "
                        if v == 1 then
                            ret = ""
                        elseif v == #z.items then
                            ret = " and "
                        end
                        text = text .. ret
                        text = text .. (count > 1 and count or info.article).." "..(count > 1 and info.plural or info.name)
                        doPlayerAddItem(cid, z.items[v].itemid, z.items[v].count)
                    end
                                 doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_BLUE,"Congratulations, you have reached level "..level.." and received "..text..".")
                                 doSendMagicEffect(getPlayerPosition(cid), CONST_ME_FIREWORK_YELLOW)
                                 setPlayerStorageValue(cid, z.storage, 1)
                         end
                     end
             end
         end
         return true
end
