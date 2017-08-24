function onEquip(cid, item, position, fromPosition)
doPlayerSetExperienceRate(cid, 1.2)
return TRUE
end
function onDeEquip(cid, item, position, fromPosition)
doPlayerSetExperienceRate(cid, 1)
return TRUE
end